with source as (
    select *
    from {{ source('adventure_works','production_product') }}
)
select
    productid,
    name,
    productnumber,
    color,
    listprice,
    safetystocklevel,
    reorderpoint,
    standardcost,
    size,
    sizeunitmeasurecode,
    weight,
    weightunitmeasurecode
from source