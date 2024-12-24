with prep as (SELECT
	timezone,
	business_start_time,
	business_end_time,
	extract('hour' from pt.utc_offset) as offset_tmz,
	make_time(extract('hour' from business_start_time)::int-extract('hour' from pt.utc_offset)::int, extract('minutes' from business_start_time)::int, 0.0) as new_start_time,
	make_time(extract('hour' from business_end_time)::int-extract('hour' from pt.utc_offset)::int, extract('minutes' from business_end_time)::int, 0.0) as new_end_time
--	business_end_time +extract('hour' from pt.utc_offset)
FROM Workshops w join pg_timezone_names pt
on w.timezone=pt."name")
select *
from prep
order by new_start_time
