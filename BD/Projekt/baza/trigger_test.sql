--© Michał Martusewicz
INSERT INTO con_user(login,password,role) VALUES
            ('adam','student','U' ),
            ('bartek','123','U' ),
            ('kazik','321','U' );

select * from con_user;

INSERT INTO friend_request(login1,login2) VALUES
            ('bartek', 'adam'),
            ('kazik', 'adam');


select * from friend_request;
select * from friends;

INSERT INTO friend_request(login1,login2) VALUES
            ('adam', 'bartek');

select * from friend_request;
select * from friends;
