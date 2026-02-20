with source as (
    select *
    from {{ source('adventure_works','sales_customer') }}
)
select
    customerid,
    personid,
    territoryid,
    rowguid,
    modifieddate
from source