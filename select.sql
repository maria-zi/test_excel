SELECT 
    "Время",
    "Успешные попытки",
    "Всего попыток",
    ROUND("Доступность"::NUMERIC, 3) AS "Доступность"
FROM (
    SELECT 
        TO_CHAR(measurement_time, 'HH12 AM') AS "Время",
        COUNT(CASE WHEN err_msg = 'OK' THEN 1 ELSE NULL END) AS "Успешные попытки",
        COUNT(CASE WHEN err_msg <> 'ERR' AND err_msg <> 'ERR_NO_PAGESIZE' THEN 1 ELSE NULL END) AS "Всего попыток",
        CAST(COUNT(CASE WHEN err_msg = 'OK' THEN 1 ELSE NULL END) AS FLOAT) / NULLIF(COUNT(CASE WHEN err_msg <> 'ERR' AND err_msg <> 'ERR_NO_PAGESIZE' THEN 1 ELSE NULL END), 0) AS "Доступность"
    FROM 
        test_excel
    GROUP BY 
        TO_CHAR(measurement_time, 'HH12 AM')
     ) 
ORDER BY 
    "Время" DESC;
