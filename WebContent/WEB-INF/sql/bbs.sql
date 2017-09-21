DROP TABLE bbs PURGE; 
 
select * from BBS

select count(*) from bbs
where refnum = 1;

CREATE TABLE bbs ( 
  bbsno   NUMBER(7)     NOT NULL,  -- 湲� �씪�젴 踰덊샇, -9999999 ~ +9999999 
  wname   VARCHAR(20)   NOT NULL,  -- 湲��벖�씠 
  title   VARCHAR(100)  NOT NULL,  -- �젣紐�(*) 
  content VARCHAR(4000) NOT NULL,  -- 湲� �궡�슜 
  passwd  VARCHAR(15)   NOT NULL,  -- 鍮꾨� 踰덊샇 
  viewcnt NUMBER(5)     DEFAULT 0, -- 議고쉶�닔, 湲곕낯媛� �궗�슜 
  wdate   DATE          NOT NULL,  -- �벑濡� �궇吏�, sysdate 
  grpno   NUMBER(7)     DEFAULT 0, -- 遺�紐④� 踰덊샇 
  indent  NUMBER(2)     DEFAULT 0, -- �떟蹂��뿬遺�,�떟蹂��쓽 源딆씠
  ansnum  NUMBER(5)     DEFAULT 0, -- �떟蹂� �닚�꽌 
  PRIMARY KEY (bbsno)  
); 
 
 alter table bbs
 add refnum number default 0
 
 select bbsno, title, grpno, indent, ansnum, refnum
 from BBS
 order by grpno desc, ansnum
2. 湲� 異붽�(C: Create) 
 
- MAX(bbsno): bbsno 而щ읆�뿉�꽌 理쒕�媛믪쓣 異붿텧 
SELECT MAX(bbsno) as max FROM bbs; 
 
 MAX 
 ---- 
 NULL <- 媛믪씠 �뾾�뒗 寃쎌슦 
 
 
SELECT MAX(bbsno)+1 as max FROM bbs; 
 
 MAX 
 ---- 
 NULL <- �궗移숈뿰�궛�씠 �쓽誘멸� �뾾�쓬. 
 
  
- NVL(): null 媛믪쓣 0�쑝濡� 蹂�寃� 媛��뒫�븿. 
SELECT NVL(MAX(bbsno), 0) as max FROM bbs; 
 
 MAX 
 --- 
   0 
   
 
- �깉濡쒖슫 踰덊샇�쓽 �깮�꽦   
SELECT NVL(MAX(bbsno), 0) + 1 as bbsno FROM bbs; 
 
BBSNO 
 ----- 
     1 
 
     
- �꽌釉뚯옘由щ�� �씠�슜�븳 �젅肄붾뱶 異붽� 
INSERT INTO bbs(bbsno, wname, title, content, passwd, wdate, grpno)  
VALUES((SELECT NVL(MAX(bbsno), 0) + 1 as bbsno FROM bbs), 
'�솗�늿�씠', '�젣紐�', '�궡�슜', '123', sysdate,                 
(SELECT NVL(MAX(grpno), 0) + 1 as grpno FROM bbs))

 
         
3. �쟾泥� 湲� 紐⑸줉(S:Total Select List), 理쒖떊湲� 癒쇱� 異쒕젰 
   - ASC: �삤由� 李⑥닚, DESC: �궡由� 李⑥닚 
SELECT bbsno, wname, title, content, passwd, viewcnt, wdate, grpno, indent, ansnum 
FROM bbs  
ORDER BY bbsno DESC; 
 
 BBSNO WNAME TITLE CONTENT PASSWD VIEWCNT WDATE                 GRPNO INDENT ANSNUM 
 ----- ----- ----- ------- ------ ------- --------------------- ----- ------ ------ 
     1 �솗�늿�씠   �젣紐�    �궡�슜      123          0 2013-10-31 20:46:18.0     0      0      0 
 
 
      
4. 議고쉶�닔 利앷� 
UPDATE bbs 
SET viewcnt = viewcnt + 1 
WHERE bbsno=1; 
 
 
 
5. 1嫄댁쓽 湲� 蹂닿린(R:Read, PK �궗�슜) 
SELECT bbsno, wname, title, content, passwd, viewcnt, wdate, grpno, indent, ansnum 
FROM bbs  
WHERE bbsno = 1; 
 
 PDSNO WNAME TITLE CONTENT PASSWD VIEWCNT WDATE                 GRPNO INDENT ANSNUM FILENAME FILESIZE 
 ----- ----- ----- ------- ------ ------- --------------------- ----- ------ ------ -------- -------- 
     1 �솗�늿�씠   �젣紐�    �궡�슜      123          0 2013-10-21 21:07:30.0     0      0      0 file.txt        0 
 
 
 
 
