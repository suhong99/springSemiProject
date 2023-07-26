

create table bbscomment(
	seq int not null,
	id varchar(50) not null,
	content varchar(1000) not null,
	wdate timestamp not null
);

alter table bbscomment 
and foreign key(id) references member(id);


select * from bbs;

alter table bbs add column commentcount int null default 0;

update bbs
set commentcount =( select count(seq) 
					from bbscomment
					where bbs.seq = bbscomment.seq);
