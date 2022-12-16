CREATE TABLE "TEAM"."ITEM" 
   (	"IDX" NUMBER NOT NULL ENABLE, 
	"CATEGORY" CHAR(20 BYTE) NOT NULL ENABLE, 
	"ITEMNAME" VARCHAR2(200 BYTE) NOT NULL ENABLE, 
	"ITEMPRICE" NUMBER NOT NULL ENABLE, 
	"SELLCVS" VARCHAR2(20 BYTE), 
	"AVERSCORE" NUMBER(*,2) DEFAULT 0.0 NOT NULL ENABLE, 
	"EVENTTYPE" VARCHAR2(20 BYTE), 
	"HIT" VARCHAR2(20 BYTE) DEFAULT 0, 
	"ITEMIMAGE" VARCHAR2(200 BYTE) NOT NULL ENABLE, 
	"ITEMDATE" TIMESTAMP (6) DEFAULT sysdate, 
	 CONSTRAINT "ITEM_PK" PRIMARY KEY ("IDX")
	 );
ALTER TABLE item modify averscore number(*,2);
--!!!!위 문장까지 반드시 실행해주세요!!!!!!--

delete from item;
drop sequence item_idx_seq;
create sequence item_idx_seq;

insert into item (idx, sellcvs, category, itemname, itemprice, hit, eventtype, itemimage) values (item_idx_seq.nextval, 'CU', '간편식품', '새우깡', 1000, 0, '1+1', '../images/img01.jpg');
insert into item (idx, sellcvs, category, itemname, itemprice, hit, eventtype, itemimage) values (item_idx_seq.nextval, 'GS25', '가공식품', '이프로', 900, 0, '2+1', '../images/img02.jpg');
insert into item (idx, sellcvs, category, itemname, itemprice, hit, eventtype, itemimage) values (item_idx_seq.nextval, '세븐일레븐', '즉석조리', '우산', 9000, 0, '카드사 할인', '../images/img03.jpg');
insert into item (idx, sellcvs, category, itemname, itemprice, hit, eventtype, itemimage) values (item_idx_seq.nextval, '이마트24','신선식품', '볶음면', 2000, 0, '포인트 적립', '../images/img04.jpg');
insert into item (idx, sellcvs, category, itemname, itemprice, hit, eventtype, itemimage) values (item_idx_seq.nextval, 'ministop', '과자/빵', '감자깡', 1000, 0, '2+1', '../images/img05.jpg');
insert into item (idx, sellcvs, category, itemname, itemprice, hit, eventtype, itemimage) values (item_idx_seq.nextval, '기타 편의점', '아이스크림', '와인', 50000, 0, '카드사 할인', '../images/metamong.png');

select * from item order by idx desc;
select count(*) from ITEM;
commit;

