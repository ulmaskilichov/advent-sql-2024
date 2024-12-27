with sums_by_quarter as (select
	date_part('year', sale_date) as year_y,
	extract(quarter from sale_date) as quarter_q,
	sum(amount) as amount_by_quarter
from sales
--where date_part('year', sale_date) in(2018, 2019) for tests
group by date_part('year', sale_date), extract(quarter from sale_date))
select
	year_y,
	quarter_q,
	amount_by_quarter,
	lag(amount_by_quarter) over(order by year_y, quarter_q) as prev_amount,
	(amount_by_quarter - lag(amount_by_quarter) over(order by year_y, quarter_q))/lag(amount_by_quarter) over(order by year_y, quarter_q) as growth
from sums_by_quarter
order by 5 desc