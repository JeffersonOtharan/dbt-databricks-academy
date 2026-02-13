with base as (
    select
        orderid,
        productid,
        unitprice,
        quantity,
        discount,
        unitprice * quantity * (1 - discount) as total_sales,
        orderdate
    from
        {{ source('adventure_works', 'sales_salesorderdetail') }}
)
select
    orderid,
    productid,
    unitprice,
    quantity,
    discount,
    total_sales,
    orderdate
from base