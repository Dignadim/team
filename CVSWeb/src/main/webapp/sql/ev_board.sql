  CREATE TABLE "TEAM"."EV_BOARD" (
    "EV_IDX" NUMBER(*,0) NOT NULL ENABLE, 
	"EV_SELLCVS" CHAR(15 BYTE) NOT NULL ENABLE, 
	"EV_SUBJECT" VARCHAR2(100 BYTE) NOT NULL ENABLE, 
	"EV_CONTENT" VARCHAR2(2000 BYTE) NOT NULL ENABLE, 
	"EV_HIT" NUMBER(*,0) DEFAULT 0, 
	"EV_DATE" DATE DEFAULT sysdate, 
	"EV_NOTICE" CHAR(3 BYTE) DEFAULT 'no', 
	"EV_FILENAME" VARCHAR2(255 BYTE), 
	"ID" VARCHAR2(30 BYTE) NOT NULL ENABLE, 
	"NICKNAME" VARCHAR2(30 BYTE) NOT NULL ENABLE, 
	 CONSTRAINT "EV_BOARD_PK" PRIMARY KEY ("EV_IDX")
   );
   
delete from ev_board;
drop sequence ev_board_idx_seq;
create sequence ev_board_idx_seq;

insert into ev_board (ev_idx, ev_sellcvs, ev_subject, ev_content, ev_notice, ev_filename, id, nickname) 
 	values (ev_board_idx_seq.nextval, 'ministop', 'ê¸?? œëª?', 'ê¸??‚´?š©', 'no', null, 'system', '?‹œ?Š¤?…œ');

select * from ev_board;
select count(*) from ev_board;

commit;