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
    from {{ ref('stg_sales__salesorderdetail') }}
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
    from {{ ref('stg_sales__salesorderheader') }}
),

creditcard as (
    select
        creditcardid,
        cardtype
    from {{ ref('stg_sales__creditcard') }}
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
        from {{ ref('stg_sales__salesorderheadersalesreason') }}
    ) x
    where rn = 1
),

salesreason as (
    select
        salesreasonid,
        salesreason_name
    from {{ ref('stg_sales__salesreason') }}
),

address as (
    select
        addressid,
        city,
        stateprovinceid
    from {{ ref('stg_person__address') }}
),

stateprovince as (
    select
        stateprovinceid,
        state_name,
        countryregioncode
    from {{ ref('stg_person__stateprovince') }}
),

countryregion as (
    select
        countryregioncode,
        country_name
    from {{ ref('stg_person__countryregion') }}
),

salesperson as (
    select
        businessentityid,
        territoryid
    from {{ ref('stg_sales__salesperson') }}
),

person as (
    select
        businessentityid,
        firstname,
        middlename,
        lastname
    from {{ ref('stg_person__person') }}
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