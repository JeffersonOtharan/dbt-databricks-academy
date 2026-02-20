with source as (
    select *
    from {{ source('adventure_works','person_countryregion') }}
)
select
    countryregioncode,
    name as country_name
from source