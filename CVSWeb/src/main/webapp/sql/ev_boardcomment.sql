  CREATE TABLE "TEAM"."EV_BOARDCOMMENT" (	
  	"EVC_IDX" NUMBER(*,0) NOT NULL ENABLE, 
	"EVC_GUP" NUMBER(*,0) NOT NULL ENABLE, 
	"EVC_CONTENT" VARCHAR2(2000 BYTE) NOT NULL ENABLE, 
	"EVC_DATE" DATE DEFAULT sysdate, 
	"ID" VARCHAR2(30 BYTE) NOT NULL ENABLE, 
	"NICKNAME" VARCHAR2(30 BYTE) NOT NULL ENABLE, 
	 CONSTRAINT "EV_BOARDCOMMENT_PK" PRIMARY KEY ("EVC_IDX")
   );
   
delete from ev_boardcomment;
drop sequence ev_boardcomment_idx_seq;
create sequence ev_boardcomment_idx_seq;

delete from ev_boardcomment where evc_idx = 2;

select * from ev_boardcomment;
select count(*) from ev_boardcomment;

commit;