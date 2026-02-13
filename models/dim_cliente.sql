with base as (
    select
        customerid,
        personid,
        storeid,
        territoryid,
        rowguid,
        modifieddate
    from
        {{ source('adventure_works', 'sales_customer') }}
)

select
    customerid,
    personid,
    storeid,
    territoryid,
    rowguid,
    modifieddate
from base