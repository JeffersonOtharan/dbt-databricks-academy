with base as (
    select
        territoryid,
        territory_name,
        countryregioncode,
        territory_group
    from {{ ref('stg_sales__salesterritory') }}
)
select
    territoryid,
    territory_name,
    countryregioncode,
    territory_group
from base