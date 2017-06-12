--© Michał Martusewicz

--usunięcie tabel
--drop table if exists talk cascade;
--drop table if exists attendance cascade;
--drop table if exists event cascade;
--drop table if exists raiting_by_user cascade;
--drop table if exists con_user cascade;
--drop table if exists friends cascade;
--drop table if exists friend_request cascade;
--drop table if exists user_on_event cascade;

--drop trigger if exists make_friends_trigger on friend_request;

--drop DOMAIN if exists actual_status cascade;
--drop DOMAIN if exists actual_role cascade;


--2 nowe typy danych

CREATE DOMAIN actual_status AS text
CHECK (VALUE IN ('P','W','R')) NOT NULL;

CREATE DOMAIN actual_role AS text
CHECK (VALUE IN ('A','U')) NOT NULL;

--utworzenie tabel
CREATE TABLE con_user (
    login character varying PRIMARY KEY,
    password character varying,
    role actual_role
);

CREATE TABLE event (
    event_name character varying PRIMARY KEY,
    s_date timestamp without time zone,
    e_date timestamp without time zone
);

CREATE TABLE talk (
    id varchar PRIMARY KEY,
    event_name character varying references event(event_name) default NULL,
    speaker_login character varying references con_user(login) not NULL,
    title character varying,
    s_date timestamp without time zone,
    room numeric,
    status actual_status

);

CREATE TABLE user_on_event (
    login character varying references con_user(login) not NULL,
    event_name character varying  references event(event_name) not NULL,
    PRIMARY KEY (login, event_name )
);

CREATE TABLE attendance (
    talk_id varchar references talk(id),
    user_login character varying references con_user(login) not NULL,
    a_date timestamp without time zone,
    PRIMARY KEY (talk_id, user_login )

);




CREATE TABLE raiting_by_user (
    talk_id varchar references talk(id),
    user_login character varying references con_user(login) not NULL,
    raiting int,
    a_date timestamp without time zone,
    PRIMARY KEY (talk_id, user_login )
);

CREATE TABLE friends (
    login1 character varying references con_user(login) not NULL,
    login2 character varying references con_user(login) not NULL,
    PRIMARY KEY (login1, login2 )
);

CREATE TABLE friend_request (
    login1 character varying references con_user(login) not NULL,
    login2 character varying references con_user(login) not NULL,
    PRIMARY KEY (login1, login2 )
);


--trigger który usuwa wzajemne zaproszenia do znajomych i dodaje odpowiednie krotki do tabeli friends

CREATE OR REPLACE FUNCTION make_friends() RETURNS TRIGGER AS
$XD$
   DECLARE
      fr numeric;
   BEGIN

      SELECT count(*) INTO fr
      FROM friend_request
        WHERE login1 = NEW.login2
        and login2 = NEW.login1;

      IF (fr = 0) THEN RETURN NEW; END IF;

     INSERT INTO friends(login1,login2) VALUES
                 (NEW.login1, NEW.login2),
                 (NEW.login2, NEW.login1);
    delete from friend_request
      WHERE login1 = NEW.login2
      and login2 = NEW.login1;
     RETURN NULL;
  END
$XD$ LANGUAGE plpgsql;

CREATE TRIGGER make_friends_trigger before INSERT ON friend_request
FOR EACH ROW EXECUTE PROCEDURE make_friends();


CREATE OR REPLACE FUNCTION count_on_event(varchar) RETURNS bigint AS
$XD$
    DECLARE
        numer numeric;
    BEGIN
        SELECT count(*) INTO numer from user_on_event where event_name = $1
        group by event_name;
        if (numer is not NULL) then RETURN numer; END IF;

        select 0 into numer;
        return numer;
    END
$XD$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION score_of_talk(varchar, numeric) RETURNS bigint AS
$XD$
    DECLARE
        score bigint;
        score1 bigint;
        score2 bigint;
        score3 bigint;
    BEGIN
        SELECT 0 into score;

        SELECT AVG(raiting) INTO score1 from raiting_by_user where talk_id = $2;

        SELECT count(distinct user_login) into score2
            FROM  talk t
            join attendance a on (t.id=a.talk_id)
            where t.id=$2;

        SELECT count(distinct user_login) into score2
            FROM  talk t
            join attendance a on (t.id=a.talk_id)
            join friends f on (f.login1 = a.user_login)
            where t.id=$2
            and f.login2 = $1;

        SELECT count(*) into score3
            from talk t
            join friends f on (f.login1=t.speaker_login)
            where f.login2 = $1;

        if (score1 is not NULL) then score=score + 10*score1; end if;
        if (score2 is not NULL) then score=score + score2; end if;
        if (score3 is not NULL) then score=score + 100 * score3; end if;
        return score;

    END
$XD$ LANGUAGE plpgsql;




--CREATE USER stud WITH PASSWORD 'd8578edf8458ce06fbc' superuser ;
