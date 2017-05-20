--usunięcie tabel
--drop table if exists talk cascade;
--drop table if exists attendance cascade;
--drop table if exists event cascade;
--drop table if exists raiting_by_user cascade;
--drop table if exists con_user cascade;
--drop table if exists friends cascade;
--drop table if exists friend_request cascade;
--drop SEQUENCE if exists talk_id cascade;
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
    id numeric PRIMARY KEY,
    event_name character varying references event(event_name),
    speaker_login character varying references con_user(login),
    title character varying,
    s_date timestamp without time zone,
    room numeric
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


--sekwencja do nadawania kolejnych id referatom

CREATE SEQUENCE talk_id;

SELECT setval('talk_id',1)
FROM talk;

ALTER TABLE talk ALTER COLUMN id
   SET DEFAULT nextval('talk_id');

ALTER SEQUENCE talk_id OWNED BY talk.id;


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
