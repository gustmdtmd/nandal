-- user 테이블 세팅 --
DROP TABLE nandal_user;

drop SEQUENCE usercode_num_seq;

CREATE TABLE NANDAL_USER (
    usercode  NUMBER NOT NULL,
    id        VARCHAR2(100) NOT NULL,
    password  VARCHAR2(100) NOT NULL,
    nickname  VARCHAR2(100) NOT NULL,
    img       VARCHAR2(20),
    birth     NUMBER(4) NOT NULL,
    gender    VARCHAR2(4) NOT NULL,
    loc       VARCHAR2(10) NOT NULL,
    phone     VARCHAR2(20) NOT NULL,
    email     VARCHAR2(30) NOT NULL,
    usergrade NUMBER(1) NOT NULL,
    joindate date NOT NULL
);

create sequence usercode_num_seq 
start with 1 
increment by 1
nocache
nocycle;

INSERT INTO NANDAL_USER(usercode, id, password, nickname, img, birth, gender, loc, phone, email, usergrade, joindate)
VALUES(usercode_num_seq.nextval, 'admin', '0000','admin','admin.png',1988,'남', '서울', '010-7362-1618','limhojin1206@naver.com', 2, sysdate);

INSERT INTO NANDAL_USER(usercode, id, password, nickname, img, birth, gender, loc, phone, email, usergrade, joindate)
VALUES(usercode_num_seq.nextval, 'userA', '0000','uayo', 'userA.png',1980,'여', '인천', '010-1111-2222','uayo@naver.com', 1, sysdate);

INSERT INTO NANDAL_USER(usercode, id, password, nickname, img, birth, gender, loc, phone, email, usergrade, joindate)
VALUES(usercode_num_seq.nextval, 'userB', '0000','ubyo', 'userB.png',1990,'여', '대전', '010-4444-3333','ubyo@daum.net', 1, sysdate);

INSERT INTO NANDAL_USER(usercode, id, password, nickname, img, birth, gender, loc, phone, email, usergrade, joindate)
VALUES(usercode_num_seq.nextval, 'userC', '0000','ucyo', 'userC.png',2000,'남', '대구', '010-5555-6666','ucyo@gmail.com', 1, sysdate);

commit;

select * from nandal_user;

-- 공지 게시판 테이블 세팅 --
drop table nandal_notice_board;

drop sequence nandal_notice_board_num_seq;

create table nandal_notice_board(
        num number,                        
        writer number,                       
        subject varchar2(1000),            
        reg_date date,                       
        readcount number default 0,         
        ref number,                      
        re_step number,                        
        re_level number,                       
        content varchar2(4000),               
        ip varchar2(20),                       
        upload varchar2(300)                
);

create sequence nandal_notice_board_num_seq
start with 1 
increment by 1
nocache
nocycle;

insert into nandal_notice_board
values(nandal_notice_board_num_seq.nextval, 1,'제목1',sysdate,0,nandal_notice_board_num_seq.nextval, 0,0,'내용 테스트.......','127.0.0.1','sample.png');

insert into nandal_notice_board
values(nandal_notice_board_num_seq.nextval, 1,'제목2',sysdate,0,nandal_notice_board_num_seq.nextval, 0,0,'내용 테스트.......','127.0.0.1','sample.png');

insert into nandal_notice_board
values(nandal_notice_board_num_seq.nextval, 1,'제목3',sysdate,0,nandal_notice_board_num_seq.nextval, 0,0,'내용 테스트.......','127.0.0.1','sample.png');

insert into nandal_notice_board
values(nandal_notice_board_num_seq.nextval, 1,'제목4',sysdate,0,nandal_notice_board_num_seq.nextval, 0,0,'내용 테스트.......','127.0.0.1','sample.png');

insert into nandal_notice_board
values(nandal_notice_board_num_seq.nextval, 1,'제목5',sysdate,0,nandal_notice_board_num_seq.nextval, 0,0,'내용 테스트.......','127.0.0.1','sample.png');

