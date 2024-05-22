create table author (
id int auto_increment primary key, 
name varchar(255),
email varchar(255) not null unique,
password varchar(255), 
created_time datetime DEFAULT CURRENT_TIMESTAMP);


create table post ( 
id int auto_increment primary key,
tltie varchar(255) not null,
contents varchar(3000));


create table author_address (
id int primary key,
country varchar(255),
city varchar(255),
street varchar(255),
author_id int not null unique, 
foreign key(author_id) references author(id) on delete cascade);


create table author_post (
id int auto_increment primary key,
author_id int not null , 
post_id int not null,
foreign key(author_id) references author(id), foreign key(post_id) references post(id));
