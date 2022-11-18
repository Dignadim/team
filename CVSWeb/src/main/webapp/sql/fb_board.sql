  CREATE TABLE "TEAM"."FB_BOARD" (
    "FB_IDX" NUMBER(*,0) NOT NULL ENABLE, 
	"FB_SUBJECT" VARCHAR2(200 BYTE) NOT NULL ENABLE, 
	"FB_CONTENT" VARCHAR2(3000 BYTE) NOT NULL ENABLE, 
	"FB_DATE" DATE DEFAULT sysdate, 
	"FB_HIT" NUMBER(*,0) DEFAULT 0, 
	"FB_NOTICE" CHAR(3 BYTE) DEFAULT 'no', 
	"ID" VARCHAR2(30 BYTE) NOT NULL ENABLE, 
	"NICKNAME" VARCHAR2(30 BYTE) NOT NULL ENABLE, 
	 CONSTRAINT "FB_BOARD_PK" PRIMARY KEY ("FB_IDX")
   );

delete from fb_board;
drop sequence fb_board_idx_seq;
create sequence fb_board_idx_seq;

insert into fb_board (fb_idx, fb_subject, fb_content, fb_hit, fb_notice) 
    values (fb_board_idx_seq.nextval, '1111', '1111', 0, 'no');

select * from fb_board;
select count(*) from fb_board;

commit;