commit;

select * from nandal_notice_board;

-- 자유 게시판 테이블 세팅 -- 
drop table nandal_free_board;

drop sequence nandal_free_board_num_seq;

create table nandal_free_board(
        num number,                        
        writer number,                       
        subject varchar2(1000),            
        reg_date date,                       
        readcount number default 0,         
        ref number,                      
        re_step number,                        
        re_level number,                       
        content varchar2(4000),               
        ip varchar2(20),                       
        upload varchar2(300)                
);

create sequence nandal_free_board_num_seq
start with 1 
increment by 1
nocache
nocycle;

insert into nandal_free_board
values(nandal_free_board_num_seq.nextval, 2,'제목1',sysdate,0,nandal_free_board_num_seq.nextval, 0,0,'내용 테스트.......','127.0.0.1','sample.png');

insert into nandal_free_board
values(nandal_free_board_num_seq.nextval, 3,'제목2',sysdate,0,nandal_free_board_num_seq.nextval, 0,0,'내용 테스트.......','127.0.0.1','sample.png');

insert into nandal_free_board
values(nandal_free_board_num_seq.nextval, 2,'제목3',sysdate,0,nandal_free_board_num_seq.nextval, 0,0,'내용 테스트.......','127.0.0.1','sample.png');

insert into nandal_free_board
values(nandal_free_board_num_seq.nextval, 4,'제목4',sysdate,0,nandal_free_board_num_seq.nextval, 0,0,'내용 테스트.......','127.0.0.1','sample.png');

insert into nandal_free_board
values(nandal_free_board_num_seq.nextval, 2,'제목5',sysdate,0,nandal_free_board_num_seq.nextval, 0,0,'내용 테스트.......','127.0.0.1','sample.png');

commit;

select * from nandal_free_board;

-- 관광 정보 테이블 세팅 -- 
drop table NANDAL_content_info;

CREATE TABLE NANDAL_content_info (
    contentid NUMBER(20) NOT NULL,
    contenttypeid NUMBER(20) NOT NULL,
    readcount NUMBER(20) NOT NULL,
    title varchar2(200),
    firstimage varchar2(200)
);

insert into NANDAL_content_info(contentid, contenttypeid, readcount, title, firstimage)
values(2924134,38,1,'가가밀라노 롯데백화점 에비뉴엘 월드타워점','http://tong.visitkorea.or.kr/cms/resource/00/2879100_image2_1.jpg');

insert into NANDAL_content_info(contentid, contenttypeid, readcount, title, firstimage)
values(2871024,39,0,'가나돈까스의집','http://tong.visitkorea.or.kr/cms/resource/08/2871008_image2_1.JPG');

insert into NANDAL_content_info(contentid, contenttypeid, readcount, title, firstimage)
values(129854,14,1,'가나아트센터','http://tong.visitkorea.or.kr/cms/resource/19/1570619_image2_1.jpg');

commit;

select * from NANDAL_content_info;

-- 리뷰 게시판 세팅 --
drop table nandal_review_board;

drop sequence nandal_review_board_num_seq;

create table nandal_review_board(
        contentid number,
        num number,                        
        writer number,                 
        subject varchar2(1000),            
        reg_date date,                       
        readcount number default 0,         
        ref number,                      
        re_step number,                        
        re_level number,                       
        content varchar2(4000),               
        ip varchar2(20),                       
        upload varchar2(300)                
);

create sequence nandal_review_board_num_seq
start with 1 
increment by 1
nocache
nocycle;

insert into nandal_review_board
values(2924134, nandal_review_board_num_seq.nextval, 2,'제목1',sysdate,0,nandal_review_board_num_seq.nextval, 0,0,'내용 테스트.......','127.0.0.1','sample.png');

