  CREATE TABLE "TEAM"."ITEMCOMMENT" 
   (	"IDX" NUMBER NOT NULL ENABLE, 
	"GUP" NUMBER NOT NULL ENABLE, 
	"NICKNAME" VARCHAR2(20 BYTE), 
	"CONTENT" VARCHAR2(2000 BYTE) NOT NULL ENABLE, 
	"WRITEDATE" TIMESTAMP (6) DEFAULT sysdate, 
	"ID" VARCHAR2(30 BYTE), 
	 CONSTRAINT "ITEMCOMMENT_PK" PRIMARY KEY ("IDX")
);


delete from itemcomment;
drop sequence itemcomment_idx_seq;
create sequence itemcomment_idx_seq;
ALTER SEQUENCE itemcomment_idx_seq INCREMENT BY 22;
ALTER SEQUENCE itemcomment_idx_seq INCREMENT BY 1;
insert into ITEMCOMMENT(idx, gup, nickname, content, id) 
    values ('itemcomment_idx_seq.nextval', '1', '가렌', '글내용준나게 길게', '아이디');


select * from itemcomment order by idx desc;
commit;
