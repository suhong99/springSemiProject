create table favorite(
	id varchar(50) not null,
	content_id int not null,
	title varchar(200) not null,
	favorite decimal(1) ,
	primary key(id, content_id)
);

ALTER TABLE favorite
ADD CONSTRAINT fk_favorite_member_id
FOREIGN KEY (id) REFERENCES member(id);

ALTER TABLE bbs
ADD CONSTRAINT fk_bbs_member_id
FOREIGN KEY (id) REFERENCES member(id);

ALTER TABLE netflixcomment
ADD CONSTRAINT fk_netflixcomment_member_id
FOREIGN KEY (id) REFERENCES member(id);

drop table favorite;

select * from favorite;