insert into nandal_review_board
values(2924134, nandal_review_board_num_seq.nextval, 3,'제목2',sysdate,0,nandal_review_board_num_seq.nextval, 0,0,'내용 테스트.......','127.0.0.1','sample.png');

insert into nandal_review_board
values(129854 ,nandal_review_board_num_seq.nextval, 2,'제목3',sysdate,0,nandal_review_board_num_seq.nextval, 0,0,'내용 테스트.......','127.0.0.1','sample.png');

insert into nandal_review_board
values(2871024, nandal_review_board_num_seq.nextval, 4,'제목4',sysdate,0,nandal_review_board_num_seq.nextval, 0,0,'내용 테스트.......','127.0.0.1','sample.png');

insert into nandal_review_board
values(129854, nandal_review_board_num_seq.nextval, 2,'제목5',sysdate,0,nandal_review_board_num_seq.nextval, 0,0,'내용 테스트.......','127.0.0.1','sample.png');

commit;

select * from nandal_review_board;

-- 질문 게시판 세팅 --
drop table nandal_qna_board;

drop sequence nandal_qna_board_num_seq;

create table nandal_qna_board(
        contentid number,
        num number,                        
        writer number,                      
        subject varchar2(1000),            
        reg_date date,                       
        readcount number default 0,         
        ref number,                      
        re_step number,                        
        re_level number,                       
        content varchar2(4000),               
        ip varchar2(20),                       
        upload varchar2(300)                
);

create sequence nandal_qna_board_num_seq
start with 1 
increment by 1
nocache
nocycle;

insert into nandal_qna_board
values(2924134, nandal_qna_board_num_seq.nextval, 2,'제목1',sysdate,0,nandal_qna_board_num_seq.nextval, 0,0,'내용 테스트.......','127.0.0.1','sample.png');

insert into nandal_qna_board
values(2924134, nandal_qna_board_num_seq.nextval, 3,'제목2',sysdate,0,nandal_qna_board_num_seq.nextval, 0,0,'내용 테스트.......','127.0.0.1','sample.png');

insert into nandal_qna_board
values(129854, nandal_qna_board_num_seq.nextval, 2,'제목3',sysdate,0,nandal_qna_board_num_seq.nextval, 0,0,'내용 테스트.......','127.0.0.1','sample.png');

insert into nandal_qna_board
values(2871024, nandal_qna_board_num_seq.nextval, 4,'제목4',sysdate,0,nandal_qna_board_num_seq.nextval, 0,0,'내용 테스트.......','127.0.0.1','sample.png');

insert into nandal_qna_board
values(129854, nandal_qna_board_num_seq.nextval, 2,'제목5',sysdate,0,nandal_qna_board_num_seq.nextval, 0,0,'내용 테스트.......','127.0.0.1','sample.png');

commit;

select * from nandal_qna_board;

-- 관광 타입 선호 테이블 세팅 --
drop table NANDAL_user_choice;

