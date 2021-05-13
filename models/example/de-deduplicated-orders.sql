{{ config(materialized='table') }}

with final as (

    select 
    order_id, visitor_id, amount_usd
    from {{ref('final')}}
    group by 1,2,3
)

select * from final

