drop table student_info;

create table student_info(
	student_id  	number(6) 		constraint student_info_student_id_pk 		primary key
,	student_name 	varchar2(15) 	constraint student_info_student_name_nn 	not null
,	student_gender 	varchar2(3) 	constraint student_info_student_gender_nn 	not null
,	korean_score 	number(3) 		constraint student_info_korean_score_nn 	not null
,	english_score 	number(3) 		constraint student_info_english_score_nn 	not null
,	math_score 		number(3) 		constraint student_info_math_score_nn 		not null
,	science_score 	number(3) 		constraint student_info_science_score_nn 	not null
,	constraint student_info_student_id_ch 		check (student_id between 100000 and 999999)
,	constraint student_info_student_gender_ck 	check (student_gender in ('남', '여'))
,	constraint student_info_korean_score_ck 	check (korean_score between 0 and 100)
,	constraint student_info_english_score_ck 	check (english_score between 0 and 100)
,	constraint student_info_math_score_ck 		check (math_score between 0 and 100)
,	constraint student_info_science_score_ck 	check (science_score between 0 and 100)
);

insert into student_info
values(143407, '배준영', '남', 100, 100, 100, 100);

insert into student_info
values(230308, '김연아', '여', 98, 97, 80, 85);

insert into student_info
values(123456, '박지성', '남', 80, 90, 77, 67);

insert into student_info
values(987654, '김연경', '여', 50, 96, 23, 38);

commit;

select * from student_info where student_id = 143407;

select * from student_info;

update student_info set science_score = 83 where student_id = 123456;

commit;

delete from student_info where student_id = 987654;

commit;