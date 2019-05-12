# xyz-heap-what-is-it-good-for

This is the full demo of the https://2019.pgconf.de/ talk about zheap. It is not a developer talk but more a DBA perspective about zheap. What is it good for and for what use cases you would probably stick with the current "heap" implementation.

To run the demo download the complete repository and then prepare the operating system and PostgreSQL installation. This demo is based on CentOS 7 so you will need to adjust the packages if you want to run it on Debian based or any other distribution.

```bash
sudo yum install -y gcc openldap-devel python-devel readline-devel redhat-lsb bison flex perl-ExtUtils-Embed zlib-devel crypto-utils openssl-devel pam-devel libxml2-devel libxslt-devel openssh-clients bzip2 net-tools wget screen unzip sysstat xorg-x11-xauth systemd-devel bash-completion cowsay
sudo groupadd postgres
useradd -g postgres -m postgres
sudo mkdir /u01/app
sudo mkdir /u02
sudo chown postgres:postgres /u01/app
sudo chown postgres:postgres /u02
sudo su - postgres
git clone https://github.com/EnterpriseDB/zheap
cd zheap
PGHOME=/u01/app/postgres/product/zheap/db_1/
/configure --prefix=${PGHOME}
make all
make install
cd contrib
make install
/u01/app/postgres/product/zheap/db_1/bin/initdb -D /u02/pgdata/zheap
/u01/app/postgres/product/zheap/db_1/bin/pg_ctl -D /u02/pgdata/zheap start
/u01/app/postgres/product/zheap/db_1/bin/psql -c "alter system set logging_collector='on'" postgres
u01/app/postgres/product/zheap/db_1/bin/psql -c "alter system set log_truncate_on_rotation='on'" postgres
/u01/app/postgres/product/zheap/db_1/bin/psql -c "alter system set log_filename='postgresql-%a.log'" postgres
/u01/app/postgres/product/zheap/db_1/bin/psql -c "alter system set log_line_prefix='%m - %l - %p - %h - %u@%d '" postgres
/u01/app/postgres/product/zheap/db_1/bin/psql -c "alter system set log_directory='pg_log'" postgres
/u01/app/postgres/product/zheap/db_1/bin/pg_ctl -D /u02/pgdata/zheap restart -m fast
```

Once this is done start the demo with (for displaying the pictures you will need X forwarding if you connect over ssh):
```bash
sudo su - postgres
./zheap_demo.sh
```
