with base as (
    select
        distinct
        to_date(orderdate) as orderdate,
        year(to_date(orderdate)) as ano,
        quarter(to_date(orderdate)) as trimestre,
        month(to_date(orderdate)) as mes,
        dayofmonth(to_date(orderdate)) as dia,
        date_format(to_date(orderdate), 'MMMM') as mes_nome,
        date_format(to_date(orderdate), 'EEEE') as dia_da_semana
    from {{ ref('stg_sales__salesorderheader') }}
)

select
    orderdate,
    ano,
    trimestre,
    mes,
    dia,
    mes_nome,
    dia_da_semana
from base