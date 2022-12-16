  CREATE TABLE "TEAM"."MEMBER" 
   (	
    "ID" VARCHAR2(30 BYTE) NOT NULL, 
	"PASSWORD" VARCHAR2(30 BYTE) NOT NULL, 
	"NICKNAME" VARCHAR2(30 BYTE) NOT NULL, 
	"EMAIL" VARCHAR2(200 BYTE) NOT NULL, 
	"SIGNUPDATE" DATE DEFAULT sysdate NOT NULL, 
	"GRADE" CHAR(1 BYTE) DEFAULT 'n' NOT NULL, 
	 CONSTRAINT "MEMBER_PK" PRIMARY KEY ("ID")
   );
 
delete from member;
drop sequence member_id_seq;
create sequence member_id_seq;   
insert into member (id, password, nickname, email, grade) 
    values ('ȫ�浿', '1111', '�浿', 'gildong@naver.com', 'n');

insert into member(id, password, nickname, email, grade)
    values('asd', '1111', 'admin', 'qq@dd', 'y');

select * from member order by id desc;
select count(*) from member;

commit;









