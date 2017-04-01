SELECT nazwisko 
FROM uzytkownik JOIN grupa USING (kod_uz)
    JOIN przedmiot_semestr USING (kod_przed_sem) 
    JOIN semestr USING (semestr_id)
    JOIN przedmiot USING (kod_przed)
WHERE przedmiot.nazwa ='Matematyka dyskretna (M)'
    AND grupa.rodzaj_zajec='c'
    AND semestr.nazwa='Semestr zimowy 2010/2011';

SELECT imie, nazwisko, data 
FROM uzytkownik 
    join wybor using (kod_uz)
    JOIN grupa USING (kod_grupy)
    JOIN przedmiot_semestr USING (kod_przed_sem) 
    JOIN semestr USING (semestr_id)
    JOIN przedmiot USING (kod_przed)
WHERE przedmiot.nazwa ='Matematyka dyskretna (M)'
    AND grupa.rodzaj_zajec='w'
    AND semestr.nazwa='Semestr zimowy 2010/2011'
ORDER by data;

SELECT data 
FROM uzytkownik 
    join wybor using (kod_uz)
    JOIN grupa USING (kod_grupy)
    JOIN przedmiot_semestr USING (kod_przed_sem) 
    JOIN semestr USING (semestr_id)
    JOIN przedmiot USING (kod_przed)
WHERE przedmiot.nazwa ='Matematyka dyskretna (M)'
    AND grupa.rodzaj_zajec='w'
    AND semestr.nazwa='Semestr zimowy 2010/2011'
ORDER by data;

#4
select distinct przedmiot.kod_przed, przedmiot.nazwa
from przedmiot join przedmiot_semestr using (kod_przed)
    join grupa using (kod_przed_sem)
where 
    rodzaj='o'
AND
    rodzaj_zajec='e';

#5
select distinct kod_uz, nazwisko 
from uzytkownik join grupa using (kod_uz)
join przedmiot_semestr using (kod_przed_sem)
join semestr s using (semestr_id)
join przedmiot using (kod_przed) 
where 
    rodzaj='o'
    and rodzaj_zajec IN ('c','C')
    AND s.nazwa LIKE '%zimowy%'
order by kod_uz;

#6

select distinct kod_uz
from uzytkownik join grupa using (kod_uz)
join przedmiot_semestr using (kod_przed_sem)
join semestr s using (semestr_id)
join przedmiot using (kod_przed) 
where 
    uzytkownik.nazwisko='Urban'
    
order by przedmiot.nazwa;

#7

select distinct kod_uz
from uzytkownik 
where 
    uzytkownik.nazwisko like 'Kabacki%'
    order by 1;