with source as (
    select *
    from {{ source('adventure_works','person_stateprovince') }}
)
select
    stateprovinceid,
    name as state_name,
    countryregioncode
from source