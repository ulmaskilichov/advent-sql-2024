with only_params_from_request as (select
	url,
	split_part(url, '?', 2) as only_params
from web_requests
where url like '%utm_source=advent-of-sql%'
)
, params_splitted as (
    select
        url,
        unnest(string_to_array(only_params, '&')) as param_value
    from only_params_from_request
)
, distinct_params as (
    select
        url,
        split_part(param_value, '=', 1) as params
    from params_splitted
)
select
    url,
    array_length(array_agg(distinct params), 1) as unique_params
from distinct_params
group by url
order by 2 desc, url
limit 1