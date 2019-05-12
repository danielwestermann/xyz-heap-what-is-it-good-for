\timing
drop table if exists dummy;
create table dummy (a int, b text) using zheap;
begin;
insert into dummy select i,i::text from generate_series(1,1000000) i;
select pg_size_pretty ( pg_relation_size ('dummy'));
rollback;
