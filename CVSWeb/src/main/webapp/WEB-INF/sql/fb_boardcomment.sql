  CREATE TABLE "TEAM"."FB_BOARDCOMMENT" (	
  	"FBC_IDX" NUMBER NOT NULL ENABLE, 
	"FBC_GUP" NUMBER NOT NULL ENABLE, 
	"FBC_CONTENT" VARCHAR2(2000 BYTE) NOT NULL ENABLE, 
	"FBC_DATE" DATE DEFAULT sysdate, 
	"ID" VARCHAR2(30 BYTE) NOT NULL ENABLE, 
	"NICKNAME" VARCHAR2(30 BYTE) NOT NULL ENABLE, 
	 CONSTRAINT "FB_BOARDCOMMENT_PK" PRIMARY KEY ("FBC_IDX")
   );
   

   
delete from fb_boardcomment;
drop sequence fb_boardcomment_idx_seq;
create sequence fb_boardcomment_idx_seq;

ALTER SEQUENCE fb_boardcomment_idx_seq INCREMENT BY 17;
ALTER SEQUENCE fb_boardcomment_idx_seq INCREMENT BY 1;

insert into fb_boardcomment (fbc_idx, fbc_gup, fbc_content) 
    values (fb_boardcomment_idx_seq.nextval, 0, '룰루');

select * from fb_boardcomment;
select count(*) from fb_boardcomment;

commit;