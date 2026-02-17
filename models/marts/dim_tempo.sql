with base as (
    select
        distinct
        orderdate,
        year(orderdate) as ano,
        quarter(orderdate) as trimestre,
        month(orderdate) as mes,
        dayofmonth(orderdate) as dia,
        date_format(orderdate, 'MMMM') as mes_nome,
        date_format(orderdate, 'EEEE') as dia_da_semana
    from
        {{ source('adventure_works', 'sales_salesorderheader') }}
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