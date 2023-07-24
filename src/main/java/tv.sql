create table tv(
	id int primary key,
	title varchar(200) not null,
	overview varchar(8000),
	posterpath varchar(200),
	popularity decimal(10,2) not null,
	releasedate varchar(100) 
);

drop table tv;

select * from tv;

insert into 