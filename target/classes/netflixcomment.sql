
create table netflixcomment(
	seq int not null,
	id varchar(50) not null,
	content varchar(1000) not null,
	wdate timestamp not null
);

alter table netflixcomment
add foreign key(id) references member(id);

alter table netflixcomment
add foreign key(id) references member(id);
