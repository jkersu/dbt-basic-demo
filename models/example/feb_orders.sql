with orders as (

    select
            fullVisitorId as visitor_id,
            hits.transaction.transactionId as order_id,
            hits.transaction.transactionRevenue,
            hits.type
        from `bigquery-public-data.google_analytics_sample.ga_sessions_*`, unnest(hits) as hits

        WHERE _table_suffix between '20170201' AND '20170229'
        AND hits.transaction.transactionId IS NOT NULL
)

select * from orders




   