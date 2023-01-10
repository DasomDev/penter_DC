-- USER ======================================================
-----------유저테이블---------------------------------by.동인
CREATE TABLE users(
user_no NUMBER PRIMARY KEY NOT null,
user_type NUMBER,
id varchar2(50),
nickname varchar2(50),
email varchar2(50),
password varchar2(50),
name varchar2(50),
joindate DATE,
gender varchar2(50),
zipcode varchar2(50),
addr varchar2(500),
addr_detail varchar2(500),
user_level varchar2(50),
user_auth NUMBER,
file_no NUMBER
);
--file_no REFERENCES file_tb(file_no)--

CREATE SEQUENCE seq_user_no INCREMENT BY 1 START WITH 1;
SELECT seq_user_no.nextval FROM dual;
SELECT seq_user_no.currval FROM dual;

-------------------드랍-------------
DROP TABLE users;
DROP SEQUENCE seq_user_no;

------------간단로그인 전용-----------

INSERT INTO USERS(user_no, user_type, id, nickname, email, password, name, joindate, gender, zipcode, addr, addr_detail, user_level, user_auth, file_no)
values(seq_user_no.nextval, 1, '12345', '펫트너', 'petner@petner.com', '1234','펫트너', sysdate, '미정', '12345', '가디역', '호서대벤처타워', 'VIP', 10, 0);


-----조회-----
SELECT * FROM users;


------------비밀번호수정-------

 update users 
	    set password = '1234'
	    where id = '1234'
	    and   name = '펫트너'
	    and   email = 'petner@petner.com';
	   
	   
-----------자동로그인 칼럼 추가(추가해서 사용해주세요)-----
	
ALTER table users ADD sessionkey varchar2(50) DEFAULT 'none' NOT NULL ;
alter table users add  sessionlimit timestamp;

alter table users add photo varchar2(200);

--------비밀번호 사이즈 수정----------

ALTER TABLE users MODIFY password varchar2(2000);

ALTER TABLE users MODIFY id unique;



--회원 삭제---

DELETE FROM users WHERE user_no = 81;


-- PET_INFO, SITTER_INFO, CARE_SERVICE, DB_NO, FILE_TB ======================================================
----시퀀스----
--pet_no 시퀀스
CREATE SEQUENCE pet_no_seq 
INCREMENT BY 1
START WITH 1 
NOCACHE;

--file_no 시퀀스
CREATE SEQUENCE file_no_seq 
INCREMENT BY 1
START WITH 1 
NOCACHE;

----create문----
--반려동물 정보 등록
CREATE TABLE pet_info(
	 pet_no 		NUMBER
	,user_no 		NUMBER
	,file_no		NUMBER
	,pet_kind 		varchar2(50)
	,pet_specie 	varchar2(50)
	,pet_name 		varchar2(50)
	,pet_age 		number
	,pet_weight 	number
	,pet_gender		varchar2(50)
	,pet_neutral 	varchar2(50)
	,PET_INFO 		varchar2(500)
	,pet_info 		varchar2(500)
);

--시터 정보 등록
CREATE TABLE sitter_info(
	 user_no		NUMBER
	,file_no		NUMBER
	,pet_kind 		varchar2(50)
	,pet_specie 	varchar2(50)
	,work_day 		varchar2(50)
	,service 		varchar2(50)
	,zipcode		varchar2(50)
	,addr			varchar2(500)
	,addr_detail	varchar2(500)
	,sitter_info 	varchar2(500)
);
--게시판 번호 테이블
CREATE TABLE bd_no(
	 board_name varchar2(50)
	,board_no	number
);

--펫시팅 서비스 신청
CREATE TABLE care_service(
	 service_no		NUMBER
	,user_no		NUMBER
	,pet_no			NUMBER
	,zipcode		varchar2(50)
	,addr			varchar2(500)
	,addr_detail	varchar2(500)
	,service 		varchar2(50)
	,st_date		DATE
	,end_date		DATE
	,request_money 	NUMBER
	,request_title 	varchar2(500)
	,request_detail	varchar2(500)
	,status 		varchar2(50)
	,reg_date		DATE
	,file_no		NUMBER
);

