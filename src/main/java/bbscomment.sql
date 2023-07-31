select * from readcount;

drop table bbscomment;

create table bbscomment(
	comment_id int auto_increment primary key,
	seq int not null,
	id varchar(50) not null,
	content varchar(1000) not null,
	wdate timestamp not null
);


alter table bbscomment 
add foreign key(id) references member(id);


select * from bbs;

alter table bbs add column commentcount int null default 0;

update bbs
set commentcount =( select count(seq) 
					from bbscomment
					where bbs.seq = bbscomment.seq);
					

					
					
					
	
drop table readcount;

create table readcount(
id varchar(50),
seq int
);

select * from readcount;					
