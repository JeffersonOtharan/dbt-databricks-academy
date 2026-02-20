with source as (
    select *
    from {{ source('adventure_works','sales_salesreason') }}
)
select
    salesreasonid,
    name as salesreason_name
from source