with prev as (select
	toy_id,
	unnest(previous_tags) as prev_tag
from toy_production
--where toy_id =1
)
, news as (
select
	toy_id,
	unnest(new_tags) as new_tag
from toy_production
--where toy_id =1
)
, prep as (select
	coalesce(p.toy_id, n.toy_id) as toy_id,
	sum(case when p.prev_tag = n.new_tag then 1 else 0 end) unchanged_tags,
	sum(case when p.prev_tag is null then 1 else 0 end) added_tags,
	sum(case when n.new_tag is null then 1 else 0 end) removed_tags
from prev p
full join news n
on p.toy_id=n.toy_id
and p.prev_tag = n.new_tag
group by p.toy_id, n.toy_id)
select
	toy_id,
	max(unchanged_tags) as unchanged_tags,
	max(added_tags) as added_tags,
	max(removed_tags) as removed_tags
from prep
group by toy_id
order by 3 desc

-- toy_id,unchanged_tags,added_tags,removed_tags
-- 2726,2,98,0