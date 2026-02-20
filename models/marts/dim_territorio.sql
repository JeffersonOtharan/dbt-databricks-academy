with base as (
    select
        territoryid,
        territory_name,
        countryregioncode,
        territory_group,
        modifieddate
    from {{ ref('stg_sales__salesterritory') }}
)
select
    territoryid,
    territory_name,
    countryregioncode,
    territory_group,
    modifieddate
from base