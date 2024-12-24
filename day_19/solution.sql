with all_avg_pr as (
   select avg(year_end_performance_scores[array_length(
      year_end_performance_scores,
      1
   )]) as avg_last_score
     from employees
),prep as (
   select case
             when year_end_performance_scores[array_length(
                year_end_performance_scores,
                1
             )]> (
                select all_avg_pr.avg_last_score
                  from all_avg_pr
             ) then
                salary * 1.15
             else
                salary
          end as salary
     from employees
)
select sum(salary)
  from prep