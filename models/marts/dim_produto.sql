with base as (
    select
        productid,
        name,
        listprice,
        safetystocklevel,
        reorderpoint,
        standardcost
    from {{ ref('stg_production__product') }}
)
select
    productid,
    name,
    listprice,
    safetystocklevel,
    reorderpoint,
    standardcost
from base