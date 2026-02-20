with source as (
    select *
    from {{ source('adventure_works','person_person') }}
)
select
    businessentityid,
    firstname,
    middlename,
    lastname
from source