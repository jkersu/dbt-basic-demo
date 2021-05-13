-- Configure models directly within SQL files
-- This will override configurations stated in dbt_project.yml
{{ config(materialized='table') }}

with jan_users as (

    select * from {{ref('chrome_users_jan')}}
),

feb_orders as (
    select
            distinct hits.transaction.transactionId as order_id,
            fullVisitorId as visitor_id,
            hits.transaction.transactionRevenue,
            hits.type
        from `bigquery-public-data.google_analytics_sample.ga_sessions_*`, unnest(hits) as hits

        WHERE _table_suffix between '20170201' and '20170229'
        and hits.transaction.transactionId is not null
        and hits.transaction.transactionRevenue is not null
),

final as (
     select
     distinct feb_orders.order_id,
     feb_orders.visitor_id,
     {{ integer_to_dollar('feb_orders.transactionRevenue') }} as amount_usd
    
     from jan_users inner join feb_orders using (visitor_id)
 )

select * from final


-- dbt run
-- dbt test
-- dbt docs generate 
-- dbt docs serve
