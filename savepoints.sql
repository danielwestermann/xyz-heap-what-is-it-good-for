drop table if exists tsavepoint;
create table tsavepoint ( a int, b text ) using zheap;
begin;
insert into tsavepoint select a,md5(a::text) from generate_series (1,1000000) a;
savepoint sp1;
update tsavepoint set a = 5;
savepoint sp2;
delete from tsavepoint;
rollback to sp1;
