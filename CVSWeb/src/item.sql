select * from item order by idx desc;
ALTER TABLE item modify averscore number(*,2);

delete from item;
drop sequence item_idx_seq;
create sequence item_idx_seq;

commit;


insert into item (idx, sellcvs, category, itemname, itemprice, hit, averscore) values (item_idx_seq.nextval, 'CU', '과자', '새우깡', 1000, 0, 1.1);
insert into item (idx, sellcvs, category, itemname, itemprice, hit, averscore) values (item_idx_seq.nextval, 'GS25', '라면', '신라면', 900, 0, 1.11);
insert into item (idx, sellcvs, category, itemname, itemprice, hit, averscore) values (item_idx_seq.nextval, '세븐일레븐', '음료', '포카리', 1500, 0, 3.20);
insert into item (idx, sellcvs, category, itemname, itemprice, hit, averscore) values (item_idx_seq.nextval, '미니스톱', '생필', '볼펜', 2000, 0, 1);

insert into item (idx, sellcvs, category, itemname, itemprice, hit) values (item_idx_seq.nextval, 'CU', '과자', '새우깡', 1000, 100);
insert into item (idx, sellcvs, category, itemname, itemprice, hit) values (item_idx_seq.nextval, 'GS25', '라면', '신라면', 900, 90);
insert into item (idx, sellcvs, category, itemname, itemprice, hit) values (item_idx_seq.nextval, '세븐일레븐', '음료', '포카리', 1500, 80);
insert into item (idx, sellcvs, category, itemname, itemprice, hit) values (item_idx_seq.nextval, '미니스톱', '생필', '볼펜', 2000, 70);
