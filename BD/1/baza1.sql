Schema |       Name        | Type  |  Owner   
--------+-------------------+-------+----------
 public | grupa             | table | postgres
 public | przedmiot         | table | postgres
 public | przedmiot_semestr | table | postgres
 public | semestr           | table | postgres
 public | uzytkownik        | table | postgres
 public | wybor             | table | postgres
(6 rows)

postgres=# \d grupa
               Table "public.grupa"
    Column     |         Type         | Modifiers 
---------------+----------------------+-----------
 kod_grupy     | integer              | not null
 kod_przed_sem | integer              | not null
 kod_uz        | integer              | not null
 max_osoby     | smallint             | not null
 rodzaj_zajec  | character(1)         | not null
 termin        | character(13)        | 
 sala          | character varying(3) | 
Indexes:
    "grupa_key" PRIMARY KEY, btree (kod_grupy)
Foreign-key constraints:
    "fk_grupa_przed_sem" FOREIGN KEY (kod_przed_sem) REFERENCES przedmiot_semestr(kod_przed_sem) DEFERRABLE
    "fk_grupa_uz" FOREIGN KEY (kod_uz) REFERENCES uzytkownik(kod_uz) DEFERRABLE
Referenced by:
    TABLE "wybor" CONSTRAINT "fk_wybor_grupa" FOREIGN KEY (kod_grupy) REFERENCES grupa(kod_grupy) DEFERRABLE

postgres=# \d przedmiot
             Table "public.przedmiot"
  Column   |     Type     |       Modifiers        
-----------+--------------+------------------------
 kod_przed | integer      | not null
 nazwa     | text         | not null
 punkty    | smallint     | not null
 rodzaj    | character(1) | not null
 egzamin   | boolean      | not null default false
Indexes:
    "przedmiot_pkey" PRIMARY KEY, btree (kod_przed)
Check constraints:
    "rodzaj_stale" CHECK (rodzaj = ANY (ARRAY['o'::bpchar, 'z'::bpchar, 'p'::bpchar, 'k'::bpchar, 's'::bpchar, 'n'::bpchar]))
Referenced by:
    TABLE "przedmiot_semestr" CONSTRAINT "fk_przed_sem_przed" FOREIGN KEY (kod_przed) REFERENCES przedmiot(kod_przed) DEFERRABLE

postgres=# \d przedmiot_semestr
          Table "public.przedmiot_semestr"
    Column     |          Type          | Modifiers 
---------------+------------------------+-----------
 kod_przed_sem | integer                | not null
 semestr_id    | integer                | not null
 kod_przed     | integer                | not null
 strona_domowa | character varying(120) | 
 angielski     | boolean                | 
Indexes:
    "przedmiot_semestr_key" PRIMARY KEY, btree (kod_przed_sem)
Foreign-key constraints:
    "fk_przed_sem_przed" FOREIGN KEY (kod_przed) REFERENCES przedmiot(kod_przed) DEFERRABLE
    "fk_przed_sem_semestr_id" FOREIGN KEY (semestr_id) REFERENCES semestr(semestr_id) DEFERRABLE
Referenced by:
    TABLE "grupa" CONSTRAINT "fk_grupa_przed_sem" FOREIGN KEY (kod_przed_sem) REFERENCES przedmiot_semestr(kod_przed_sem) DEFERRABLE

postgres=# \d semestr
      Table "public.semestr"
   Column   |  Type   | Modifiers 
------------+---------+-----------
 semestr_id | integer | not null
 nazwa      | text    | not null
Indexes:
    "semestr_key" PRIMARY KEY, btree (semestr_id)
Referenced by:
    TABLE "przedmiot_semestr" CONSTRAINT "fk_przed_sem_semestr_id" FOREIGN KEY (semestr_id) REFERENCES semestr(semestr_id) DEFERRABLE

postgres=# \d uzytkownik
          Table "public.uzytkownik"
  Column  |         Type          | Modifiers 
----------+-----------------------+-----------
 kod_uz   | integer               | not null
 imie     | character varying(15) | not null
 nazwisko | character varying(30) | not null
 semestr  | smallint              | 
Indexes:
    "uzytkownik_key" PRIMARY KEY, btree (kod_uz)
Referenced by:
    TABLE "grupa" CONSTRAINT "fk_grupa_uz" FOREIGN KEY (kod_uz) REFERENCES uzytkownik(kod_uz) DEFERRABLE
    TABLE "wybor" CONSTRAINT "fk_wybor_uz" FOREIGN KEY (kod_uz) REFERENCES uzytkownik(kod_uz) DEFERRABLE

postgres=# \d wybor
                     Table "public.wybor"
  Column   |           Type           |       Modifiers        
-----------+--------------------------+------------------------
 kod_grupy | integer                  | not null
 kod_uz    | integer                  | not null
 data      | timestamp with time zone | not null default now()
