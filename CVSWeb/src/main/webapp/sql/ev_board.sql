  CREATE TABLE "TEAM"."EV_BOARD" (	
    "EV_IDX" NUMBER(*,0) NOT NULL ENABLE, 
	"EV_SELLCVS" CHAR(15 BYTE) NOT NULL ENABLE, 
	"EV_SUBJECT" VARCHAR2(100 BYTE) NOT NULL ENABLE, 
	"EV_CONTENT" VARCHAR2(2000 BYTE) NOT NULL ENABLE, 
	"EV_HIT" NUMBER(*,0) DEFAULT 0, 
	"EV_DATE" DATE DEFAULT sysdate, 
	"EV_NOTICE" CHAR(3 BYTE) DEFAULT 'off', 
	 CONSTRAINT "EV_BOARD_PK" PRIMARY KEY ("EV_IDX")
   );
   
delete from ev_board;
drop sequence ev_board_idx_seq;
create sequence ev_board_idx_seq;

select * from ev_board;
select count(*) from ev_board

commit;