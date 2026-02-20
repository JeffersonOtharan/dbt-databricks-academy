with source as (
    select *
    from {{ source('adventure_works','sales_salesorderheadersalesreason') }}
)
select
    salesorderid,
    salesreasonid
from source