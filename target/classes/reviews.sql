CREATE TABLE reviews (
review_id int auto_increment primary key,
user_id varchar(50) not null,
movie_id varchar(50) not null,
rating DECIMAL(3, 1),  -- 각각의 사람이 한 평점 0~10점
review_text varchar(3000) not null,
review_date timestamp not null,
FOREIGN KEY (user_id) REFERENCES member(id)
);