with source as (
    select *
    from {{ source('adventure_works','sales_salesterritory') }}
)
select
    territoryid,
    name as territory_name,
    countryregioncode,
    `group` as territory_group,
    modifieddate
from source