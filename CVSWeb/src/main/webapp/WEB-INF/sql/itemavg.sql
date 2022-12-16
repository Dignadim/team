CREATE TABLE "TEAM"."ITEMAVG" 
   (	"ITEMIDX" NUMBER NOT NULL ENABLE, 
	"AVERSCORE" NUMBER NOT NULL ENABLE, 
	"AVGINDEX" NUMBER NOT NULL ENABLE, 
	"ID" VARCHAR2(30 BYTE) NOT NULL ENABLE, 
	 CONSTRAINT "ITEMAVG_PK" PRIMARY KEY ("AVGINDEX") );

commit;

select * from itemavg;

delete from itemavg;
drop sequence itemavg_avgindex_seq;
create sequence itemavg_avgindex_seq;