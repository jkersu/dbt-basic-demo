-- Configure models directly within SQL files
-- This will override configurations stated in dbt_project.yml
{{ config(materialized='table') }}

with jan_users as (

    select * from {{ref('chrome_users_jan')}}
),

feb_orders as (

    select * from {{ ref('feb_orders')}}
),

final as (
     select
     feb_orders.visitor_id,
     feb_orders.order_id,
     {{ integer_to_dollar('feb_orders.transactionRevenue') }} as amount_usd
    
     from jan_users inner join feb_orders using (visitor_id)
 )
select * from final
