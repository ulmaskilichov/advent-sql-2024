with t as (
    select
        id,
        lead(id) over (
            order by id
        ) as lead,
        lead(id) over (
            order by id
        ) - id as alert
    from sequence_table
),

prep as (
    select
        id,
        lead,
        alert,
        generate_series(id + 1, lead - 1) as nums
    from t
    where alert <> 1
)

select
    id,
    lead,
    alert,
    string_agg(nums::varchar, ',') as answer
from prep
group by id, lead, alert