CREATE TABLE NANDAL_user_choice (
    usercode  NUMBER(10) NOT NULL,
    choicedate date NOT NULL,
A01010100 NUMBER(20)        DEFAULT 0,
A01010200 NUMBER(20)        DEFAULT 0,
A01010300 NUMBER(20)        DEFAULT 0,
A01010400 NUMBER(20)        DEFAULT 0,
A01010500 NUMBER(20)        DEFAULT 0,
A01010600 NUMBER(20)        DEFAULT 0,
A01010700 NUMBER(20)        DEFAULT 0,
A01010800 NUMBER(20)        DEFAULT 0,
A01010900 NUMBER(20)        DEFAULT 0,
A01011000 NUMBER(20)        DEFAULT 0,
A01011100 NUMBER(20)        DEFAULT 0,
A01011200 NUMBER(20)        DEFAULT 0,
A01011300 NUMBER(20)        DEFAULT 0,
A01011400 NUMBER(20)        DEFAULT 0,
A01011500 NUMBER(20)        DEFAULT 0,
A01011600 NUMBER(20)        DEFAULT 0,
A01011700 NUMBER(20)        DEFAULT 0,
A01011800 NUMBER(20)        DEFAULT 0,
A01011900 NUMBER(20)        DEFAULT 0,
A01020100 NUMBER(20)        DEFAULT 0,
A01020200 NUMBER(20)        DEFAULT 0,
A02010100 NUMBER(20)        DEFAULT 0,
A02010200 NUMBER(20)        DEFAULT 0,
A02010300 NUMBER(20)        DEFAULT 0,
A02010400 NUMBER(20)        DEFAULT 0,
A02010500 NUMBER(20)        DEFAULT 0,
A02010600 NUMBER(20)        DEFAULT 0,
A02010700 NUMBER(20)        DEFAULT 0,
A02010800 NUMBER(20)        DEFAULT 0,
A02010900 NUMBER(20)        DEFAULT 0,
A02011000 NUMBER(20)        DEFAULT 0,
A02020100 NUMBER(20)        DEFAULT 0,
A02020400 NUMBER(20)        DEFAULT 0,
A02020500 NUMBER(20)        DEFAULT 0,
A02020600 NUMBER(20)        DEFAULT 0,
A02020700 NUMBER(20)        DEFAULT 0,
A02020800 NUMBER(20)        DEFAULT 0,
A02030100 NUMBER(20)        DEFAULT 0,
A02030200 NUMBER(20)        DEFAULT 0,
A02030300 NUMBER(20)        DEFAULT 0,
A02030400 NUMBER(20)        DEFAULT 0,
A02030500 NUMBER(20)        DEFAULT 0,
A02030600 NUMBER(20)        DEFAULT 0,
A02040100 NUMBER(20)        DEFAULT 0,
A02040200 NUMBER(20)        DEFAULT 0,
A02040300 NUMBER(20)        DEFAULT 0,
A02040400 NUMBER(20)        DEFAULT 0,
A02040500 NUMBER(20)        DEFAULT 0,
A02040600 NUMBER(20)        DEFAULT 0,
A02040700 NUMBER(20)        DEFAULT 0,
A02040800 NUMBER(20)        DEFAULT 0,
A02040900 NUMBER(20)        DEFAULT 0,
A02041000 NUMBER(20)        DEFAULT 0,
A02050100 NUMBER(20)        DEFAULT 0,
A02050200 NUMBER(20)        DEFAULT 0,
A02050300 NUMBER(20)        DEFAULT 0,
A02050400 NUMBER(20)        DEFAULT 0,
A02050500 NUMBER(20)        DEFAULT 0,
A02050600 NUMBER(20)        DEFAULT 0,
A02060100 NUMBER(20)        DEFAULT 0,
A02060200 NUMBER(20)        DEFAULT 0,
A02060300 NUMBER(20)        DEFAULT 0,
A02060400 NUMBER(20)        DEFAULT 0,
A02060500 NUMBER(20)        DEFAULT 0,
A02060600 NUMBER(20)        DEFAULT 0,
A02060700 NUMBER(20)        DEFAULT 0,
A02060800 NUMBER(20)        DEFAULT 0,
A02060900 NUMBER(20)        DEFAULT 0,
A02061000 NUMBER(20)        DEFAULT 0,
A02061100 NUMBER(20)        DEFAULT 0,
A02061200 NUMBER(20)        DEFAULT 0,
A02061300 NUMBER(20)        DEFAULT 0,
A02061400 NUMBER(20)        DEFAULT 0,
A02070100 NUMBER(20)        DEFAULT 0,
A02070200 NUMBER(20)        DEFAULT 0,
A02080100 NUMBER(20)        DEFAULT 0,
A02080200 NUMBER(20)        DEFAULT 0,
A02080300 NUMBER(20)        DEFAULT 0,
A02080400 NUMBER(20)        DEFAULT 0,
A02080500 NUMBER(20)        DEFAULT 0,
A02080600 NUMBER(20)        DEFAULT 0,
A02080700 NUMBER(20)        DEFAULT 0,
A02080800 NUMBER(20)        DEFAULT 0,
A02080900 NUMBER(20)        DEFAULT 0,
A02081000 NUMBER(20)        DEFAULT 0,
A02081100 NUMBER(20)        DEFAULT 0,
A02081200 NUMBER(20)        DEFAULT 0,
A02081300 NUMBER(20)        DEFAULT 0,
C01120001 NUMBER(20)        DEFAULT 0,
C01130001 NUMBER(20)        DEFAULT 0,
C01140001 NUMBER(20)        DEFAULT 0,
C01150001 NUMBER(20)        DEFAULT 0,
C01160001 NUMBER(20)        DEFAULT 0,
C01170001 NUMBER(20)        DEFAULT 0,
A03010100 NUMBER(20)        DEFAULT 0,
A03010200 NUMBER(20)        DEFAULT 0,
A03010300 NUMBER(20)        DEFAULT 0,
A03020100 NUMBER(20)        DEFAULT 0,
A03020200 NUMBER(20)        DEFAULT 0,
A03020300 NUMBER(20)        DEFAULT 0,
A03020400 NUMBER(20)        DEFAULT 0,
A03020500 NUMBER(20)        DEFAULT 0,
A03020600 NUMBER(20)        DEFAULT 0,
A03020700 NUMBER(20)        DEFAULT 0,
A03020800 NUMBER(20)        DEFAULT 0,
A03020900 NUMBER(20)        DEFAULT 0,
A03021000 NUMBER(20)        DEFAULT 0,
A03021100 NUMBER(20)        DEFAULT 0,
A03021200 NUMBER(20)        DEFAULT 0,
A03021300 NUMBER(20)        DEFAULT 0,
A03021400 NUMBER(20)        DEFAULT 0,
A03021500 NUMBER(20)        DEFAULT 0,
A03021600 NUMBER(20)        DEFAULT 0,
A03021700 NUMBER(20)        DEFAULT 0,
A03021800 NUMBER(20)        DEFAULT 0,
A03021900 NUMBER(20)        DEFAULT 0,
A03022000 NUMBER(20)        DEFAULT 0,
A03022100 NUMBER(20)        DEFAULT 0,
A03022200 NUMBER(20)        DEFAULT 0,
A03022300 NUMBER(20)        DEFAULT 0,
A03022400 NUMBER(20)        DEFAULT 0,
A03022500 NUMBER(20)        DEFAULT 0,
A03022600 NUMBER(20)        DEFAULT 0,
A03022700 NUMBER(20)        DEFAULT 0,
A03030100 NUMBER(20)        DEFAULT 0,
A03030200 NUMBER(20)        DEFAULT 0,
A03030300 NUMBER(20)        DEFAULT 0,
A03030400 NUMBER(20)        DEFAULT 0,
A03030500 NUMBER(20)        DEFAULT 0,
A03030600 NUMBER(20)        DEFAULT 0,
A03030700 NUMBER(20)        DEFAULT 0,
A03030800 NUMBER(20)        DEFAULT 0,
A03040100 NUMBER(20)        DEFAULT 0,
A03040200 NUMBER(20)        DEFAULT 0,
A03040300 NUMBER(20)        DEFAULT 0,
A03040400 NUMBER(20)        DEFAULT 0,
A03050100 NUMBER(20)        DEFAULT 0,
B02010100 NUMBER(20)        DEFAULT 0,
B02010200 NUMBER(20)        DEFAULT 0,
B02010300 NUMBER(20)        DEFAULT 0,
B02010400 NUMBER(20)        DEFAULT 0,
B02010500 NUMBER(20)        DEFAULT 0,
B02010600 NUMBER(20)        DEFAULT 0,
B02010700 NUMBER(20)        DEFAULT 0,
B02010800 NUMBER(20)        DEFAULT 0,
B02010900 NUMBER(20)        DEFAULT 0,
B02011000 NUMBER(20)        DEFAULT 0,
B02011100 NUMBER(20)        DEFAULT 0,
B02011200 NUMBER(20)        DEFAULT 0,
B02011300 NUMBER(20)        DEFAULT 0,
B02011400 NUMBER(20)        DEFAULT 0,
B02011500 NUMBER(20)        DEFAULT 0,
B02011600 NUMBER(20)        DEFAULT 0,
A04010100 NUMBER(20)        DEFAULT 0,
A04010200 NUMBER(20)        DEFAULT 0,
A04010300 NUMBER(20)        DEFAULT 0,
A04010400 NUMBER(20)        DEFAULT 0,
A04010500 NUMBER(20)        DEFAULT 0,
A04010600 NUMBER(20)        DEFAULT 0,
A04010700 NUMBER(20)        DEFAULT 0,
A04010800 NUMBER(20)        DEFAULT 0,
A04010900 NUMBER(20)        DEFAULT 0,
A04011000 NUMBER(20)        DEFAULT 0,
A05020100 NUMBER(20)        DEFAULT 0,
A05020200 NUMBER(20)        DEFAULT 0,
A05020300 NUMBER(20)        DEFAULT 0,
A05020400 NUMBER(20)        DEFAULT 0,
A05020500 NUMBER(20)        DEFAULT 0,
A05020600 NUMBER(20)        DEFAULT 0,
A05020700 NUMBER(20)        DEFAULT 0,
A05020800 NUMBER(20)        DEFAULT 0,
A05020900 NUMBER(20)         DEFAULT 0,
A05021000 NUMBER(20)         DEFAULT 0

);


