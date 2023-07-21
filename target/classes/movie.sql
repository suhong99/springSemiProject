create table movie(
	id int primary key,
	title varchar(200) not null,
	overview varchar(8000),
	posterpath varchar(200),
	popularity decimal(10,2) not null,
	releasedate varchar(100) 
);

drop table movie;

select * from movie;

insert into 