--파일테이블
CREATE TABLE file_tb(
	 file_no			NUMBER
	,user_no 			NUMBER
	,board_no 			NUMBER
	,origin_filename 	varchar2(500)
	,server_filename 	varchar2(500)
);

-------------------insert-------------------
--bd_no
INSERT INTO bd_no values('공지사항',1);
INSERT INTO bd_no values('이벤트',2);
INSERT INTO bd_no values('유저프로필',3);
INSERT INTO bd_no values('시터프로필',4);
INSERT INTO bd_no values('펫사진',5);




--12/20수정사항
--sitter_info 테이블의 zipcode컬럼 NUMBER>varchar2(50)로 수정
--care_service 테이블의 zipcode컬럼 NUMBER>varchar2(50)로 수정


--  ALTER ADD ======================================================

ALTER TABLE PETNER.SITTER_INFO MODIFY SITTER_INFO VARCHAR2(1000) NULL;

--  CHATROOM ======================================================

-----------------채팅 테이블 생성-----------------------
CREATE TABLE ChatRoom(
	room_id varchar2(5),
	user_id varchar2(50),
	user_nickname varchar2(50),
	user_pic  number,
	another_id varchar2(50),
	another_nickname varchar2(50),
	another_pic  number,
	unReadCount NUMBER
	);


	CREATE TABLE ChatMessage(
	room_id varchar(5),
	message_id varchar2(50) ,
	message varchar2(1000),
	user_nickname varchar2(50),
	user_id varchar2(50),
	unReadCount NUMBER,
	sessionCount NUMBER
	);


--------시퀀스 생성----------------------------------------

CREATE SEQUENCE seq_chatroom_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_chatmessage_id START WITH 1 INCREMENT BY 1;


---------조회--------------------------------------------

SELECT * FROM chatRoom;
SELECT * FROM chatMessage;

--  FOLLOW ======================================================

--follow 테이블--

CREATE TABLE FOLLOW(
followNo NUMBER PRIMARY KEY,
active_User NUMBER NOT NULL,
passive_User NUMBER NOT NULL,
reg_date date,
CONSTRAINT fk_active_User FOREIGN KEY(active_User) REFERENCES users(user_No), 
CONSTRAINT fk_passive_User FOREIGN KEY(passive_User) REFERENCES users(user_No)
);

CREATE SEQUENCE followNo_seq INCREMENT BY 1 START WITH 1;

SELECT * FROM follow;

--reg_date 컬럼 추가--
ALTER TABLE FOLLOW  ADD reg_date date;

--  REVIEW ======================================================

CREATE TABLE REVIEW(
review_no NUMBER PRIMARY KEY,
review_active_user NUMBER NOT NULL,
review_passive_user NUMBER NOT NULL,
title varchar2(100) NOT NULL,
content varchar(2000),
rating NUMBER NOT null,
review_date date,
CONSTRAINT fk_review_active_user FOREIGN KEY(review_active_User) REFERENCES users(user_No), 
CONSTRAINT fk_review_passive_user FOREIGN KEY(review_passive_User) REFERENCES users(user_No)
);

CREATE SEQUENCE seq_review_no INCREMENT BY 1 START WITH 1;




----테스트 데이터----

SELECT * FROM review;
insert into review(review_no, review_active_user, review_passive_user, title, content, rating, review_date) 
values(seq_review_no.nextval, 2, 23, '리뷰제목', '내용내용내용', 3, sysdate);

--  TABLE ======================================================

CREATE TABLE notice(
    id          NUMBER CONSTRAINT notice_id_pk PRIMARY KEY,
    title       VARCHAR2(300) NOT NULL,
    content     VARCHAR2(4000) NOT NULL,
    writer      VARCHAR2(20) NOT NULL,
    writedate   DATE DEFAULT SYSDATE,
    readcnt     NUMBER DEFAULT 0,
    file_no		VARCHAR2(300),
    filename    VARCHAR2(300),
    filepath    VARCHAR2(300),
    root        NUMBER,
    step        NUMBER default 0,
    indent      NUMBER default 0 
);

