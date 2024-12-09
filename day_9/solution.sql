with averages as (
select reindeer_id, exercise_name, avg(speed_record) avg_speed from Training_Sessions
where reindeer_id <>9
group by reindeer_id, exercise_name)
select a.reindeer_id, r.reindeer_name, max(round(avg_speed,2))
from averages a
join reindeers r on a.reindeer_id=r.reindeer_id
group by a.reindeer_id, r.reindeer_name
order by 3 desc
limit 3
--answer
-- Cupid,88.64
-- Blitzen,88.38
-- Vixen,88.01