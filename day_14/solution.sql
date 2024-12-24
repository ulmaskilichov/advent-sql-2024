with prep as (select
	record_id,
	record_date,
	json_array_elements(cleaning_receipts::json),
	json_array_elements(cleaning_receipts::json)->>'color' color,
	json_array_elements(cleaning_receipts::json)->>'pickup' pickup,
	json_array_elements(cleaning_receipts::json)->>'garment' garment,
	json_array_elements(cleaning_receipts::json)->>'drop_off' drop_off
from SantaRecords
where 1=1
)
select
*
from prep
where color = 'green'
and garment = 'suit'
order by drop_off desc
limit 1