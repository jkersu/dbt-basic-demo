{%- set device_types = get_device_types() -%}


with chrome_users as (
    select visitor_id, 
    {% for device_type in device_types %}
        (case when device_type = '{{device_type}}' then device_type end) as is_{{device_type}}_user,
    {% endfor -%}

    browser
    from {{ ref('visitors_jan_2017') }}
    where browser = 'Chrome'
)

select * from chrome_users


    -- Macro replaces duplicate code:
    -- sum(case when device_type = 'Desktop' then 1 ElSE 0 end) as is_desktop_user,
    -- sum(case when device_type = 'Mobile' then 1 ELSE 0 end) as is_mobile_user,
    -- sum(case when device_type = 'Tablet' then 1  ELSE 0 end) as is_tablet_user
