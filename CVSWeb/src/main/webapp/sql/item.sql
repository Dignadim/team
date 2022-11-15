
CREATE TABLE "TEAM"."ITEM" 
   (	"IDX" NUMBER NOT NULL ENABLE, 
	"category" CHAR(20 BYTE) NOT NULL ENABLE, 
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

insert into item (idx, sellcvs, category, itemname, itemprice, hit, averscore) values (item_idx_seq.nextval, 'CU', '����', '�����', 1000, 0, 1.1);
insert into item (idx, sellcvs, category, itemname, itemprice, hit, averscore) values (item_idx_seq.nextval, 'GS25', '���', '�Ŷ��', 900, 0, 1.11);
insert into item (idx, sellcvs, category, itemname, itemprice, hit, averscore) values (item_idx_seq.nextval, '�����Ϸ���', '����', '��ī��', 1500, 0, 3.20);
insert into item (idx, sellcvs, category, itemname, itemprice, hit, averscore) values (item_idx_seq.nextval, '�̴Ͻ���', '����', '����', 2000, 0, 1);
insert into item (idx, sellcvs, category, itemname, itemprice, hit) values (item_idx_seq.nextval, 'CU', '����', '�����', 1000, 100);
insert into item (idx, sellcvs, category, itemname, itemprice, hit) values (item_idx_seq.nextval, 'GS25', '���', '�Ŷ��', 900, 90);
insert into item (idx, sellcvs, category, itemname, itemprice, hit) values (item_idx_seq.nextval, '�����Ϸ���', '����', '��ī��', 1500, 80);
insert into item (idx, sellcvs, category, itemname, itemprice, hit) values (item_idx_seq.nextval, '�̴Ͻ���', '����', '����', 2000, 70);

select * from item order by idx desc;
select count(*) from ITEM;
commit;

ALTER TABLE item modify averscore number(*,2);