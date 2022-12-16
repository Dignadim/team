
 CREATE TABLE "TEAM"."MYPAGE" 
   (	"ID" VARCHAR2(30 BYTE) NOT NULL ENABLE, 
    "PASSWORD" VARCHAR2(30 BYTE) NOT NULL ENABLE, 
	"NICKNAME" VARCHAR2(30 BYTE) NOT NULL ENABLE, 
	"EMAIL" VARCHAR2(200 BYTE) NOT NULL ENABLE, 
	"SIGNUPDATE" DATE DEFAULT sysdate NOT NULL ENABLE,     
	"IMAGE" VARCHAR2(1000 BYTE),
    "INTRODUCE" VARCHAR2(1000 BYTE), 
	 CONSTRAINT "MYPAGE_PK" PRIMARY KEY ("ID")
     );
      
delete from mypage;
drop sequence mypage_id_seq;
create sequence mypage_id_seq;
 
insert into mypage (id, password, nickname, email, image, introduce) 
values ('test22', '1111', '별명', 'e@e', '?��미�??��?��?��', '?��기소개입?��?��');
select * from mypage order by id desc;
select count(*) from mypage;
commit;