-- 지역 선호 테이블 세팅 --
drop table NANDAL_loc_choice;

CREATE TABLE NANDAL_loc_choice (
    usercode  NUMBER(10) NOT NULL,
    choicedate date NOT NULL,
    서울 NUMBER(20) DEFAULT 0,
    인천 NUMBER(20) DEFAULT 0,
    대전 NUMBER(20) DEFAULT 0,
    대구 NUMBER(20) DEFAULT 0,
    광주 NUMBER(20) DEFAULT 0,
    부산 NUMBER(20) DEFAULT 0,
    울산 NUMBER(20) DEFAULT 0,
    세종 NUMBER(20) DEFAULT 0,
    경기 NUMBER(20) DEFAULT 0,
    강원 NUMBER(20) DEFAULT 0,
    충북 NUMBER(20) DEFAULT 0,
    충남 NUMBER(20) DEFAULT 0,
    경북 NUMBER(20) DEFAULT 0,
    경남 NUMBER(20) DEFAULT 0,
    전북 NUMBER(20) DEFAULT 0,
    전남 NUMBER(20) DEFAULT 0,
    제주 NUMBER(20) DEFAULT 0

);

select * from NANDAL_loc_choice;



create table nandal_notice_comment(            
        pnum number,                       
        num number,                        
        writer number,                       
        reg_date date,                    
        ref number,                      
        re_step number,                        
        re_level number,                       
        subject varchar2(4000),               
        ip varchar2(20)                              
);

