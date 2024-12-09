with max_min_skills as (select
	primary_skill,
	max(years_experience) as max_skill,
	min(years_experience) min_skill
from workshop_elves
group by  primary_skill)
,max_elfs as (select
	elf_id,
	elf_name,
	we.primary_skill,
	years_experience,
	row_number() over(partition by we.primary_skill order by elf_id) as rn_max
from workshop_elves we
join max_min_skills mms
on we.primary_skill=mms.primary_skill
and we.years_experience=mms.max_skill)
,min_elfs as (select
	elf_id,
	elf_name,
	we.primary_skill,
	years_experience,
	row_number() over(partition by we.primary_skill order by elf_id) as rn_min
from workshop_elves we
join max_min_skills mms
on we.primary_skill=mms.primary_skill
and we.years_experience=mms.min_skill)
select
mae.elf_id as max_years_experience_elf_id,
mie.elf_id as min_years_experience_elf_id,
mae.primary_skill as shared_skill
from max_elfs mae
join min_elfs mie
on mae.primary_skill = mie.primary_skill
and mae.rn_max=1 and mie.rn_min=1


-- answer
-- max_years_experience_elf_id,min_years_experience_elf_id,shared_skill
-- 4153,3611,Gift sorting
-- 10497,1016,Gift wrapping
-- 50,13551,Toy making
-- (3 rows)