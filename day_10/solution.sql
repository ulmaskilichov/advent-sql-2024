with t as (select drink_name, date, sum(quantity) as qty from drinks
group by 1, 2)
,prep as (select
	date,
max(case  drink_name
	when 'Hot Cocoa' then qty
	else 0
	end) as cocoa_qty,
max(case  drink_name
	when 'Peppermint Schnapps' then qty
	else 0
	end )as schanpps_qty,
max(case  drink_name
	when 'Eggnog' then qty
	else 0
	end) as Eggnog_qty
from t
where 1=1
group by date)
select date
from prep
where cocoa_qty=38 and schanpps_qty=298 and eggnog_qty=198