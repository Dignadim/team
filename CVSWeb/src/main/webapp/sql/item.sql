
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
ALTER TABLE item modify averscore number(*,2);
--!!!!�� ������� �ݵ�� �������ּ���!!!!!!--

delete from item;
drop sequence item_idx_seq;
create sequence item_idx_seq;

insert into item (idx, sellcvs, category, itemname, itemprice, hit, eventtype, itemimage) values (item_idx_seq.nextval, 'CU', '�����ǰ', '�����', 1000, 0, '1+1', '../images/img01.jpg');
insert into item (idx, sellcvs, category, itemname, itemprice, hit, eventtype, itemimage) values (item_idx_seq.nextval, 'GS25', '������ǰ', '������', 900, 0, '2+1', '../images/img02.jpg');
insert into item (idx, sellcvs, category, itemname, itemprice, hit, eventtype, itemimage) values (item_idx_seq.nextval, '�����Ϸ���', '�Ｎ����', '���', 9000, 0, 'ī��� ����', '../images/img03.jpg');
insert into item (idx, sellcvs, category, itemname, itemprice, hit, eventtype, itemimage) values (item_idx_seq.nextval, '�̸�Ʈ24','�ż���ǰ', '������', 2000, 0, '����Ʈ ����', '../images/img04.jpg');
insert into item (idx, sellcvs, category, itemname, itemprice, hit, eventtype, itemimage) values (item_idx_seq.nextval, 'ministop', '����/��', '���ڱ�', 1000, 0, '2+1', '../images/img05.jpg');
insert into item (idx, sellcvs, category, itemname, itemprice, hit, eventtype, itemimage) values (item_idx_seq.nextval, '��Ÿ ������', '���̽�ũ��', '����', 50000, 0, 'ī��� ����', '../images/metamong.png');
insert into item (idx, sellcvs, category, itemname, itemprice, hit, eventtype, itemimage) values (item_idx_seq.nextval, 'CU', '����', '����', 1500, 0, '1+1', '../images/star.png');
insert into item (idx, sellcvs, category, itemname, itemprice, hit, eventtype, itemimage) values (item_idx_seq.nextval, 'GS25','���', '��ȭ', 6000, 0, '����Ʈ ����', '../images/halfstar.png');
insert into item (idx, sellcvs, category, itemname, itemprice, hit, eventtype, itemimage) values (item_idx_seq.nextval, 'GS25','���', '��ȣ��ǰ', 6000, 0, '����Ʈ ����', '../images/halfstar.png');
insert into item (idx, sellcvs, category, itemname, itemprice, hit, eventtype, itemimage) values (item_idx_seq.nextval, 'GS25','���', '��Ÿ��ǰ', 6000, 0, '����Ʈ ����', '../images/halfstar.png');

select * from item order by idx desc;
select count(*) from ITEM;
commit;