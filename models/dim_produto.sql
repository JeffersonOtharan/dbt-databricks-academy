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
    from
        {{ source('production', 'product') }}
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