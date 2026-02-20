with source as (
    select *
    from {{ source('adventure_works','sales_salesperson') }}
)
select
    businessentityid,
    territoryid
from source