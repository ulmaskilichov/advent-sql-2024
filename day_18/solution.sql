with recursive managers AS (
 -- Start with top of hierarchy
 select
 	staff_id,
 	manager_id,
 	1 as levels
 from staff
 where manager_id is null
 union all
 -- Get all employees for the current manager
 select
 	staff.staff_id,
 	staff.manager_id,
 	(managers.levels + 1) as levels
 from staff
 join managers on managers.staff_id = staff.manager_id
)
select
	staff_id,
	levels,
	manager_id,
	count(*) over(partition by manager_id) as peers_same_manager,
	count(*) over(partition by levels) as total_peers_same_level
from managers
order by total_peers_same_level desc, staff_id