
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
 values (item_idx_seq.nextval, 'CU', '����', '�����', 1000, 0, 1.1);
insert into item (idx, sellcvs, category, itemname, itemprice, hit, averscore) 
values (item_idx_seq.nextval, 'GS25', '����', 'Ȩ����', 900, 0, 1.11);
insert into item (idx, sellcvs, category, itemname, itemprice, hit, averscore) 
values (item_idx_seq.nextval, '�����Ϸ���', '����', '�����۽�', 1500, 0, 3.20);
insert into item (idx, sellcvs, category, itemname, itemprice, hit, averscore) 
values (item_idx_seq.nextval, '�̸�Ʈ24', '����', '�ź�Ĩ', 2000, 0, 1);
insert into item (idx, sellcvs, category, itemname, itemprice, hit) 
values (item_idx_seq.nextval, 'CU', '����', '��������', 1000, 100);
insert into item (idx, sellcvs, category, itemname, itemprice, hit) 
values (item_idx_seq.nextval, 'GS25', '����', '����', 900, 90);
insert into item (idx, sellcvs, category, itemname, itemprice, hit) 
values (item_idx_seq.nextval, '��Ÿ ������', '����', '������', 1500, 80);
insert into item (idx, sellcvs, category, itemname, itemprice, hit) 
values (item_idx_seq.nextval, 'ministop', '����', '���ĸ�', 2000, 70);

insert into item (idx, sellcvs, category, itemname, itemprice, hit, averscore)
 values (item_idx_seq.nextval, 'CU', '����', '���ڿ�', 1000, 900, 1.1);
insert into item (idx, sellcvs, category, itemname, itemprice, hit, averscore) 
values (item_idx_seq.nextval, 'GS25', '����', '�Ŀ����̵�', 900, 290, 1.11);
insert into item (idx, sellcvs, category, itemname, itemprice, hit, averscore) 
values (item_idx_seq.nextval, '�����Ϸ���', '����', '���䷹��', 1500, 8, 3.20);
insert into item (idx, sellcvs, category, itemname, itemprice, hit, averscore) 
values (item_idx_seq.nextval, '�̸�Ʈ24', '���', '�λ����', 2000, 12, 1);
insert into item (idx, sellcvs, category, itemname, itemprice, hit) 
values (item_idx_seq.nextval, 'CU', '���', '�����', 1000, 150);
insert into item (idx, sellcvs, category, itemname, itemprice, hit) 
values (item_idx_seq.nextval, 'GS25', '���', '�Ŷ��', 900, 99);
insert into item (idx, sellcvs, category, itemname, itemprice, hit) 
values (item_idx_seq.nextval, '��Ÿ ������', '����', '�縻', 1500, 88);
insert into item (idx, sellcvs, category, itemname, itemprice, hit) 
values (item_idx_seq.nextval, 'ministop', '����', '������', 2000, 77);

select * from item where category = '����';

select * from(select * from item order by hit desc) where rownum <= 2;

select * from item order by hit desc;
select * from item order by idx desc;
select count(*) from ITEM;
commit;

ALTER TABLE item modify averscore number(*,2);