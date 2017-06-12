# Michal Martusewicz

import collections
import sys
import json
import psycopg2


def organizer(funkcja, pelnaLinia):
    """make new admin"""
    if pelnaLinia[funkcja]["secret"] == "d8578edf8458ce06fbc5bb76a58c5ca4":

        try:
            cur = conn.cursor()
            cur.execute("""SELECT count(*) from con_user where login = '{0}' ;"""
                        .format(pelnaLinia[funkcja]["newlogin"]))

            wynik = cur.fetchall()
            if wynik == [(0,)]:
                x_string = """
                INSERT INTO con_user(login,password,role) VALUES
                    ('{0}', '{1}','A');
                """.format(pelnaLinia[funkcja]["newlogin"], pelnaLinia[funkcja]["newpassword"])
                cur.execute(x_string)

                dict1 = {'status': "OK"}
                r = json.dumps(dict1)
                print r
                cur.close()
                conn.commit()
            else:
                dict1 = {'status': "ERROR"}
                r = json.dumps(dict1)
                print r

        except:
            conn.rollback()
            dict1 = {'status': "ERROR"}
            r = json.dumps(dict1)
            print r


    else:
        dict1 = {'status': "ERROR"}
        r = json.dumps(dict1)
        print r

def event(funkcja, pelnaLinia):
    """make new event"""

    try:
        cur = conn.cursor()
        cur.execute("""SELECT role from con_user
                    where login = '{0}' and password = '{1}' ;"""
                    .format(pelnaLinia[funkcja]["login"],
                            pelnaLinia[funkcja]["password"]))

        uprawnienia = cur.fetchall()
        if uprawnienia == [("A",)]:
            x_string = """
            INSERT INTO event(event_name,s_date,e_date) VALUES
                ('{0}', '{1}','{2}');
            """.format(pelnaLinia[funkcja]["eventname"],
                       pelnaLinia[funkcja]["start_timestamp"],
                       pelnaLinia[funkcja]["end_timestamp"])
            cur.execute(x_string)

            dict1 = {'status': "OK"}
            r = json.dumps(dict1)
            print r
            cur.close()
            conn.commit()
        else:
            dict1 = {'status': "ERROR"}
            r = json.dumps(dict1)
            print r
    except:
        conn.commit()
        dict1 = {'status': "ERROR"}
        r = json.dumps(dict1)
        print r



def user(funkcja, pelnaLinia):
    """make new user"""
    cur = conn.cursor()
    cur.execute("""SELECT role from con_user
                where login = '{0}' and password = '{1}' ;"""
                .format(pelnaLinia[funkcja]["login"],
                        pelnaLinia[funkcja]["password"]))

    uprawnienia = cur.fetchall()
    if uprawnienia == [("A",)]:
        try:
            x_string = """
            INSERT INTO con_user(login,password,role) VALUES
                ('{0}', '{1}','U');
            """.format(pelnaLinia[funkcja]["newlogin"],
                       pelnaLinia[funkcja]["newpassword"])

            cur.execute(x_string)
            cur.close()
            conn.commit()
            dict1 = {'status': "OK"}
            r = json.dumps(dict1)
            print r
        except:
            conn.rollback()
            dict1 = {'status': "ERROR"}
            r = json.dumps(dict1)
            print r

    else:
        dict1 = {'status': "ERROR"}
        r = json.dumps(dict1)
        print r

