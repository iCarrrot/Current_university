CREATE FUNCTION pierwszy_zapis(int,int)
     RETURNS wybor.data%TYPE
AS $X$
    SELECT min(data)
    FROM wybor
         JOIN grupa USING(kod_grupy)
         JOIN przedmiot_semestr USING(kod_przed_sem)
    WHERE wybor.kod_uz=$1 AND semestr_id=$2;
$X$ LANGUAGE SQL;



SELECT DISTINCT -- (3)
u.nazwisko,pierwszy_zapis(u.kod_uz,s.semestr_id) -- (2)
FROM uzytkownik u JOIN wybor w USING(kod_uz) -- (1)
    JOIN grupa g USING(kod_grupy)
    JOIN przedmiot_semestr ps USING(kod_przed_sem)
    JOIN semestr s USING(semestr_id)
WHERE s.nazwa='Semestr zimowy 2010/2011'
ORDER BY 2; -- (4)
