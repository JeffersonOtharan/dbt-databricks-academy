with source as (
    select *
    from {{ source('adventure_works','person_emailaddress') }}
)
select
    businessentityid,
    emailaddressid,
    emailaddress
from source