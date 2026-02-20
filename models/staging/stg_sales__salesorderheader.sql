with source as (
    select *
    from {{ source('adventure_works','sales_salesorderheader') }}
)
select
    salesorderid,
    orderdate,
    customerid,
    status,
    territoryid,
    creditcardid,
    salespersonid,
    shiptoaddressid
from source