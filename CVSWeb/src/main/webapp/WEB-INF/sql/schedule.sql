CREATE TABLE "TEAM"."SCHEDULE" 
   (	
    "SYEAR" NUMBER(*,0) NOT NULL, 
	"SMONTH" NUMBER(*,0) NOT NULL, 
	"SDAY" NUMBER(*,0) NOT NULL, 
	"EYEAR" NUMBER(*,0), 
	"EMONTH" NUMBER(*,0), 
	"EDAY" NUMBER(*,0), 
	"EVENT" VARCHAR2(2000 BYTE) NOT NULL,
    "GUP" NUMBER(*,0)
   );
   drop table schedule;
delete from schedule;
drop sequence schedule_gup_seq;
create sequence schedule_gup_seq;

ALTER SEQUENCE schedule_gup_seq INCREMENT BY 33;
ALTER SEQUENCE schedule_gup_seq INCREMENT BY 1;

insert into schedule (syear, smonth, sday, eyear, emonth, eday, event) 
values (2022, 11, 10, 2022, 11, 20, 'gs25 50%Sale event중');

insert into schedule (syear, smonth, sday, event) 
values (2022, 11, 24, 'gs25 200%Sale event중!!');

insert into schedule (syear, smonth, sday, event) 
values (2022, 11, 24, '세븐일레븐 20%Sale event중!!');

insert into schedule (syear, smonth, sday, eyear, emonth, eday, event) 
values (2022, 11, 26, 2022, 12, 20, 'gs25 5%Sale event중...');


select * from schedule;
commit;