6. 湲� �닔�젙(U:Update), PK�뒗 �젅肄붾뱶瑜� 援щ텇�븯�뒗 怨좎쑀 湲곕뒫�쓣 媛�吏�怨� �엳�쓬�쑝濡� 
   �닔�젙�븯�뒗 寃껋� 沅뚯옣�븯吏� �븡�쓬. 
    
-- PK �닔�젙, PK�뒗 以묐났 異⑸룎�씠 諛쒖깮 �븷 �닔 �엳�쓬�쑝濡� 蹂�寃쎌쓣 沅뚯옣�븯吏� �븡�쓬.  
   
-- �씪諛� 而щ읆�쓽 蹂�寃�, �씪諛섏쟻�씤 UPDATE�엫    
UPDATE bbs 
SET wname='�솗�늿�씠', title='鍮꾩삤�뒗�궇', content='媛쒓뎄由� �뿰紐�' 
WHERE bbsno = 1; 
 
 PDSNO WNAME TITLE CONTENT PASSWD VIEWCNT WDATE                 GRPNO INDENT ANSNUM  
 ----- ----- ----- ------- ------ ------- --------------------- ----- ------ ------  
     1 �븘濡쒕��   �젣紐�2   �궡�슜2     123          0 2013-10-21 21:07:30.0     0      0      0 
 
     
-- �뙣�뒪�썙�뱶 寃��궗 
SELECT COUNT(bbsno) as cnt 
FROM bbs 
WHERE bbsno=1 AND passwd='123'; 
 
 CNT 
 --- 
   1 
      
      
 
7. 湲� �궘�젣(D:Delete)
-- 紐⑤뱺 �젅肄붾뱶 �궘�젣
DELETE FROM bbs; 
 
-- 1踰� �젅肄붾뱶留� �궘�젣
DELETE FROM bbs WHERE bbsno=1; 
 
 
 
8. �떟蹂�
 
1) 紐⑤뱺 �젅肄붾뱶 �궘�젣 
DELETE FROM bbs; 
 
 BBSNO  TITLE    GRPNO INDENT ANSNUM 
 -----   -----    ----- ------ ------ 
     1  遺�紐④�1     1      0      0 
 
      
 BBSNO  TITLE    GRPNO INDENT ANSNUM 
 -----  -----    ----- ------ ------ 
     2  遺�紐④�2      2      0      0 
     1  遺�紐④�1      1      0      0 
 
      
 BBSNO  TITLE      	      GRPNO INDENT ANSNUM 
 -----  -----             ----- ------ ------ 
   3  遺�紐④�3		     	    3     0      0 
   6  	遺�紐④�3�떟3	  	    3     1      1 
   5    遺�紐④�3�떟2		    3     1      2 
   7      遺�紐④�3�떟2�떟1	    3     2      3 
   4    遺�紐④�3�떟1    	    3     1      4 
   2  遺�紐④�2		     	    2     0      0 
   9    遺�紐④�2�떟1		    2     1      1 
  11    遺�紐④�2�떟2		    2     2      2 
  13      遺�紐④�2�떟2�떟1	    2     3      3 
   1  遺�紐④�1                 1     0      0 
   8    遺�紐④�1�떟1            1     1      1 
  14      遺�紐④�1�떟1�떟1       1      2      2 
  10    遺�紐④�1�떟2            1     1      3 
  12      遺�紐④�1�떟2�떟1        1     2      4 
       
 
4) 遺�紐④�(�씪諛섏쟻�씤 湲�) �벑濡� 
 
INSERT INTO bbs(bbsno, wname, title, content, passwd, wdate, 
grpno)  
VALUES((SELECT NVL(MAX(bbsno), 0) + 1 as bbsno FROM bbs), 
'�솗�늿�씠', '遺�紐④�3', '�궡�슜', '123', sysdate,
(SELECT NVL(MAX(grpno), 0) + 1 as grpno FROM bbs)
);                 
 
         
SELECT bbsno, title, grpno, indent, ansnum 
FROM bbs  
ORDER BY grpno DESC, ansnum ASC; 
  
     
5) �떟蹂�泥섎━
--read(遺�紐⑥쓽 title,grpno,indent,ansnum) : 泥ル쾲吏�
select bbsno, title, grpno, indent, ansnum
from bbs
where bbsno=2 --遺�紐⑥쓽 湲�
 
 BBSNO TITLE   GRPNO INDENT ANSNUM
 ----- ----- - ---- ------ ------
     2 遺�紐④�1       2      0      0
     
