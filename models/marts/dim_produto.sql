with base as (
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
    from {{ ref('stg_production__product') }}
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
from base