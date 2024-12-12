WITH gift_request_counts AS (
    SELECT
        g.gift_id AS gift_id,
        g.gift_name AS gift_name,
        COUNT(gr.gift_id) AS request_count
    FROM
        gifts g
    JOIN
        gift_requests gr
    ON
        g.gift_id = gr.gift_id
    GROUP BY
        g.gift_id, g.gift_name
),
percentiles AS (
    SELECT
        gift_name,
        request_count,
        PERCENT_RANK() OVER (ORDER BY request_count) AS percentile
    FROM
        gift_request_counts
)
SELECT
    gift_name,
    round(percentile::numeric, 2)
FROM
    percentiles
ORDER BY
    percentile DESC,
    gift_name ASC

--chemistry set	0.86