--�떟蹂��벑濡�(遺�紐⑥쓽grpno,遺�紐�+1 -> indent,ansnum): �꽭踰덉㎏
INSERT INTO bbs(bbsno, wname, title, content, passwd, wdate, 
grpno,indent,ansnum)  
VALUES((SELECT NVL(MAX(bbsno), 0) + 1 as bbsno FROM bbs), 
'�븘濡쒕��', '遺�紐④�1 �떟蹂�湲�2', '�궡�슜', '123', sysdate,2,1,1);
 
     
--遺�紐④��쓽 2李⑥씠�긽�쓽 �떟蹂��씤 寃쎌슦 ansnum(�떟蹂��쓽 �닚�꽌) �옱�젙�젹 :�몢踰덉㎏
UPDATE bbs 
SET ansnum = ansnum + 1 
WHERE grpno=2 AND ansnum > 0; 
 
 
--------------------------------------------------------------------      
 
  
9. 寃��깋 湲� 紐⑸줉(S:Search List), title 而щ읆�뿉 '�젣紐�'�씠��  
   �떒�뼱媛� �뱾�뼱媛� �엳�뒗 �젅肄붾뱶 寃��깋 
    
  
湲고�)  
- WHERE title LIKE '%�룆�룄%': �룆�룄�씪�뒗 臾몄옄�뿴�씠 諛쒓껄�릺硫� �쟾遺� �빐�떦(*)  
- WHERE title LIKE '�룆�룄%' : �룆�룄濡� �떆�옉�븯�뒗 臾몄옄�뿴 寃��깋 
- WHERE title LIKE '%�룆�룄' : �룆�룄濡� �걹�굹�뒗 臾몄옄�뿴 寃��깋 
- WHERE title LIKE '�룆�룄'  : �룆�룄�� �씪移섑븯�뒗 臾몄옄�뿴 寃��깋 
- WHERE title = '�룆�룄'     : �룆�룄�� �씪移섑븯�뒗 臾몄옄�뿴 寃��깋, LIKE '�룆�룄' �룞�씪 
- WHERE title = '__�룆�룄'   : �븳援��룆�룄, �룞�빐�룆�룄�� 媛숈� �뙣�꽩�쓽 臾몄옄�뿴 寃��깋 
 
 
1) �꽦紐� 寃��깋 湲� 紐⑸줉(S:Search List) 
SELECT bbsno, wname, title, content, passwd, viewcnt, wdate, grpno, indent, ansnum 
FROM bbs  
WHERE wname LIKE '%�솗�늿�씠%' 
ORDER BY bbsno DESC;  
 
 
2) �젣紐� 寃��깋 湲� 紐⑸줉(S:Search List) 
SELECT bbsno, wname, title, content, passwd, viewcnt, wdate, grpno, indent, ansnum 
FROM bbs  
WHERE title LIKE '%�룆�룄%' 
ORDER BY bbsno DESC;  
 
 
 
3) �궡�슜 寃��깋 湲� 紐⑸줉(S:Search List) 
SELECT bbsno, wname, title, content, passwd, viewcnt, wdate, grpno, indent, ansnum 
FROM bbs  
WHERE content LIKE '%�룆�룄%' 
ORDER BY bbsno DESC;  
 
 
 
4) �뙆�씠�봽 湲고샇瑜� �넻�븳 SQL 寃고빀 
SELECT ('A' || 'B' || 'C' || 'D') as "grade" 
FROM dual; 
 
 grade 
 ----- 
 ABCD 
  
 
SELECT ('�벑濡앹옄: ' || wname) as "wname"  
FROM bbs; 
 
 wname 
 --------- 
 �벑濡앹옄: �솉湲몃룞 
 �벑濡앹옄: �솉湲몃룞 
 �벑濡앹옄: �솉湲몃룞 
 �벑濡앹옄: �솉湲몃룞 
 
-- paging
SELECT bbsno, wname, title, viewcnt, wdate, grpno, indent, ansnum, viewcnt
FROM bbs  
ORDER BY grpno DESC, ansnum ASC; 


2) rownum �깮�꽦 
SELECT bbsno, wname, title, viewcnt, wdate, grpno, indent, ansnum, rownum 
FROM ( 
  SELECT bbsno, wname, title, viewcnt, wdate, grpno, indent, ansnum
  FROM bbs  
  ORDER BY grpno DESC, ansnum ASC 
);


3) rownum 媛믪뿉 �뵲瑜� �럹�씠吏� 遺꾨━ 
SELECT bbsno, wname, title, viewcnt, wdate, grpno, indent, ansnum, r
	from(
	SELECT bbsno, wname, title, viewcnt, wdate, grpno, indent, ansnum, rownum as r
		FROM ( 
		  SELECT bbsno, wname, title, viewcnt, wdate, grpno, indent, ansnum
		  FROM bbs  
		  ORDER BY grpno DESC, ansnum ASC)
)
where r >= 3 and r <=6
