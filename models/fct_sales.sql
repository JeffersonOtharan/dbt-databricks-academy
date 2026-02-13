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
        unitprice * orderqty * (1 - unitpricediscount) as total_sales
    from {{ source('adventure_works','sales_salesorderdetail') }}
),

header as (
    select
        salesorderid,
        to_date(orderdate) as orderdate,
        customerid,
        status,
        territoryid,
        cast(creditcardid as bigint) as creditcardid
    from {{ source('adventure_works','sales_salesorderheader') }}
),

salesreason_bridge as (
    select
        salesorderid,
        salesreasonid
    from {{ source('adventure_works','sales_salesorderheadersalesreason') }}
),

salesreason as (
    select
        salesreasonid,
        name as salesreason_name
    from {{ source('adventure_works','sales_salesreason') }}
),

creditcard as (
    select
        creditcardid,
        cardtype
    from {{ source('adventure_works','sales_creditcard') }}
)

select
    d.salesorderid,
    d.salesorderdetailid,
    h.orderdate,
    h.customerid,
    h.status,
    h.territoryid,
    cc.cardtype,
    sr.salesreason_name,
    d.productid,
    d.specialofferid,
    d.orderqty,
    d.unitprice,
    d.unitpricediscount,
    d.total_sales
from detail d
left join header h
    on d.salesorderid = h.salesorderid
left join creditcard cc
    on h.creditcardid = cc.creditcardid
left join salesreason_bridge srb
    on d.salesorderid = srb.salesorderid
left join salesreason sr
    on srb.salesreasonid = sr.salesreasonid