def talk(funkcja, pelnaLinia):
    """make new talk or accept egsisting talk"""
    try:
        cur = conn.cursor()
        cur.execute("""SELECT role from con_user
                    where login = '{0}' and password = '{1}' ;"""
                    .format(pelnaLinia[funkcja]["login"],
                            pelnaLinia[funkcja]["password"]))

        uprawnienia = cur.fetchall()
        cur.execute("""SELECT count(*) from talk
                    where id = '{0}'
                    and status!='P';"""
                    .format(pelnaLinia[funkcja]["talk"]))
        ifEgsisting = cur.fetchall()
        if uprawnienia == [("A",)]:
            if ifEgsisting == [(1,)]:
                if pelnaLinia[funkcja]["eventname"] == "":
                    egsist_string = """
                        UPDATE talk SET status='P',  room='{4}' WHERE id =  '{0}';
                        INSERT INTO raiting_by_user(talk_id, user_login, raiting, a_date) VALUES
                            ('{0}', '{1}','{2}','{3}');
                    """.format(pelnaLinia[funkcja]["talk"],
                               pelnaLinia[funkcja]["login"],
                               pelnaLinia[funkcja]["initial_evaluation"],
                               pelnaLinia[funkcja]["start_timestamp"],
                               pelnaLinia[funkcja]["room"])

                    try:
                        cur.execute(egsist_string)
                        cur.close()
                        conn.commit()
                        dict1 = {'status': "OK"}
                        r = json.dumps(dict1)
                        print r
                    except:
                        conn.rollback()
                        dict1 = {'status': "ERROR"}
                        r = json.dumps(dict1)
                        print r

                else:
                    egsist_string = """
                        UPDATE talk SET status='P', event_name='{4}', room='{5}' WHERE id =  '{0}';
                        INSERT INTO raiting_by_user(talk_id, user_login, raiting, a_date) VALUES
                            ('{0}', '{1}','{2}','{3}');
                    """.format(pelnaLinia[funkcja]["talk"],
                               pelnaLinia[funkcja]["login"],
                               pelnaLinia[funkcja]["initial_evaluation"],
                               pelnaLinia[funkcja]["start_timestamp"],
                               pelnaLinia[funkcja]["eventname"],
                               pelnaLinia[funkcja]["room"])

                    try:
                        cur.execute(egsist_string)
                        cur.close()
                        conn.commit()
                        dict1 = {'status': "OK"}
                        r = json.dumps(dict1)
                        print r
                    except:
                        conn.rollback()
                        dict1 = {'status': "ERROR"}
                        r = json.dumps(dict1)
                        print r
            else:
                new_string = """
                    INSERT INTO talk(id, event_name, speaker_login, title, s_date, room, status) VALUES
                        ('{0}', '{1}','{2}','{3}','{4}','{5}','P');

                    INSERT INTO raiting_by_user(talk_id, user_login, raiting, a_date) VALUES
                        ('{0}', '{7}','{6}','{4}');

                """.format(pelnaLinia[funkcja]["talk"],
                           pelnaLinia[funkcja]["eventname"],
                           pelnaLinia[funkcja]["speakerlogin"],
                           pelnaLinia[funkcja]["title"],
                           pelnaLinia[funkcja]["start_timestamp"],
                           pelnaLinia[funkcja]["room"],
                           pelnaLinia[funkcja]["initial_evaluation"],
                           pelnaLinia[funkcja]["login"])

                try:
                    cur.execute(new_string)
                    cur.close()
                    conn.commit()
                    dict1 = {'status': "OK"}
                    r = json.dumps(dict1)
                    print r
                except:
                    conn.rollback()
                    dict1 = {'status': "ERROR"}
                    r = json.dumps(dict1)
                    print r

        else:
            dict1 = {'status': "ERROR"}
            r = json.dumps(dict1)
            print r
    except:
        conn.rollback()
        dict1 = {'status': "ERROR"}
        r = json.dumps(dict1)
        print r

def register_user_for_event(funkcja, pelnaLinia):
    """register user for event"""

    try:
        cur = conn.cursor()
        cur.execute("""SELECT count(*) from con_user
                    where login = '{0}' and password = '{1}' ;"""
                    .format(pelnaLinia[funkcja]["login"],
                            pelnaLinia[funkcja]["password"]))

        uprawnienia = cur.fetchall()
        if uprawnienia == [(1,)]:
            x_string = """
            INSERT INTO user_on_event(login,event_name) VALUES
                ('{0}', '{1}');
            """.format(pelnaLinia[funkcja]["login"],
                       pelnaLinia[funkcja]["eventname"])

            cur.execute(x_string)
            cur.close()
            conn.commit()
            dict1 = {'status': "OK"}
            r = json.dumps(dict1)
            print r
        else:
            dict1 = {'status': "ERROR"}
            r = json.dumps(dict1)
            print r
    except:
        conn.rollback()
        dict1 = {'status': "ERROR"}
        r = json.dumps(dict1)
        print r



def attendance(funkcja, pelnaLinia):
    """check attendance"""

    try:
        cur = conn.cursor()
        cur.execute("""SELECT count(*) from con_user
                    where login = '{0}' and password = '{1}' ;"""
                    .format(pelnaLinia[funkcja]["login"],
                            pelnaLinia[funkcja]["password"]))

        uprawnienia = cur.fetchall()
        if uprawnienia == [(1,)]:
            x_string = """
            INSERT INTO attendance(talk_id,user_login) VALUES
                ('{0}', '{1}');
            """.format(pelnaLinia[funkcja]["talk"],
                       pelnaLinia[funkcja]["login"])

            cur.execute(x_string)
            cur.close()
            conn.commit()
            dict1 = {'status': "OK"}
            r = json.dumps(dict1)
            print r
        else:
            dict1 = {'status': "ERROR"}
            r = json.dumps(dict1)
            print r
    except:
        conn.rollback()
        dict1 = {'status': "ERROR"}
        r = json.dumps(dict1)
        print r



