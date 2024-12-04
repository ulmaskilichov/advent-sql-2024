SELECT
    STRING_AGG(CHR(VALUE), '')
FROM
    LETTERS_B
WHERE
    (VALUE BETWEEN 65 AND 90) --uppercase
    OR (VALUE BETWEEN 97 AND 122) --lowercase
    OR VALUE IN (32, 44, 46, 33) --space comma dot !
    OR (VALUE BETWEEN 48 AND 57) -- digits