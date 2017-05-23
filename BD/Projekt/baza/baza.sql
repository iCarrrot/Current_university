--usunięcie tabel
drop table if exists talk cascade;
drop table if exists attendance cascade;
drop table if exists event cascade;
drop table if exists raiting_by_user cascade;
drop table if exists con_user cascade;
drop table if exists friends cascade;
drop table if exists friend_request cascade;
drop table if exists user_on_event cascade;

drop trigger if exists make_friends_trigger on friend_request;

drop DOMAIN if exists actual_status cascade;
drop DOMAIN if exists actual_role cascade;


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
    id numeric PRIMARY KEY,
    event_name character varying references event(event_name),
    speaker_login character varying references con_user(login),
    title character varying,
    s_date timestamp without time zone,
    room numeric,
    status actual_status
);

CREATE TABLE user_on_event (
    login character varying references con_user(login),
    event_name character varying  references event(event_name)

);

CREATE TABLE attendance (
    talk_id numeric references talk(id),
    user_login character varying references con_user(login),
    a_date timestamp without time zone
);




CREATE TABLE raiting_by_user (
    talk_id numeric references talk(id),
    user_login character varying references con_user(login),
    raiting int,
    a_date timestamp without time zone
);

CREATE TABLE friends (
    login1 character varying references con_user(login),
    login2 character varying references con_user(login)
);

CREATE TABLE friend_request (
    login1 character varying references con_user(login),
    login2 character varying references con_user(login)
);


--trigger który usuwa wzajemne zaproszenia doz najomych i dodaje odpowiednie krotki do tabeli friends

CREATE OR REPLACE FUNCTION make_friends() RETURNS TRIGGER AS
$X$
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
$X$ LANGUAGE plpgsql;

CREATE TRIGGER make_friends_trigger before INSERT ON friend_request
FOR EACH ROW EXECUTE PROCEDURE make_friends();

CREATE USER stud WITH PASSWORD 'd8578edf8458ce06fbc' superuser;