def evaluation(funkcja, pelnaLinia):
    """add talk raiting by user"""

    try:
        cur = conn.cursor()
        cur.execute("""SELECT count(*) from con_user
                    where login = '{0}' and password = '{1}' ;"""
                    .format(pelnaLinia[funkcja]["login"],
                            pelnaLinia[funkcja]["password"]))

        uprawnienia = cur.fetchall()
        if uprawnienia == [(1,)] and pelnaLinia[funkcja]["rating"] >= 0 and \
                                     pelnaLinia[funkcja]["rating"] <= 10:
            x_string = """
            INSERT INTO raiting_by_user(talk_id,user_login,raiting) VALUES
                ('{0}', '{1}', '{2}');
            """.format(pelnaLinia[funkcja]["talk"],
                       pelnaLinia[funkcja]["login"],
                       pelnaLinia[funkcja]["rating"])

            cur.execute(x_string)
            cur.close()
            conn.commit()
            dict1 = {'status': "OK"}
            r = json.dumps(dict1)
            print r
        else:
            dict1 = {'status': "ERROR"}
            r = json.dumps(dict1)
            print r
    except:
        conn.rollback()
        dict1 = {'status': "ERROR"}
        r = json.dumps(dict1)
        print r


def reject(funkcja, pelnaLinia):
    """reject talk from waiting list"""

    try:
        cur = conn.cursor()
        cur.execute("""SELECT role from con_user
                    where login = '{0}' and password = '{1}' ;"""
                    .format(pelnaLinia[funkcja]["login"],
                            pelnaLinia[funkcja]["password"]))

        uprawnienia = cur.fetchall()
        if uprawnienia == [("A",)]:
            x_string = """
            UPDATE talk SET status='R'
                WHERE id =  '{0}';
            """.format(pelnaLinia[funkcja]["talk"])

            cur.execute(x_string)
            cur.close()
            conn.commit()
            dict1 = {'status': "OK"}
            r = json.dumps(dict1)
            print r
        else:
            dict1 = {'status': "ERROR"}
            r = json.dumps(dict1)
            print r
    except:
        conn.rollback()
        dict1 = {'status': "ERROR"}
        r = json.dumps(dict1)
        print r


def proposal(funkcja, pelnaLinia):
    """add talk to waiting list"""
    try:
        cur = conn.cursor()
        cur.execute("""SELECT count(*) from con_user
                    where login = '{0}' and password = '{1}' ;"""
                    .format(pelnaLinia[funkcja]["login"],
                            pelnaLinia[funkcja]["password"]))

        uprawnienia = cur.fetchall()
        if uprawnienia == [(1,)]:
            x_string = """
            INSERT INTO talk(id, speaker_login, title, s_date, status) VALUES
                ('{0}', '{1}','{2}','{3}', 'W');
            """.format(pelnaLinia[funkcja]["talk"],
                       pelnaLinia[funkcja]["login"],
                       pelnaLinia[funkcja]["title"],
                       pelnaLinia[funkcja]["start_timestamp"])

            cur.execute(x_string)
            cur.close()
            conn.commit()
            dict1 = {'status': "OK"}
            r = json.dumps(dict1)
            print r
        else:
            dict1 = {'status': "ERROR"}
            r = json.dumps(dict1)
            print r
    except:
        conn.rollback()
        dict1 = {'status': "ERROR"}
        r = json.dumps(dict1)
        print r


def friends(funkcja, pelnaLinia):
    """add friend request"""

    try:
        cur = conn.cursor()
        cur.execute("""SELECT count(*) from con_user
                    where login = '{0}' and password = '{1}' ;"""
                    .format(pelnaLinia[funkcja]["login1"],
                            pelnaLinia[funkcja]["password"]))

        uprawnienia = cur.fetchall()
        if uprawnienia == [(1,)]:
            x_string = """
            INSERT INTO friend_request(login1, login2) VALUES
                ('{0}', '{1}');
            """.format(pelnaLinia[funkcja]["login1"],
                       pelnaLinia[funkcja]["login2"])

            cur.execute(x_string)
            cur.close()
            conn.commit()
            dict1 = {'status': "OK"}
            r = json.dumps(dict1)
            print r
        else:
            dict1 = {'status': "ERROR"}
            r = json.dumps(dict1)
            print r
    except:
        conn.rollback()
        dict1 = {'status': "ERROR"}
        r = json.dumps(dict1)
        print r


