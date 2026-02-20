with customer as (
    select
        customerid,
        personid,
        territoryid,
        rowguid,
        modifieddate
    from {{ ref('stg_sales__customer') }}
),

person as (
    select
        businessentityid,
        firstname,
        middlename,
        lastname
    from {{ ref('stg_person__person') }}
),

email_ranked as (
    select
        businessentityid,
        emailaddress,
        row_number() over (
            partition by businessentityid
            order by emailaddressid
        ) as rn
    from {{ ref('stg_person__emailaddress') }}
),

email as (
    select
        businessentityid,
        emailaddress
    from email_ranked
    where rn = 1
)

select
    c.customerid,
    c.personid,
    c.territoryid,

    p.firstname,
    p.middlename,
    p.lastname,
    concat_ws(' ', p.firstname, p.middlename, p.lastname) as full_name,

    e.emailaddress,

    c.rowguid,
    c.modifieddate
from customer c
left join person p
    on c.personid = p.businessentityid
left join email e
    on c.personid = e.businessentityid