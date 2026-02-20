with source as (
    select *
    from {{ source('adventure_works','sales_salesorderdetail') }}
)
select
    salesorderid,
    salesorderdetailid,
    orderqty,
    productid,
    specialofferid,
    unitprice,
    unitpricediscount
from source