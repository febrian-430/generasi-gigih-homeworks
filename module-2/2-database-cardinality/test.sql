use generasi_gigih;

drop table if exists users;

create table users(
    id int auto_increment primary key,
    name varchar(100) not null
);

insert into users(name) values('123'),('456'),('789');

select * from users;