def user_plan(funkcja, pelnaLinia):
    """show user plan"""

    try:
        cur = conn.cursor()
        x_string = """
        SELECT distinct u.login, t.id, t.s_date, t.title, t.room
        FROM user_on_event u
        join event e using (event_name)
        join talk t using (event_name)
        where u.login = '{0}'
        AND t.status='P'
        order BY 3 desc
        """.format(pelnaLinia[funkcja]["login"])

        if pelnaLinia[funkcja]["limit"] == "0":
            x_string = x_string+";"
        else:
            x_string = x_string+"limit {0};".format(pelnaLinia[funkcja]["limit"])
        #print x_string
        cur.execute(x_string)

        rows = cur.fetchall()


        cur.close()
        conn.commit()

        columns = ('login', 'talk', 'start_timestamp', 'title', 'room')
        results = []

        for t_row in rows:
            temp_dict1 = collections.OrderedDict()
            for i in range(len(columns)):
                temp_dict1[columns[i]] = str(t_row[i])
            results.append(temp_dict1)
            #print "dupa ", temp_dict1

        dict1 = {'status': "OK", "data": results}
        r = json.dumps(dict1)
        print r
    except:
        conn.rollback()
        dict1 = {'status': "ERROR"}
        r = json.dumps(dict1)
        print r

def day_plan(funkcja, pelnaLinia):
    """show day plan"""

    try:
        cur = conn.cursor()
        x_string = """
        SELECT distinct t.id, t.s_date, t.title, t.room
        FROM  event e
        join talk t using (event_name)
        where date_trunc('day',t.s_date) = date_trunc('day',timestamp '{0}')
        AND t.status='P'
        order BY 4,2 desc;
        """.format(pelnaLinia[funkcja]["timestamp"])

        #print x_string
        cur.execute(x_string)

        rows = cur.fetchall()


        cur.close()
        conn.commit()

        columns = ('talk', 'start_timestamp', 'title', 'room')
        results = []

        for t_row in rows:
            temp_dict1 = collections.OrderedDict()
            for i in range(len(columns)):
                temp_dict1[columns[i]] = str(t_row[i])
            results.append(temp_dict1)
            #print "dupa ", temp_dict1

        dict1 = {'status': "OK", "data": results}
        r = json.dumps(dict1)
        print r
    except:
        conn.rollback()
        dict1 = {'status': "ERROR"}
        r = json.dumps(dict1)
        print r

def best_talks(funkcja, pelnaLinia):
    """show best talks"""
    cur = conn.cursor()
    if pelnaLinia[funkcja]["all"] == 1:
        try:
            x_string = """
            SELECT distinct t.id, t.s_date, t.title, t.room, AVG(rbu.raiting)
            FROM talk t
            join raiting_by_user rbu on (t.id=rbu.talk_id)
            where t.s_date >= '{0}'
            and t.s_date <= '{1}'
            AND t.status='P'
            group by t.id
            order BY 3 desc
            """.format(pelnaLinia[funkcja]["start_timestamp"], pelnaLinia[funkcja]["end_timestamp"])

            if pelnaLinia[funkcja]["limit"] == "0":
                x_string = x_string+";"
            else:
                x_string = x_string+"limit {0};".format(pelnaLinia[funkcja]["limit"])
            #print x_string
            cur.execute(x_string)
            rows = cur.fetchall()
            cur.close()
            conn.commit()
            columns = ('talk', 'start_timestamp', 'title', 'room')
            results = []
            for t_row in rows:
                temp_dict1 = collections.OrderedDict()
                for i in range(len(columns)):
                    temp_dict1[columns[i]] = str(t_row[i])
                results.append(temp_dict1)
                #print "dupa ", temp_dict1

            dict1 = {'status': "OK", "data": results}
            r = json.dumps(dict1)
            print r
        except:
            conn.rollback()
            dict1 = {'status': "ERROR"}
            r = json.dumps(dict1)
            print r
    else:
        try:
            x_string = """
            SELECT distinct t.id, t.s_date, t.title, t.room, AVG(rbu.raiting)
            FROM talk t
            join attendance a on (t.id=a.talk_id)
            join raiting_by_user rbu on (rbu.user_login = a.user_login)

            where t.s_date >= '{0}'
            and t.s_date <= '{1}'
            AND t.status='P'
            group by t.id

            order BY 3 desc
            """.format(pelnaLinia[funkcja]["start_timestamp"], pelnaLinia[funkcja]["end_timestamp"])

            if pelnaLinia[funkcja]["limit"] == "0":
                x_string = x_string+";"
            else:
                x_string = x_string+"limit {0};".format(pelnaLinia[funkcja]["limit"])
            #print x_string
            cur.execute(x_string)
            rows = cur.fetchall()
            cur.close()
            conn.commit()
            columns = ('talk', 'start_timestamp', 'title', 'room')
            results = []
            for t_row in rows:
                temp_dict1 = collections.OrderedDict()
                for i in range(len(columns)):
                    temp_dict1[columns[i]] = str(t_row[i])
                results.append(temp_dict1)
                #print "dupa ", temp_dict1

            dict1 = {'status': "OK", "data": results}
            r = json.dumps(dict1)
            print r
        except:
            conn.rollback()
            dict1 = {'status': "ERROR"}
            r = json.dumps(dict1)
            print r

