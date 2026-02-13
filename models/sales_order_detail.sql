with base as (
    select
        salesorderid,
        salesorderdetailid,
        carriertrackingnumber,
        orderqty,
        productid,
        specialofferid,
        unitprice,
        unitpricediscount,
        unitprice * orderqty * (1 - unitpricediscount) as total_sales,
        rowguid,
        modifieddate
    from
        {{ source('adventure_works', 'sales_salesorderdetail') }}
)
select
    salesorderid,
    salesorderdetailid,
    carriertrackingnumber,
    orderqty,
    productid,
    specialofferid,
    unitprice,
    unitpricediscount,
    total_sales,
    rowguid,
    modifieddate
from base
