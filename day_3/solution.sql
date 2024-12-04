with t as (
select id,
	'christmas_feast' as type_org,
	(XPATH('/christmas_feast/organizational_details/attendance_record/total_guests/text()', menu_data))[1]::text::int as guests_count,
	unnest(XPATH('/christmas_feast/organizational_details/menu_registry/course_details/dish_entry/food_item_id/text()', menu_data))::text::int food_item_id
from christmas_menus cm
where 1=1
and XPATH_EXISTS('/christmas_feast/organizational_details/attendance_record/total_guests/text()', menu_data)
and (XPATH('/christmas_feast/organizational_details/attendance_record/total_guests/text()', menu_data))[1]::text::int > 78
--and id=2
union ALL
--removed bcs there are no guests more than 78
--SELECT
--    id,
--    'polar_celebration' as type_org,
--    (XPATH('/polar_celebration/event_administration/participant_metrics/attendance_details/headcount/total_present/text()', menu_data))[1]::text as guests_count,
--    menu_data
--from christmas_menus cm
--where 1=1
--and XPATH_EXISTS('/polar_celebration/event_administration/participant_metrics/attendance_details/headcount/total_present/text()', menu_data)
--and (XPATH('/polar_celebration/event_administration/participant_metrics/attendance_details/headcount/total_present/text()', menu_data))[1]::text::int > 78
--
--union ALL
SELECT
    id,
    'northpole_database' as type_org,
    (XPATH('/northpole_database/annual_celebration/event_metadata/dinner_details/guest_registry/total_count/text()', menu_data))[1]::text::int as guests_count,
    unnest(XPATH('/northpole_database/annual_celebration/event_metadata/menu_items/food_category/food_category/dish/food_item_id/text()', menu_data))::text::int as food_item_id
from christmas_menus cm
where 1=1
and XPATH_EXISTS('/northpole_database/annual_celebration/event_metadata/dinner_details/guest_registry/total_count/text()', menu_data)
and (XPATH('/northpole_database/annual_celebration/event_metadata/dinner_details/guest_registry/total_count/text()', menu_data))[1]::text::int > 78
--and id=3
)
select food_item_id, count(*) from t
group by 1
order by 2 desc

--answer
-- food_item_id => 493 with max orders 117 count