def most_popular_talks(funkcja, pelnaLinia):
    """show most_popular_talks"""

    try:
        cur = conn.cursor()
        x_string = """
        SELECT distinct t.id, t.s_date, t.title, t.room, count(t.id)
        FROM  talk t
        join attendance a on (t.id=a.talk_id)
        where t.s_date >= '{0}'
        and t.s_date <= '{1}'
        AND t.status='P'
        group by t.id
        order BY 5 desc
        """.format(pelnaLinia[funkcja]["start_timestamp"], pelnaLinia[funkcja]["end_timestamp"])

        if pelnaLinia[funkcja]["limit"] == "0":
            x_string = x_string+";"
        else:
            x_string = x_string+"limit {0};".format(pelnaLinia[funkcja]["limit"])
        #print x_string
        cur.execute(x_string)
        rows = cur.fetchall()
        cur.close()
        conn.commit()
        columns = ('talk', 'start_timestamp', 'title', 'room')
        results = []

        for t_row in rows:
            temp_dict1 = collections.OrderedDict()
            for i in range(len(columns)):
                temp_dict1[columns[i]] = str(t_row[i])
            results.append(temp_dict1)
            #print "dupa ", temp_dict1

        dict1 = {'status': "OK", "data": results}
        r = json.dumps(dict1)
        print r
    except:
        conn.rollback()
        dict1 = {'status': "ERROR"}
        r = json.dumps(dict1)
        print r

def attended_talks(funkcja, pelnaLinia):
    """show attended_talks"""

    try:
        cur = conn.cursor()
        cur.execute("""SELECT count(*) from con_user
                    where login = '{0}' and password = '{1}' ;"""
                    .format(pelnaLinia[funkcja]["login"],
                            pelnaLinia[funkcja]["password"]))

        uprawnienia = cur.fetchall()
        if uprawnienia == [(1,)]:
            x_string = """
            SELECT distinct t.id, t.s_date, t.title, t.room
            FROM  talk t
            join attendance a on (t.id=a.talk_id)
            where a.user_login = '{0}'
            AND t.status='P';
            --order BY 5 desc
            """.format(pelnaLinia[funkcja]["login"])

            #print x_string
            cur.execute(x_string)
            rows = cur.fetchall()
            cur.close()
            conn.commit()
            columns = ('talk', 'start_timestamp', 'title', 'room')
            results = []

            for t_row in rows:
                temp_dict1 = collections.OrderedDict()
                for i in range(len(columns)):
                    temp_dict1[columns[i]] = str(t_row[i])
                results.append(temp_dict1)
                #print "dupa ", temp_dict1

            dict1 = {'status': "OK", "data": results}
            r = json.dumps(dict1)
            print r
        else:
            dict1 = {'status': "ERROR"}
            r = json.dumps(dict1)
            print r
    except:
        conn.rollback()
        dict1 = {'status': "ERROR"}
        r = json.dumps(dict1)
        print r