create sequence nandal_notice_comment_num_seq
start with 1 
increment by 1
nocache
nocycle;

select * from nandal_notice_board;
select * from nandal_notice_comment;

INSERT INTO nandal_notice_comment(pnum, num, writer, reg_date, ref, re_step, re_level, subject, ip)
values(1, nandal_notice_comment_num_seq.nextval, 2,sysdate,nandal_notice_comment_num_seq.nextval, 0,0,'댓글 테스트.......','127.0.0.1');

INSERT INTO nandal_notice_comment(pnum, num, writer, reg_date, ref, re_step, re_level, subject, ip)
values(1, nandal_notice_comment_num_seq.nextval, 2,sysdate,nandal_notice_comment_num_seq.nextval, 0,0,'댓글 테스트2.......','127.0.0.1');

commit;
----------------------
create table nandal_free_comment(            
        pnum number,                       
        num number,                        
        writer number,                       
        reg_date date,                    
        ref number,                      
        re_step number,                        
        re_level number,                       
        subject varchar2(4000),               
        ip varchar2(20)                              
);

create sequence nandal_free_comment_num_seq
start with 1 
increment by 1
nocache
nocycle;

select * from nandal_free_board;
select * from nandal_free_comment;

INSERT INTO nandal_free_comment(pnum, num, writer, reg_date, ref, re_step, re_level, subject, ip)
values(1, nandal_free_comment_num_seq.nextval, 2,sysdate,nandal_free_comment_num_seq.nextval, 0,0,'댓글 테스트.......','127.0.0.1');

