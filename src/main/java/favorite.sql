create table favorite(
	id varchar(50) not null,
	content_id int not null,
	title varchar(200) not null,
	favorite decimal(1) ,
	primary key(id, content_id)
);

drop table favorite;

select * from favorite;