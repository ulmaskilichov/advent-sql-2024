with prep as (
   select id,
          elf_name,
          unnest(string_to_array(skills,',')) as skill
     from elves
)
select count(distinct id)
  from prep
 where skill = 'SQL'