ALTER TABLE notice
ADD(root NUMBER, step NUMBER DEFAULT 0, indent NUMBER DEFAULT 0);

UPDATE notice SET root = id;

ALTER TRIGGER trg_notice DISABLE;

DROP table notice;

DROP SEQUENCE notice_seq;

CREATE SEQUENCE seq_notice
START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_notice
    BEFORE INSERT ON notice
    FOR EACH ROW
BEGIN
    SELECT seq_notice.NEXTVAL INTO:NEW.id FROM dual;
END;
-- qna 완료 
--qna 테이블 생성
CREATE TABLE qna(
    id          NUMBER CONSTRAINT qna_id_pk PRIMARY KEY,
    title       VARCHAR2(300) NOT NULL,
    content     VARCHAR2(4000) NOT NULL,
    writer      VARCHAR2(20) NOT NULL,
    writedate   DATE DEFAULT SYSDATE,
    readcnt     NUMBER DEFAULT 0,
    file_no    VARCHAR2(300),
    filename    VARCHAR2(300),
    filepath    VARCHAR2(300),
    root        NUMBER,
    step        NUMBER default 0,
    indent      NUMBER default 0 
);
CREATE SEQUENCE seq_qna
START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_qna
    BEFORE INSERT ON qna
    FOR EACH ROW
BEGIN
    SELECT seq_qna.NEXTVAL INTO:NEW.id FROM dual;
END;


INSERT INTO qna (id, title, content, writer)
VALUES (1, '첫 글 테스트', 'ㅁㄴㅇㄻㄴㅇㄹ', '관리자');


INSERT INTO qna(title, content, writer, writedate, filepath, filename)
SELECT title, content, writer, writedate, filepath, filename FROM qna;

UPDATE qna SET root = id;

ALTER TRIGGER trg_qna DISABLE;

COMMIT;

SELECT * FROM qna;

-- board 완료 
create table tbl_attach ( 
  uuid varchar2(100) not null,
  uploadPath varchar2(200) not null,
  fileName varchar2(100) not null, 
  filetype char(1) default 'I',
  bno number(10,0)
);

alter table tbl_attach add constraint pk_attach primary key (uuid); 

alter table tbl_attach add constraint fk_board_attach foreign key (bno) references tbl_board(bno);

-------

--방명록 관리
CREATE TABLE board(
	id			NUMBER			CONSTRAINT board_id_pk PRIMARY KEY,
	title		VARCHAR2(300)	NOT NULL,
	content		VARCHAR2(4000)	NOT NULL,
	writer		VARCHAR2(100)	NOT NULL,
	writedate	DATE DEFAULT SYSDATE,
	readcnt		NUMBER DEFAULT 0,
	filename	VARCHAR2(300),
	filepath	VARCHAR2(300)
);

CREATE SEQUENCE seq_board START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_board
	BEFORE INSERT ON board
	FOR EACH ROW
BEGIN
	SELECT seq_board.NEXTVAL INTO :new.id FROM dual;
END;

COMMIT;

INSERT INTO board (title, content, writer, filename, filepath)
SELECT title, content, writer, filename, filepath
FROM board;

CREATE TABLE board_comment (
	id NUMBER constraint board_comment_id_pk PRIMARY KEY,
	pid NUMBER NOT NULL, /* 원글의 아이디 */
	writer VARCHAR2(20) NOT NULL, /* 댓글 작성자 아이디 */
	content VARCHAR2(4000) NOT NULL,
    writedate DATE DEFAULT SYSDATE,
    CONSTRAINT board_comment_pid_fk FOREIGN KEY(pid) REFERENCES board(id) ON DELETE CASCADE
);

SELECT * FROM board_comment;
SELECT * FROM USERS u ;

CREATE SEQUENCE seq_board_comment
START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_board_comment
    BEFORE INSERT ON board_comment
    FOR EACH ROW
BEGIN
    SELECT seq_board_comment.NEXTVAL INTO :NEW.id FROM dual;
END;

COMMIT;
-- board 완료.end
