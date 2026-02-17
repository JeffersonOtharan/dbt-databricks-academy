with base as (
    select
        territoryid,
        name as territory_name,
        countryregioncode,
        group as territory_group,
        modifieddate
    from
        {{ source('adventure_works', 'sales_salesterritory') }}
)
select
    territoryid,
    territory_name,
    countryregioncode,
    territory_group,
    modifieddate
from base