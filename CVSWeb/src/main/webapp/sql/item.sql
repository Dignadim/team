
CREATE TABLE "TEAM"."ITEM" 
   (	"IDX" NUMBER NOT NULL ENABLE, 
	"CATEGORY" CHAR(20 BYTE) NOT NULL ENABLE, 
	"ITEMNAME" VARCHAR2(20 BYTE) NOT NULL ENABLE, 
	"ITEMPRICE" NUMBER NOT NULL ENABLE, 
	"SELLCVS" VARCHAR2(20 BYTE), 
	"AVERSCORE" NUMBER, 
	"EVENTTYPE" VARCHAR2(20 BYTE), 
	"EVENTSALE" NUMBER, 
	"HIT" VARCHAR2(20 BYTE), 
	 CONSTRAINT "ITEM_PK" PRIMARY KEY ("IDX")
	 );

delete from item;   
drop sequence item_idx_seq;
create sequence item_idx_seq;

insert into item (idx, sellcvs, category, itemname, itemprice, hit, averscore)
 values (item_idx_seq.nextval, 'CU', '과자', '새우깡', 1000, 0, 1.1);
insert into item (idx, sellcvs, category, itemname, itemprice, hit, averscore) 
values (item_idx_seq.nextval, 'GS25', '과자', '홈런볼', 900, 0, 1.11);
insert into item (idx, sellcvs, category, itemname, itemprice, hit, averscore) 
values (item_idx_seq.nextval, '세븐일레븐', '과자', '프링글스', 1500, 0, 3.20);
insert into item (idx, sellcvs, category, itemname, itemprice, hit, averscore) 
values (item_idx_seq.nextval, '이마트24', '과자', '거북칩', 2000, 0, 1);
insert into item (idx, sellcvs, category, itemname, itemprice, hit) 
values (item_idx_seq.nextval, 'CU', '과자', '초코파이', 1000, 100);
insert into item (idx, sellcvs, category, itemname, itemprice, hit) 
values (item_idx_seq.nextval, 'GS25', '과자', '몽쉘', 900, 90);
insert into item (idx, sellcvs, category, itemname, itemprice, hit) 
values (item_idx_seq.nextval, '기타 편의점', '과자', '초코콘', 1500, 80);
insert into item (idx, sellcvs, category, itemname, itemprice, hit) 
values (item_idx_seq.nextval, 'ministop', '과자', '양파링', 2000, 70);

insert into item (idx, sellcvs, category, itemname, itemprice, hit, averscore)
 values (item_idx_seq.nextval, 'CU', '음료', '데자와', 1000, 900, 1.1);
insert into item (idx, sellcvs, category, itemname, itemprice, hit, averscore) 
values (item_idx_seq.nextval, 'GS25', '음료', '파워에이드', 900, 290, 1.11);
insert into item (idx, sellcvs, category, itemname, itemprice, hit, averscore) 
values (item_idx_seq.nextval, '세븐일레븐', '음료', '게토레이', 1500, 8, 3.20);
insert into item (idx, sellcvs, category, itemname, itemprice, hit, averscore) 
values (item_idx_seq.nextval, '이마트24', '라면', '민생라면', 2000, 12, 1);
insert into item (idx, sellcvs, category, itemname, itemprice, hit) 
values (item_idx_seq.nextval, 'CU', '라면', '진라면', 1000, 150);
insert into item (idx, sellcvs, category, itemname, itemprice, hit) 
values (item_idx_seq.nextval, 'GS25', '라면', '신라면', 900, 99);
insert into item (idx, sellcvs, category, itemname, itemprice, hit) 
values (item_idx_seq.nextval, '기타 편의점', '생필', '양말', 1500, 88);
insert into item (idx, sellcvs, category, itemname, itemprice, hit) 
values (item_idx_seq.nextval, 'ministop', '생필', '충전기', 2000, 77);

select * from item where category = '과자';

select * from(select * from item order by hit desc) where rownum <= 2;

select * from item order by hit desc;
select * from item order by idx desc;
select count(*) from ITEM;
commit;

ALTER TABLE item modify averscore number(*,2);