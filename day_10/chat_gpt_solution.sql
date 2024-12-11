SELECT *
FROM crosstab(
    $$
    SELECT
        date,
        drink_name,
        SUM(quantity) AS qty
    FROM drinks
    GROUP BY date, drink_name
    ORDER BY date, drink_name
    $$,
    $$
    VALUES ('Hot Cocoa'), ('Peppermint Schnapps'), ('Eggnog')
    $$
) AS pivot_table (
    date DATE,
    cocoa_qty INT,
    schanpps_qty INT,
    eggnog_qty INT
)
WHERE cocoa_qty = 38
  AND schanpps_qty = 298
  AND eggnog_qty = 198;