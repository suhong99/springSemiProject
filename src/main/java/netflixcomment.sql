create table netflixcomment(
	comment_id int auto_increment primary key,
	seq int not null, -- movie id
	id varchar(50) not null, -- user id 
	content varchar(1000) not null,
	wdate timestamp not null,
	rating decimal(3,1) not null
);

drop table netflixcomment;

alter table netflixcomment
add foreign key(id) references member(id);

select * from netflixcomment;

select avg(rating) 
		from netflixcomment
		where seq = 667538;
		
delete from netflixcomment
		where comment_id = 1;