with
detail as (
    select
        salesorderid,
        salesorderdetailid,
        orderqty,
        productid,
        specialofferid,
        unitprice,
        unitpricediscount,
        unitprice * orderqty as gross_sales,
        unitprice * orderqty * (1 - unitpricediscount) as net_sales
    from {{ source('adventure_works','sales_salesorderdetail') }}
),

header as (
    select
        salesorderid,
        to_date(orderdate) as orderdate,
        customerid,
        status,
        territoryid,
        cast(creditcardid as bigint) as creditcardid,
        cast(salespersonid as bigint) as salespersonid,
        shiptoaddressid
    from {{ source('adventure_works','sales_salesorderheader') }}
),

creditcard as (
    select
        creditcardid,
        cardtype
    from {{ source('adventure_works','sales_creditcard') }}
),

salesreason_bridge as (
    select
        salesorderid,
        salesreasonid
    from (
        select
            salesorderid,
            salesreasonid,
            row_number() over (
                partition by salesorderid
                order by salesreasonid
            ) as rn
        from {{ source('adventure_works','sales_salesorderheadersalesreason') }}
    ) x
    where rn = 1
),

salesreason as (
    select
        salesreasonid,
        name as salesreason_name
    from {{ source('adventure_works','sales_salesreason') }}
),

address as (
    select
        addressid,
        city,
        stateprovinceid
    from {{ source('adventure_works','person_address') }}
),

stateprovince as (
    select
        stateprovinceid,
        name as state_name,
        countryregioncode
    from {{ source('adventure_works','person_stateprovince') }}
),

countryregion as (
    select
        countryregioncode,
        name as country_name
    from {{ source('adventure_works','person_countryregion') }}
),

salesperson as (
    select
        businessentityid,
        territoryid
    from {{ source('adventure_works','sales_salesperson') }}
),

person as (
    select
        businessentityid,
        firstname,
        middlename,
        lastname
    from {{ source('adventure_works','person_person') }}
)

select
    d.salesorderid,
    d.salesorderdetailid,
    h.orderdate,
    h.customerid,
    h.status,
    h.territoryid,

    cc.cardtype,
    coalesce(sr.salesreason_name, 'Sem motivo') as salesreason_name,

    d.productid,
    d.specialofferid,
    d.orderqty,
    d.unitprice,
    d.unitpricediscount,
    d.gross_sales,
    d.net_sales,

    a.city,
    sp.state_name,
    cr.country_name,

    h.salespersonid,
    concat_ws(' ', p2.firstname, p2.middlename, p2.lastname) as salesperson_name

from detail d
left join header h
    on d.salesorderid = h.salesorderid

left join creditcard cc
    on h.creditcardid = cc.creditcardid

left join salesreason_bridge srb
    on d.salesorderid = srb.salesorderid
left join salesreason sr
    on srb.salesreasonid = sr.salesreasonid

left join address a
    on h.shiptoaddressid = a.addressid
left join stateprovince sp
    on a.stateprovinceid = sp.stateprovinceid
left join countryregion cr
    on sp.countryregioncode = cr.countryregioncode

left join salesperson s
    on h.salespersonid = s.businessentityid
left join person p2
    on s.businessentityid = p2.businessentityid
