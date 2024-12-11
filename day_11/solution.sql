with t as (select
	field_name,
	harvest_year,
	case season
		when 'Spring' THEN 1
		when 'Summer' THEN 2
		when 'Fall' THEN 3
		when 'Winter' THEN 4
	end as season_number,
	trees_harvested
from TreeHarvests
)
select
field_name,
	harvest_year,
	season_number,
	trees_harvested,
	round(avg(trees_harvested) over(partition by field_name, harvest_year order by season_number ROWS BETWEEN 2 PRECEDING AND current row), 2) as three_season_moving_avg
from t
order by 5 desc
limit 1

--answer
-- 327.67