def abandoned_talks(funkcja, pelnaLinia):
    """show abandoned_talks"""

    try:
        cur = conn.cursor()
        cur.execute("""SELECT role from con_user
                    where login = '{0}' and password = '{1}' ;"""
                    .format(pelnaLinia[funkcja]["login"],
                            pelnaLinia[funkcja]["password"]))

        uprawnienia = cur.fetchall()
        if uprawnienia == [("A",)]:
            x_string = """
            SELECT distinct t.id, t.s_date, t.title, t.room, count_on_event(t.event_name) - count(t.id) as number
            FROM  talk t
            join attendance a on (t.id=a.talk_id)
            where t.status='P'
            group by t.id
            order BY 5 desc
            """

            if pelnaLinia[funkcja]["limit"] == "0":
                x_string = x_string+";"
            else:
                x_string = x_string+"limit {0};".format(pelnaLinia[funkcja]["limit"])
            #print x_string
            cur.execute(x_string)
            rows = cur.fetchall()
            cur.close()
            conn.commit()
            columns = ('talk', 'start_timestamp', 'title', 'room', 'number')
            results = []

            for t_row in rows:
                temp_dict1 = collections.OrderedDict()
                for i in range(len(columns)):
                    temp_dict1[columns[i]] = str(t_row[i])
                results.append(temp_dict1)
                #print "dupa ", temp_dict1

            dict1 = {'status': "OK", "data": results}
            r = json.dumps(dict1)
            print r
        else:
            dict1 = {'status': "ERROR"}
            r = json.dumps(dict1)
            print r
    except:
        conn.rollback()
        dict1 = {'status': "ERROR"}
        r = json.dumps(dict1)
        print r


def recently_added_talks(funkcja, pelnaLinia):
    """show recently added talks"""

    try:
        cur = conn.cursor()
        x_string = """
        SELECT distinct t.id, t.speaker_login, t.s_date, t.title, t.room
        FROM  talk t
        where t.status='P'
        order BY 3 desc
        """
        if pelnaLinia[funkcja]["limit"] == "0":
            x_string = x_string+";"
        else:
            x_string = x_string+"limit {0};".format(pelnaLinia[funkcja]["limit"])
        #print x_string
        cur.execute(x_string)

        rows = cur.fetchall()


        cur.close()
        conn.commit()

        columns = ('talk', 'speakerlogin', 'start_timestamp', 'title', 'room')
        results = []

        for t_row in rows:
            temp_dict1 = collections.OrderedDict()
            for i in range(len(columns)):
                temp_dict1[columns[i]] = str(t_row[i])
            results.append(temp_dict1)
            #print "dupa ", temp_dict1

        dict1 = {'status': "OK", "data": results}
        r = json.dumps(dict1)
        print r
    except:
        conn.rollback()
        dict1 = {'status': "ERROR"}
        r = json.dumps(dict1)
        print r

def rejected_talks(funkcja, pelnaLinia):
    """show rejected_talks"""

    try:
        cur = conn.cursor()
        cur.execute("""SELECT count(*) from con_user
                    where login = '{0}' and password = '{1}' ;"""
                    .format(pelnaLinia[funkcja]["login"],
                            pelnaLinia[funkcja]["password"]))

        uprawnienia = cur.fetchall()
        if uprawnienia == [(1,)]:
            x_string = """
            SELECT distinct t.id, t.speaker_login, t.s_date, t.title
            FROM  talk t
            where t.status = 'R'
            --order BY 5 desc

            """
            if uprawnienia == [("A",)]:
                x_string = x_string + ";"
            else:
                x_string = x_string + """AND t.speaker_login = '{0}';
                    """.format(pelnaLinia[funkcja]["login"])
            #print x_string
            cur.execute(x_string)
            rows = cur.fetchall()
            cur.close()
            conn.commit()
            columns = ('talk', 'speakerlogin', 'start_timestamp', 'title')
            results = []

            for t_row in rows:
                temp_dict1 = collections.OrderedDict()
                for i in range(len(columns)):
                    temp_dict1[columns[i]] = str(t_row[i])
                results.append(temp_dict1)
                #print "dupa ", temp_dict1

            dict1 = {'status': "OK", "data": results}
            r = json.dumps(dict1)
            print r
        else:
            dict1 = {'status': "ERROR"}
            r = json.dumps(dict1)
            print r
    except:
        conn.rollback()
        dict1 = {'status': "ERROR"}
        r = json.dumps(dict1)
        print r


