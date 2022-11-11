
 CREATE TABLE "SSH"."MYPAGE" 
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
values ('test', '1111', '별명', 'e@e', '이미지입니다', '자기소개입니다');
select * from mypage order by id desc;
select count(*) from mypage;
commit;





