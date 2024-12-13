with
    unnested_emails as (
        select
            unnest (email_addresses) as email
        from
            contact_list
    ),
    prep as (
        select
            email,
            substring(email, strpos (email, '@') + 1) as domain
        from
            unnested_emails
    )
select
    domain,
    array_length (array_agg (email), 1) as res
from
    prep
group by
    domain
order by
    2 desc