def proposals(funkcja, pelnaLinia):
    """show proposals"""

    try:
        cur = conn.cursor()
        cur.execute("""SELECT role from con_user
                    where login = '{0}' and password = '{1}' ;"""
                    .format(pelnaLinia[funkcja]["login"],
                            pelnaLinia[funkcja]["password"]))

        uprawnienia = cur.fetchall()
        if uprawnienia == [("A",)]:
            x_string = """
            SELECT distinct t.id, t.speaker_login, t.s_date, t.title
            FROM  talk t
            where t.status = 'W';
            --order BY 5 desc
            """

            #print x_string
            cur.execute(x_string)
            rows = cur.fetchall()
            cur.close()
            conn.commit()
            columns = ('talk', 'speakerlogin', 'start_timestamp', 'title')
            results = []

            for t_row in rows:
                temp_dict1 = collections.OrderedDict()
                for i in range(len(columns)):
                    temp_dict1[columns[i]] = str(t_row[i])
                results.append(temp_dict1)
                #print "dupa ", temp_dict1

            dict1 = {'status': "OK", "data": results}
            r = json.dumps(dict1)
            print r
        else:
            dict1 = {'status': "ERROR"}
            r = json.dumps(dict1)
            print r
    except:
        conn.rollback()
        dict1 = {'status': "ERROR"}
        r = json.dumps(dict1)
        print r


def friends_talks(funkcja, pelnaLinia):
    """show friends_talks"""

    try:
        cur = conn.cursor()
        cur.execute("""SELECT count(*) from con_user
                    where login = '{0}' and password = '{1}' ;"""
                    .format(pelnaLinia[funkcja]["login"],
                            pelnaLinia[funkcja]["password"]))

        uprawnienia = cur.fetchall()
        if uprawnienia == [(1,)]:
            x_string = """
            SELECT distinct t.id, f.login2, t.s_date, t.title, t.room
            FROM friends f
            join talk t on (t.speaker_login=f.login2)
            where t.s_date >= '{0}'
            and t.s_date <= '{1}'
            and f.login1 = '{2}'
            AND t.status='P'
            order BY 3 desc
            """.format(pelnaLinia[funkcja]["start_timestamp"],
                       pelnaLinia[funkcja]["end_timestamp"],
                       pelnaLinia[funkcja]["login"])

            if pelnaLinia[funkcja]["limit"] == "0":
                x_string = x_string+";"
            else:
                x_string = x_string+"limit {0};".format(pelnaLinia[funkcja]["limit"])
            #print x_string
            cur.execute(x_string)
            rows = cur.fetchall()
            cur.close()
            conn.commit()
            columns = ('talk', 'speakerlogin', 'start_timestamp', 'title', 'room')
            results = []
            for t_row in rows:
                temp_dict1 = collections.OrderedDict()
                for i in range(len(columns)):
                    temp_dict1[columns[i]] = str(t_row[i])
                results.append(temp_dict1)
                #print "dupa ", temp_dict1

            dict1 = {'status': "OK", "data": results}
            r = json.dumps(dict1)
            print r
        else:
            dict1 = {'status': "ERROR"}
            r = json.dumps(dict1)
            print r
    except:
        conn.rollback()
        dict1 = {'status': "ERROR"}
        r = json.dumps(dict1)
        print r



def friends_events(funkcja, pelnaLinia):
    """show friends_events"""

    try:
        cur = conn.cursor()
        cur.execute("""SELECT count(*) from con_user
                    where login = '{0}' and password = '{1}' ;"""
                    .format(pelnaLinia[funkcja]["login"],
                            pelnaLinia[funkcja]["password"]))

        uprawnienia = cur.fetchall()
        if uprawnienia == [(1,)]:
            x_string = """
            SELECT distinct f.login1, u.event_name , f.login2
            FROM  friends f
            join user_on_event u on (f.login2 = u.login)
            where f.login1 = '{0}'
            and u.event_name = '{1}';
            --order BY 5 desc
            """.format(pelnaLinia[funkcja]["login"], pelnaLinia[funkcja]["eventname"])

            #print x_string
            cur.execute(x_string)
            rows = cur.fetchall()
            cur.close()
            conn.commit()
            columns = ('login', 'eventname', 'friendlogin')
            results = []

            for t_row in rows:
                temp_dict1 = collections.OrderedDict()
                for i in range(len(columns)):
                    temp_dict1[columns[i]] = str(t_row[i])
                results.append(temp_dict1)
                #print "dupa ", temp_dict1

            dict1 = {'status': "OK", "data": results}
            r = json.dumps(dict1)
            print r
        else:
            dict1 = {'status': "ERROR"}
            r = json.dumps(dict1)
            print r
    except:
        conn.rollback()
        dict1 = {'status': "ERROR"}
        r = json.dumps(dict1)
        print r


