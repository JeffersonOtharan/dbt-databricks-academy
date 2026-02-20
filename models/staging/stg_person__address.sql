with source as (
    select *
    from {{ source('adventure_works','person_address') }}
)
select
    addressid,
    city,
    stateprovinceid
from source