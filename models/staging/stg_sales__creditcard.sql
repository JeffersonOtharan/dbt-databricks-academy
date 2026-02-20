with source as (
    select *
    from {{ source('adventure_works','sales_creditcard') }}
)
select
    creditcardid,
    cardtype
from source