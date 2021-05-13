with visitors as (

    select
        fullVisitorId as visitor_id,
        visitStartTime as visit_start,
        device.deviceCategory as device_type,
        device.browser as browser, 
        `date` as visitDate

    from `bigquery-public-data.google_analytics_sample.ga_sessions_*`
    WHERE _table_suffix  between '20170101' AND '20170131'
)

select * from visitors