def recommended_talks(funkcja, pelnaLinia):
    """show recomanded talks"""
    cur = conn.cursor()
    cur.execute("""SELECT count(*) from con_user
                where login = '{0}' and password = '{1}' ;"""
                .format(pelnaLinia[funkcja]["login"],
                        pelnaLinia[funkcja]["password"]))

    uprawnienia = cur.fetchall()
    if uprawnienia == [(1,)]:
        try:
            x_string = """
            SELECT distinct t.id, t.speaker_login, t.s_date, t.title, t.room, score_of_talk('{2}', t.id)
            FROM talk t
            where t.s_date >= '{0}'
            and t.s_date <= '{1}'
            AND t.status='P'
            order BY 6 desc
            """.format(pelnaLinia[funkcja]["start_timestamp"],
                       pelnaLinia[funkcja]["end_timestamp"],
                       pelnaLinia[funkcja]["login"])

            if pelnaLinia[funkcja]["limit"] == "0":
                x_string = x_string+";"
            else:
                x_string = x_string+"limit {0};".format(pelnaLinia[funkcja]["limit"])
            #print x_string
            cur.execute(x_string)
            rows = cur.fetchall()
            cur.close()
            conn.commit()
            columns = ('talk', 'speakerlogin', 'start_timestamp', 'title', 'room', 'score')
            results = []
            for t_row in rows:
                temp_dict1 = collections.OrderedDict()
                for i in range(len(columns)):
                    temp_dict1[columns[i]] = str(t_row[i])
                results.append(temp_dict1)
                #print "dupa ", temp_dict1

            dict1 = {'status': "OK", "data": results}
            r = json.dumps(dict1)
            print r
        except:
            conn.rollback()
            dict1 = {'status': "ERROR"}
            r = json.dumps(dict1)
            print r
    else:
        dict1 = {'status': "ERROR"}
        r = json.dumps(dict1)
        print r

def notImplemented(nOf, fFL):
    dict1 = {'status': "NOT IMPLEMENTED"}
    r = json.dumps(dict1)
    print r


def API_func(nOf, fFL):
    """nOf-name of function, fFL-full function line"""
    #print nOf
    if nOf == "organizer":
        organizer(nOf, fFL)
    elif nOf == "event":
        event(nOf, fFL)
    elif nOf == "user":
        user(nOf, fFL)
    elif nOf == "talk":
        talk(nOf, fFL)
    elif nOf == "register_user_for_event":
        register_user_for_event(nOf, fFL)
    elif nOf == "attendance":
        attendance(nOf, fFL)
    elif nOf == "evaluation":
        evaluation(nOf, fFL)
    elif nOf == "reject":
        reject(nOf, fFL)
    elif nOf == "proposal":
        proposal(nOf, fFL)
    elif nOf == "friends":
        friends(nOf, fFL)
    elif nOf == "user_plan":
        user_plan(nOf, fFL)
    elif nOf == "day_plan":
        day_plan(nOf, fFL)
    elif nOf == "best_talks":
        best_talks(nOf, fFL)
    elif nOf == "most_popular_talks":
        most_popular_talks(nOf, fFL)
    elif nOf == "attended_talks":
        attended_talks(nOf, fFL)
    elif nOf == "abandoned_talks":
        abandoned_talks(nOf, fFL)
    elif nOf == "recently_added_talks":
        recently_added_talks(nOf, fFL)
    elif nOf == "rejected_talks":
        rejected_talks(nOf, fFL)
    elif nOf == "proposals":
        proposals(nOf, fFL)
    elif nOf == "friends_talks":
        friends_talks(nOf, fFL)
    elif nOf == "friends_events":
        friends_events(nOf, fFL)
    elif nOf == "recommended_talks":
        recommended_talks(nOf, fFL)
    else:
        notImplemented(nOf, fFL)


#start bazy
first_line = sys.stdin.readline()
data = json.loads(first_line)
#polaczenie sie z baza
try:
    conn = psycopg2.connect("""dbname='{0}' user='{1}' host='localhost' password='{2}'"""
                            .format(data["open"]["baza"],
                                    data["open"]["login"],
                                    data["open"]["password"]))
    temp_dict = {'status': "OK"}
    temp_r = json.dumps(temp_dict)
    print temp_r
except:
    temp_dict = {'status': "ERROR"}
    temp_r = json.dumps(temp_dict)
    print temp_r

#utworzenie bazy danych
try:
    cursor = conn.cursor()
    cursor.execute(open("../baza/baza.sql", "r").read())
    cursor.close()
    conn.commit()
except:
    conn.rollback()




for line in sys.stdin:
    data = json.loads(line)
    x = data.keys()[0]
    API_func(x, data)
