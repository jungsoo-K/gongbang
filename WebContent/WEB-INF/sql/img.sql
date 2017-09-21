
--drop 

drop table img;

select * from img

--create

create table img(
	imgno 	number not null,
	name 	varchar(50) not null, 
	title  	varchar(50) not null, 
	content varchar(50) null, 
	passwd 	varchar(50) not null, 
	wdate	date not null, 
	fname 	varchar(50) default 'member.jpg', 
	grpno 	number default 0, 
	indent 	number default 0, 
	ansnum 	number default 0, 
	refnum 	number default 0,
	primary key(imgno)
);

--insert 부모

INSERT INTO img(imgno, wname, title, content, passwd, grpno,fname)  
VALUES((SELECT NVL(MAX(img2no), 0) + 1 as imgno FROM img), 
'왕눈이', '제목', '내용', '123',
(SELECT NVL(MAX(grpno), 0) + 1 as grpno FROM img),
'soju.jpg') ;

--up ansnum

update img 
set
ansnum = ansnum+1
where grpno=1 and ansnum>=1;

--select list

select imgno, name, title, wdate, r
from(
select imgno, name, title, wdate, rownum as r
from(
select imgno, name, title, wdate
from img
where name like '%'||'홍길동'||'%'
order by grpno desc, ansnum asc 
)
)where r>=1 and r<=3;

--select one

select imgno, name, title, content, wdate, fname
from img
where imgno=1;

--update Info

update img 
set
name='나길동',
title='제목2',
content='내용2'
where imgno=1;

--update file

update img
set
fname = 'img1.jpg'
where imgno=1;

--delete

delete from img
where imgno=1;

--file list

select imgno, fname 
from img
where imgno>0 and imgno<6