INSERT INTO nandal_free_comment(pnum, num, writer, reg_date, ref, re_step, re_level, subject, ip)
values(1, nandal_free_comment_num_seq.nextval, 2,sysdate,nandal_free_comment_num_seq.nextval, 0,0,'댓글 테스트2.......','127.0.0.1');

commit;

-----------------------
create table nandal_review_comment(            
        pnum number,                       
        num number,                        
        writer number,                       
        reg_date date,                    
        ref number,                      
        re_step number,                        
        re_level number,                       
        subject varchar2(4000),               
        ip varchar2(20)                              
);

create sequence nandal_review_comment_num_seq
start with 1 
increment by 1
nocache
nocycle;

select * from nandal_review_board;
select * from nandal_review_comment;

INSERT INTO nandal_review_comment(pnum, num, writer, reg_date, ref, re_step, re_level, subject, ip)
values(1, nandal_review_comment_num_seq.nextval, 2,sysdate,nandal_review_comment_num_seq.nextval, 0,0,'댓글 테스트.......','127.0.0.1');

INSERT INTO nandal_review_comment(pnum, num, writer, reg_date, ref, re_step, re_level, subject, ip)
values(1, nandal_review_comment_num_seq.nextval, 2,sysdate,nandal_review_comment_num_seq.nextval, 0,0,'댓글 테스트2.......','127.0.0.1');

commit;



-----------------------
create table nandal_qna_comment(            
        pnum number,                       
        num number,                        
        writer number,                       
        reg_date date,                    
        ref number,                      
        re_step number,                        
        re_level number,                       
        subject varchar2(4000),               
        ip varchar2(20)                              
);

create sequence nandal_qna_comment_num_seq
start with 1 
increment by 1
nocache
nocycle;

select * from nandal_qna_board;
select * from nandal_qna_comment;

INSERT INTO nandal_qna_comment(pnum, num, writer, reg_date, ref, re_step, re_level, subject, ip)
values(1, nandal_qna_comment_num_seq.nextval, 2,sysdate,nandal_qna_comment_num_seq.nextval, 0,0,'댓글 테스트.......','127.0.0.1');

INSERT INTO nandal_qna_comment(pnum, num, writer, reg_date, ref, re_step, re_level, subject, ip)
values(1, nandal_qna_comment_num_seq.nextval, 2,sysdate,nandal_qna_comment_num_seq.nextval, 0,0,'댓글 테스트2.......','127.0.0.1');

commit;

-------------------------------
-- 관광정보 저장
drop table NANDAL_content_info;

CREATE TABLE NANDAL_content_info (
    contentid NUMBER NOT NULL,
    contenttypeid NUMBER NOT NULL,
    readcount NUMBER DEFAULT 0,
    title varchar2(200),
    firstimage varchar2(200)
);

-------------------------------------
-- 즐겨찾기 저장
drop table NANDAL_BOOKMARK;

CREATE TABLE NANDAL_BOOKMARK (
    usercode  NUMBER(10) NOT NULL,
    contentid number,
    bookmark_group varchar2(200),
    bookmarkdate DATE
);