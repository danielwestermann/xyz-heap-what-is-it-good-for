#!/bin/bash

# define the colors we use for this demo
COLOR_DEFAULT="\e[39m"
COLOR_GREEN="\e[32m"
COLOR_RED="\e[31m"
COLOR_YELLOW="\e[33m"
COLOR_BLUE="\e[34m"

# PostgreSQL environment
export PGHOME=/u01/app/postgres/product/zheap/db_1
export PATH=$PGHOME/bin:$PATH
export PGDATA=/u02/pgdata/zheap
export PGPORT=5438

# Global variables
PGBENCH_SCALE_FACTOR=10

function _wait_for_next_step {
    echo -e "${COLOR_RED}"
    read -p "-----> ${1}"
    echo -e "${COLOR_DEFAULT}"
}

# this function prints the title of the talk
function _title {
    THEEND=${1}
    clear
    echo -e ${COLOR_BLUE}
    echo " "
    echo "                                        ____  ______  ___   "
    echo "                                       /    )/      \/   \  "
    echo "                                      (     / __    _\    ) "
    echo "                                       \    (/ o)  ( o)   ) "
    echo "                                        \_  (_  )   \ ) _/  "
    echo "                                          \  /\_/    \)/    "
    echo "                                           \/ <//|  |\\>    "
    echo "                                                _|  |       "
    echo "                                                \|_/        "
    echo -e ${COLOR_DEFAULT}
    echo " .____            ____.    .____            ____.                     .__                           "
    echo " |   _| ___  ___ |_   |    |   _|  ___.__. |_   |    ________         |  |__   ____ _____  ______   "
    echo " |  |   \  \/  /   |  |    |  |   <   |  |   |  |    \___   /  ______ |  |  \_/ __ \\__  \ \____ \  "
    echo " |  |    >    <    |  |    |  |    \___  |   |  |     /    /  /_____/ |   Y  \  ___/ / __ \|  |_> > "
    echo " |  |_  /__/\_ \  _|  | /\ |  |_   / ____|  _|  | /\ /_____ \         |___|  /\___  >____  /   __/  "
    echo " |____|       \/ |____| )/ |____|  \/      |____| )/       \/              \/     \/     \/|__|     "
    echo -e ${COLOR_DEFAULT}
    echo " __          ___           _     _       _ _                           _    __         ___    "
    echo " \ \        / / |         | |   (_)     (_) |                         | |  / _|       |__ \   "
    echo "  \ \  /\  / /| |__   __ _| |_   _ ___   _| |_    __ _  ___   ___   __| | | |_ ___  _ __ ) |  "
    echo "   \ \/  \/ / | '_ \ / _  | __| | / __| | | __|  / _  |/ _ \ / _ \ / _  | |  _/ _ \| '__/ /   "
    echo "    \  /\  /  | | | | (_| | |_  | \__ \ | | |_  | (_| | (_) | (_) | (_| | | || (_) | | |_|    "
    echo "     \/  \/   |_| |_|\__,_|\__| |_|___/ |_|\__|  \__, |\___/ \___/ \__,_| |_| \___/|_| (_)    "
    echo "                                                  __/ |                                       " 
    echo "                                                 |___/                                        "
    echo -e ${COLOR_DEFAULT}
    if [ "${THEEND}" == "1" ]; then
        _wait_for_next_step "T H E --- E N D"
    else
        _wait_for_next_step "Ready to start?"
    fi
}

# this function prints the title of the talk
function _dbi {
    clear
    display Selection_048.png
    display Selection_047.png
    _wait_for_next_step "Let's start"
}

# this functions provides the steps to create the test environment 
# as it is used in this talk
function _zheap_setup_info {
    clear
    echo -e ${COLOR_GREEN}
    echo "To create this environment follow the steps below"
    echo -e ${COLOR_DEFAULT}
    echo "# sudo yum install -y gcc openldap-devel python-devel readline-devel redhat-lsb bison flex perl-ExtUtils-Embed zlib-devel crypto-utils openssl-devel pam-devel libxml2-devel libxslt-devel openssh-clients bzip2 net-tools wget screen unzip sysstat xorg-x11-xauth systemd-devel bash-completion cowsay"
    echo "# git clone https://github.com/EnterpriseDB/zheap"
    echo "# cd zheap"
    echo "# PGHOME=/u01/app/postgres/product/zheap/db_1/"
    echo "# ./configure --prefix=\${PGHOME}"
    echo "# make all"
    echo "# make install"
    echo "# cd contrib"
    echo "# make install"
    echo "# /u01/app/postgres/product/zheap/db_1/bin/initdb -D /u02/pgdata/zheap"
    echo "# /u01/app/postgres/product/zheap/db_1/bin/pg_ctl -D /u02/pgdata/zheap start"
    echo "# /u01/app/postgres/product/zheap/db_1/bin/psql -c \"alter system set logging_collector='on'\" postgres"
    echo "# /u01/app/postgres/product/zheap/db_1/bin/psql -c \"alter system set log_truncate_on_rotation='on'\" postgres"
    echo "# /u01/app/postgres/product/zheap/db_1/bin/psql -c \"alter system set log_filename='postgresql-%a.log'\" postgres"
    echo "# /u01/app/postgres/product/zheap/db_1/bin/psql -c \"alter system set log_line_prefix='%m - %l - %p - %h - %u@%d '\" postgres"
    echo "# /u01/app/postgres/product/zheap/db_1/bin/psql -c \"alter system set log_directory='pg_log'\" postgres"
    echo "# /u01/app/postgres/product/zheap/db_1/bin/pg_ctl -D /u02/pgdata/zheap restart -m fast"
    _wait_for_next_step "Not really magic, do you agree?"
}

# print the disclaimer
function _disclaimer {
    clear
    echo -e ${COLOR_GREEN}
    echo "        _ _          _       _                          "
    echo "       | (_)        | |     (_)                         "
    echo "     __| |_ ___  ___| | __ _ _ _ __ ___   ___ _ __      "
    echo "    / _  | / __|/ __| |/ _  | | '_   _ \ / _ \ '__|     "
    echo "   | (_| | \__ \ (__| | (_| | | | | | | |  __/ |        "
    echo "    \__,_|_|___/\___|_|\__,_|_|_| |_| |_|\___|_|        "
    echo " "
    echo " This talk would not have been possible without         "
    echo " the help from Amit Kapila (EDB) who provided help      "
    echo " whenever required and inspired me to this talk         "
    echo " with his talk about zheap last year in Lisbon.         "
    echo " "
    echo " https://www.postgresql.eu/events/pgconfeu2018/schedule/"
    /usr/bin/display Selection_083.png
    _wait_for_next_step "Now we are really ready to start!"
}

# Setup the heap database
function _setup_heap_datbase {
    pg_ctl -D $PGDATA start
    psql -X -c "alter system set default_table_access_method='heap'" postgres
    psql -X -c "drop tablespace undotbs" postgres
    psql -X -c "alter system reset undo_tablespaces" postgres
    pg_ctl -D $PGDATA restart -m fast
    rm -rf /var/tmp/undo
    clear
    echo -e ${COLOR_GREEN}
    echo "We are setting up a database with heap tables"
    echo " "
    echo -e ${COLOR_DEFAULT}
    echo "psql -X -c 'drop database if exists heap' postgres" 
    echo "psql -X -c 'create database heap' postgres" 
    echo "pgbench -i -s ${PGBENCH_SCALE_FACTOR} heap" 
    _wait_for_next_step "Go!"
    psql -X -c 'drop database if exists heap' postgres
    psql -X -c 'create database heap' postgres
    pgbench -i -s ${PGBENCH_SCALE_FACTOR} heap
    _wait_for_next_step "Heap database created"
}

# What is bloat?
function _what_is_bloat {
    clear;
    echo " "
    echo -e ${COLOR_GREEN}
    echo "At some point in time you will probably have to deal with bloat."
    echo -e ${COLOR_YELLOW}
    cowsay -f /usr/share/cowsay/surgery.cow "What is bloat?" 
    echo -e ${COLOR_GREEN}
    _wait_for_next_step "Any ideas?"
    clear
    echo -e ${COLOR_GREEN}
    echo "We will create a copy of the pgbench_accounts table as we need the original one later."
    echo "We then check the size of the table, update all rows and check the size again."
    echo -e ${COLOR_DEFAULT}
    echo " "
    echo "psql -X -c \"create table test using heap as select from pgbench_accounts\" heap"
    echo "psql -X -c \"select pg_size_pretty(pg_relation_size('test'))\" heap"
    echo "psql -X -c \"update test set filler = 'aaa'\" heap"
    echo "psql -X -c \"select pg_size_pretty(pg_relation_size('test'))\" heap"
    _wait_for_next_step "Go!"
    psql -X -c "create table test using heap as select * from pgbench_accounts" heap
    psql -X -c "select pg_size_pretty(pg_relation_size('test'))" heap
    psql -X -c "update test set filler = 'aaa'" heap
    psql -X -c "select pg_size_pretty(pg_relation_size('test'))" heap
    echo -e ${COLOR_GREEN}
    cowsay -f /usr/share/cowsay/supermilker.cow "This is bloat!!!"
    echo -e ${COLOR_DEFAULT}
    _wait_for_next_step "Clear?"
}

# create same database as the heap one, but with zheap tables
function _setup_zheap_database {
    clear
    echo -e ${COLOR_GREEN}
    echo "There is a new parameter called 'default_table_access_method', both, as a system parameter and a parameter for create table"
    echo -e ${COLOR_DEFAULT}
    echo " "
    echo "psql -X -c 'show default_table_access_method' heap"
    psql -X -c "show default_table_access_method" heap;
    echo " "
    echo -e ${COLOR_GREEN}
    echo "The create table syntax is:"
    echo -e ${COLOR_DEFAULT}
    echo " "
    echo "CREATE TABLE T1 ( a INT ) USING ZHEAP"
    echo " "
    echo -e ${COLOR_GREEN}
    echo "... This will propably not change anymore as it is already committed, it was 'storage_engine' in the past!"
    echo -e ${COLOR_DEFAULT}
    _wait_for_next_step "Next?"
    clear
    echo -e ${COLOR_GREEN}
    echo "Lets setup the same database we used for heap, but now containing only zheap tables."
    echo "For that we change the default_table_access_method parameter to zheap, restart the instance "
    echo "and then use pgbench in the same way as before"
    echo -e ${COLOR_DEFAULT}
    echo "psql -X -c \"alter system set default_table_access_method='zheap' postgres\""
    echo "pg_ctl -D $PGDATA restart -m fast"
    echo "psql -X -c \"show default_table_access_method' postgres\""
    echo " "
    echo " "
    psql -X -c "alter system set default_table_access_method='zheap'" postgres
    pg_ctl -D $PGDATA restart -m fast
    echo " "
    psql -X -c "show default_table_access_method" postgres
    _wait_for_next_step "Populate?"
    clear
    echo "psql -X -c 'drop database if exists zheap' postgres" 
    echo "psql -X -c 'create database zheap' postgres" 
    echo "pgbench -i -s ${PGBENCH_SCALE_FACTOR} zheap" 
    echo " "
    echo -e ${COLOR_GREEN}
    echo "Populate with pgbench"
    echo -e ${COLOR_DEFAULT}
    _wait_for_next_step "Ready?"
    psql -X -c 'drop database if exists zheap' postgres
    psql -X -c 'create database zheap' postgres
    pgbench -i -s ${PGBENCH_SCALE_FACTOR} zheap 
    _wait_for_next_step "Populated"
}

# compare the size of the tables in heap and zheap
function _compare_heap_and_zheap_space_consumption {
    clear;
    echo -e ${COLOR_GREEN}
    echo "Lets compare the size of the pgbench_accounts table in both databases"
    echo -e ${COLOR_DEFAULT}
    echo " "
    echo " "
    echo "psql -X -c \"select pg_size_pretty(pg_relation_size('pgbench_accounts'))\" heap"
    echo "psql -X -c \"select pg_size_pretty(pg_relation_size('pgbench_accounts'))\" zheap"
    echo " "
    echo " "
    psql -X -c "select pg_size_pretty(pg_relation_size('pgbench_accounts')) as heap" heap
    psql -X -c "select pg_size_pretty(pg_relation_size('pgbench_accounts')) as zheap" zheap
    _wait_for_next_step "What is the reason for that? We do not have bloat right now or do we?"
}

# compare the row headers
function _compare_row_headers {
    clear;
    echo -e ${COLOR_GREEN}
    echo "Lets have a look at a standard heap row header in PostgreSQL."
    echo "For that we need to install the pageinspect extension and once"
    echo "we have that we look at the first page of the pgbench_accounts"
    echo "table. "
    echo " "
    echo -e ${COLOR_DEFAULT}
    echo "psql -X -c \"create extension pageinspect\" heap"
    echo "psql -X -c \"select * from heap_page_items(get_raw_page('pgbench_accounts', 1)) limit 1\" heap"
    echo " "
    _wait_for_next_step "How many header data do we see?"
    psql -X -c "create extension if not exists pageinspect" heap
    psql -X -c "select * from heap_page_items(get_raw_page('pgbench_accounts', 1)) limit 1" heap
    _wait_for_next_step "That's quite a few!"
    echo " "
    echo -e ${COLOR_GREEN}
    echo "This is the description from the official documentation:"
    echo " "
    display Selection_092.png
    clear
    echo " "
    echo "This is 25 Bytes in total, for each tuple/row"
    echo "So in total, for the pgbench_accounts table, we have:"
    echo " "
    echo "1000000*25=25000000 Bytes or 23 MB"
    echo " "
    _wait_for_next_step "This is not nothing!"
    clear
    echo -e ${COLOR_GREEN}
    echo "Lets do the same test against the zheap table"
    echo " "
    echo -e ${COLOR_DEFAULT}
    echo "psql -X -c \"create extension pageinspect\" zheap"
    echo "psql -X -c \"select * from zheap_page_items(get_raw_page('pgbench_accounts', 1)) limit 1\" zheap"
    echo " "
    _wait_for_next_step "How many header data do we see in zheap?"
    psql -X -c "create extension if not exists pageinspect" zheap
    psql -X -c "select * from heap_page_items(get_raw_page('pgbench_accounts', 1)) limit 1" heap
    psql -X -c "select * from zheap_page_items(get_raw_page('pgbench_accounts', 1)) limit 1" zheap
    _wait_for_next_step "Lesser page header data is required with zheap"
    clear
    echo -e ${COLOR_GREEN}
    echo "The main reason is that the tuple header is greatly reduced:"
    echo " "
    echo "==> src/include/access/zhtup.h"
    echo " "
    echo -e ${COLOR_DEFAULT}
    echo "typedef struct ZHeapTupleHeaderData"
    echo "{"
    echo "        uint16          t_infomask2;    /* number of attributes + translot info + various flags */ "
    echo "        uint16          t_infomask;     /* various flag bits, see below */ "
    echo "        uint8           t_hoff;         /* sizeof header incl. bitmap, padding */ "
    echo " "
    echo "        /* ^ - 5 bytes - ^ */"
    echo " "
    echo " "
    _wait_for_next_step "This are only 5 bytes per tuple"
    echo " "
    echo "1000000*5=5000000 Bytes or 4 MB"
    echo " "
    _wait_for_next_step "This is a huge difference! We saved 23-4=19MB of row header data!"
}

# explaining the background workers
function _what_happens_in_the_background {
    clear;
    echo -e ${COLOR_GREEN}
    echo "When zheap promises to avoid table bloat how does that work then?"
    echo "With the current heap, updates generate new rows. How does an update"
    echo "work with zheap then?"
    echo " "
    echo "The **magic** here is undo, much like Oracle is doing it. For every" 
    echo "operation (insert/update/delete) an undo operation is logged"
    echo "which restores the state of the tuple in case of a rollback."
    echo " "
    echo "For insert this becomes removal of the tuple (undo insert)"
    echo "For delete this becomes restore the row (undo delete)"
    echo "For update this becomes an in place udpate, or:"
    echo "  ... it becomes delete + insert (special case, more on that later)"
    echo -e ${COLOR_DEFAULT}
    _wait_for_next_step "Let's see that in action"
    clear
    echo -e ${COLOR_GREEN}
    echo "When we modify tuples with zheap, undo is written in the background."
    echo "Undo files get generated in \$PGDATA/base/undo by default"
    echo -e ${COLOR_DEFAULT}
    echo "ls -la \$PGDATA/base"
    ls -la $PGDATA/base 
    echo -e ${COLOR_GREEN}
    _wait_for_next_step "Currently we do not see much there"
    clear
    echo "ls -la \$PGDATA/base/undo/*"
    echo -e ${COLOR_DEFAULT}
    ls -la $PGDATA/base/undo/*
    _wait_for_next_step "So, lets generate some changes"
    clear
    echo -e ${COLOR_GREEN}
    echo "We will change the tuples in the background so we can see"
    echo "in real time what is happening in the location of the undo files"
    echo " "
    echo -e ${COLOR_DEFAULT}
    echo "nohup psql -X -c \"update pgbench_accounts set filler = 'bbb'\" zheap &"
    echo "for i in {1..6}; do"
    echo "     ls -la $PGDATA/base/undo/*"
    echo "     sleep 2"
    echo "     clear"
    _wait_for_next_step "Fire update?"
    nohup psql -X -c "update pgbench_accounts set filler = 'bbb'" zheap &
    for i in {1..6}; do
         ls -la $PGDATA/base/undo/*
         sleep 2
         clear
    done
    _wait_for_next_step "Next"
    echo "What happened? For the duration of the transaction undo files have"
    echo "been generated and once the transaction committed the files disappeared."
    echo "The size of one undo file is exactly one MB and undo files are"
    echo "specific for one backend."
    echo " "
    clear;
    echo -e ${COLOR_GREEN}
    echo "So undo always goes to the base directory in \$PGDATA?"
    echo "Would be great if we can decide where to put the undo files, wouldn't it?"
    echo " "
    _wait_for_next_step "What concept probably is used to achieve that?"
    clear
    echo -e ${COLOR_DEFAULT}
    echo " "
    echo "psql -X -c \"show undo_tablespaces;\" zheap"
    echo " "
    psql -X -c "show undo_tablespaces;" zheap
    echo " "
    echo "mkdir -p /var/tmp/undo"
    echo "psql -X -c \"create tablespace undotbs location '/var/tmp/undo';\" zheap"
    echo "psql -X -c \"alter system set undo_tablespaces='undotbs';\" zheap"
    echo "pg_ctl -D \$PGDATA restart -m fast"
    _wait_for_next_step "Ready?"
    mkdir -p /var/tmp/undo
    psql -X -c "create tablespace undotbs location '/var/tmp/undo';" zheap
    psql -X -c "alter system set undo_tablespaces='undotbs';" zheap
    pg_ctl -D $PGDATA restart -m fast
    echo " "
    echo " "
    clear
    echo -e ${COLOR_GREEN}
    echo "From now on undo goes to the undo tablespace(s)"
    echo -e ${COLOR_DEFAULT}
    echo "nohup psql -X -c \"update pgbench_accounts set filler = 'bbb'\" zheap &"
    echo "ls -la /var/tmp/undo/PG_12_201904072/undo/*"
    echo "done"
    echo -e ${COLOR_DEFAULT}
    _wait_for_next_step "Fire update?"
    nohup psql -X -c "update pgbench_accounts set filler = 'bbb'" zheap &
    for i in {1..6}; do
         ls -la /var/tmp/undo/PG_12_201904072/undo/*
         sleep 2
         clear
    done
    _wait_for_next_step "The downside of writing undo is?"
    _wait_for_next_step "Writing undo takes time, so bulk loads are slower with zheap"
    echo " "
    echo "create table theap (a int, b text) using heap"
    echo "create table tzheap (a int, b text) using zheap"
    echo "\\timing"
    echo "insert into theap select a, md5(a::text) from generate_series(1,3000000) a"
    echo "insert into ztheap select a, md5(a::text) from generate_series(1,3000000) a"
    _wait_for_next_step "Ready?"
    psql -X -c "drop table if exists theap" heap > /dev/null 2>&1
    psql -X -c "drop table if exists tzheap" zheap > /dev/null 2>&1
    psql -X -c "create table theap ( a int, b text) using heap" heap
    psql -X -c "create table tzheap ( a int, b text) using zheap" zheap
    psql -c "insert into theap select a, md5(a::text) from generate_series(1,3000000) a" heap
    psql -c "insert into tzheap select a, md5(a::text) from generate_series(1,3000000) a" zheap
    _wait_for_next_step "Do you spot the difference?"
    _wait_for_next_step "Where is it better then?"
    clear
    _wait_for_next_step "On update heavy workloads"
    echo "pgbench -b simple-update -T 15 heap"
    echo "pgbench -b simple-update -T 15 zheap"
    _wait_for_next_step "A simple-update pgbench run for 15 seconds against both databases"
    echo " =================> heap tables"
    echo " ================================================="
    pgbench -b simple-update -T 15 heap
    echo " =================> zheap tables"
    echo " ================================================="
    pgbench -b simple-update -T 15 zheap
    _wait_for_next_step "There is definitely an improvement in zheap"
    clear
    _wait_for_next_step "Some results from a \"real\" test against a Huawei all flash system (https://e.huawei.com/uk/products/cloud-computing-dc/storage/unified-storage/dorado-v3)"
    echo " "
    echo " =================> heap tables"
    echo " ================================================="
    echo " [postgres@host0 pg_log]$ pgbench -c 100 -j 100 -P 300 -T 900 -b simple-update heap"
    echo " starting vacuum...end."
    echo " progress: 300.0 s, 34786.8 tps, lat 2.874 ms stddev 2.137"
    echo " progress: 600.0 s, 36869.0 tps, lat 2.712 ms stddev 2.059"
    echo " progress: 900.0 s, 37672.8 tps, lat 2.654 ms stddev 1.919"
    echo " transaction type: <builtin: simple update>"
    echo " scaling factor: 10000"
    echo " query mode: simple"
    echo " number of clients: 100"
    echo " number of threads: 100"
    echo " duration: 900 s"
    echo " number of transactions actually processed: 32798695"
    echo " latency average = 2.744 ms"
    echo " latency stddev = 2.040 ms"
    echo " tps = 36441.858195 (including connections establishing)"
    echo " tps = 36442.915876 (excluding connections establishing)"
    echo " "
    echo " =================> zheap tables"
    echo " ================================================="
    echo " [postgres@host0 pg_log]$ pgbench -c 100 -j 100 -P 300 -T 900 -b simple-update zheap"
    echo " starting vacuum...end."
    echo " progress: 300.0 s, 34812.9 tps, lat 2.872 ms stddev 2.132"
    echo " progress: 600.0 s, 36915.6 tps, lat 2.709 ms stddev 2.005"
    echo " progress: 900.0 s, 37800.7 tps, lat 2.645 ms stddev 1.881"
    echo " transaction type: <builtin: simple update>"
    echo " scaling factor: 10000"
    echo " query mode: simple"
    echo " number of clients: 100"
    echo " number of threads: 100"
    echo " duration: 900 s"
    echo " number of transactions actually processed: 32858872"
    echo " latency average = 2.739 ms"
    echo " latency stddev = 2.007 ms"
    echo " tps = 36508.980825 (including connections establishing)"
    echo " tps = 36509.985367 (excluding connections establishing)"
    _wait_for_next_step "still better but consumes much less space"
    clear
    echo -e ${COLOR_DEFAULT}
    echo "There is also a catalog view which lists the current undo files"
    echo " "
    echo "nohup psql -X -c \"update pgbench_accounts set filler = 'ccc'\" zheap &"
    cat /home/postgres/zheap_demo/pg_stat_undo_logs.sql
    nohup psql -X -c \"update pgbench_accounts set filler = 'ccc'\" heap &
    psql -X -f /home/postgres/zheap_demo/pg_stat_undo_logs.sql zheap
    pg_ctl -D ${PGDATA} restart -m fast
    _wait_for_next_step "Nice, isn't it?"
    
}

function _who_writes_undo_and_who_discards {
    clear;
    echo -e ${COLOR_GREEN}
    echo "Who is writing the undo then and who is discarding undo"
    echo "once it is no longer required?"
    echo "Do you remember one of the major new features in PostgreSQL 9.4?"
    echo " "
    _wait_for_next_step "Background workers, right?"
    echo "The same infrastructure is used here:"
    echo -e ${COLOR_DEFAULT}
    echo "ps -ef | egrep \"undo|discard\""
    ps -ef | egrep "undo|discard"
    echo " "
    echo " "
    echo -e ${COLOR_GREEN}
    echo "The discard worker discards all undo segments no longer required"
    echo "The undo launcher launches worker processes to perform the undo (one per database)"
    echo "Each backend is attached to a separate undo log to which it writes undo records."
    echo -e ${COLOR_DEFAULT}
    _wait_for_next_step "Next?"
}

# do we lose instant commit and rollback?
function _do_we_lose_instant_commit_and_rollback {
    clear;
    echo -e ${COLOR_GREEN}
    echo "With heap we have instant commit and rollback. Everybody is aware of that? "
    echo " "
    echo "Consider this:"
    echo -e ${COLOR_DEFAULT}
    echo "create table dummy (a int, b text) using zheap;"
    echo "begin;"
    echo "insert into dummy select i,i::text from generate_series(1,1000000) i;"
    echo "rollback;"
    _wait_for_next_step "How long would the rollback take with traditional heap?"
    _wait_for_next_step "It would be instant, right?"
    _wait_for_next_step "What happens in case of zheap?"
    _wait_for_next_step "Undo needs to be applied, which takes time, do you agree?"
    _wait_for_next_step "So we will loose instant rollback? Lets see"
    clear
    echo -e ${COLOR_DEFAULT}
    echo "cat /home/postgres/zheap_demo/rollback_zheap.sql"   
    echo "psql -X -f /home/postgres/zheap_demo/rollback_zheap.sql zheap"
    cat /home/postgres/zheap_demo/rollback_zheap.sql
    _wait_for_next_step "Go?"
    psql -X -f /home/postgres/zheap_demo/rollback_zheap.sql zheap
    _wait_for_next_step "Why is it so fast?"
    clear
    echo "When the size of the rollback segment exceeds a user define size"
    echo "the rollback is executed in the background asynchronously"
    _wait_for_next_step "The parameter to control this is:"
    echo "psql -X -c \"show rollback_overflow_size\" zheap"
    echo " "
    psql -X -c "show rollback_overflow_size" zheap
    echo " "
    _wait_for_next_step "So you can control that, what is great"
    echo -e ${COLOR_RED}
    _wait_for_next_step "BUT"
    _wait_for_next_step "... there is a case when this is not working"
    _wait_for_next_step "Ideas?"
    clear
    echo -e ${COLOR_GREEN}
    _wait_for_next_step "What about savepoints?"
    cat /home/postgres/zheap_demo/savepoints.sql
    echo "psql -X -f /home/postgres/zheap_demo/savepoints.sql"
    _wait_for_next_step "Ready?"
    echo -e ${COLOR_DEFAULT}
    psql -X -f /home/postgres/zheap_demo/savepoints.sql zheap
    echo -e ${COLOR_GREEN}
    _wait_for_next_step "Why is that?" 
    _wait_for_next_step "Rollback to savepoint is always performed in the foreground" 
    echo "Answer from Amit to this question: We always perform Rollback To Savepoint in the foreground.  If we give
it to background, then it won't be able to rewind the undo location as
by that time more operations have been performed."
    _wait_for_next_step "Thank you Amit for always having responded to my questions!"
}

function _when_do_we_see_bloat {
    clear;
    echo -e ${COLOR_GREEN}
    echo "Are there cases when we would still see bloat?"
    echo "That would only be the case when no inplace update can be performed, correct?"
    echo " "
    _wait_for_next_step "How can we detect bloat?"
    _wait_for_next_step "A simple demo table:"
    echo "drop table if exists bloat_test"
    echo "create table bloat_test ( a int, b text ) using zheap with (fillfactor=100);"
    echo "insert into bloat_test select a,a::text from generate_series(1,1000000) a;"
    echo "vacuum bloat_test;"
    psql -X -c "drop table if exists bloat_test" zheap
    psql -X -c "create table bloat_test ( a int, b text ) using zheap with (fillfactor=100)" zheap
    psql -X -c "insert into bloat_test select a,a::text from generate_series(1,1000000) a" zheap
    psql -X -c "vacuum bloat_test" zheap
    _wait_for_next_step "Detecting bloat:"
    echo "select relname,n_live_tup, n_dead_tup from pg_stat_user_tables where relname = 'bloat_test';"
    echo "or ...."
    echo "select ctid,* from bloat_test where a < 6;"
    _wait_for_next_step "Lets see if we have bloat right now"
    psql -X -c "select relname,n_live_tup, n_dead_tup from pg_stat_user_tables where relname = 'bloat_test'" zheap 
    psql -X -c "select ctid,* from bloat_test where a < 6" zheap
    _wait_for_next_step "No dead rows, all first 5 rows in the first block"
    clear
    echo " "
    echo "update bloat_test set b = lpad('d',1000,'d') where a < 6;" 
    _wait_for_next_step "What happens when we do this?"
    psql -X -c "update bloat_test set b = lpad('d',1000,'d') where a < 6" zheap
    psql -X -c "select relname,n_live_tup, n_dead_tup from pg_stat_user_tables where relname = 'bloat_test'" zheap 
    psql -X -c "select ctid,* from bloat_test where a < 6" zheap
    _wait_for_next_step "Here we have it. When updates do not fit in the same location there still will be bloat"
}

function _a_few_words_about_pluggable_storage {
    clear;
    echo "Implementing a different storage format, such as zheap, would not be possible without?"
    echo " "
    _wait_for_next_step "Quite a few patches are already committed to PostgreSQL 12, any idea"
    echo " "
    echo -e "postgres@pgbox:/home/postgres/postgresql/ [ZHEAP] ${COLOR_RED} git log | grep pluggable${COLOR_DEFAULT}"
    echo -e "For the upcoming ${COLOR_BLUE}pluggable table access methods${COLOR_DEFAULT} it's quite"
    echo -e "${COLOR_BLUE}pluggable storage work${COLOR_DEFAULT}, it therefore makes sense to move it into"
    echo -e "snapmgr.h or heapam.h, which in turn is in preparation for ${COLOR_BLUE}pluggable${COLOR_DEFAULT}"
    echo -e "${COLOR_BLUE}pluggable storage${COLOR_DEFAULT} work we're introducing a layer between table"
    echo -e "pronounced with the upcoming introduction of ${COLOR_BLUE}pluggable storage${COLOR_DEFAULT}."
    echo -e "causes problems for the ${COLOR_BLUE}upcoming pluggable storage work${COLOR_DEFAULT}, because the"
    echo -e "problematic with the upcoming introduction of ${COLOR_BLUR}pluggable table storage${COLOR_DEFAULT}"
    echo -e "${COLOR_BLUR}table storage pluggable${COLOR_DEFAULT}, would have required expanding and duplicating"
    echo -e "making tuple table slots extensible, to allow for ${COLOR_BLUE}pluggable table${COLOR_DEFAULT}"
    echo -e "through the slot abstraction, that'll be repaired once the ${COLOR_BLUE}pluggable${COLOR_DEFAULT}"
    echo -e "Upcoming work intends to allow ${COLOR_BLUE}pluggable ways${COLOR_DEFAULT} to introduce new ways of"
    echo -e "preparation of making table ${COLOR_BLUE}storage pluggable${COLOR_DEFAULT}. New storage methods"
    echo -e "as ${COLOR_BLUE}pluggable modules${COLOR_DEFAULT} in the future, which this patch makes easier, though for"
    echo " "
    _wait_for_next_step "Pluggable everywhere :)"
}

function _conclusion {
    clear
    cowsay -f /usr/share/cowsay/vader-koala.cow pluggable storage is great work
    _wait_for_next_step "Pluggable storage opens doors for new storage implementations"
    clear
    cowsay -f /usr/share/cowsay/elephant.cow ... such as zheap
    _wait_for_next_step "zheap is the first implementation of a new storage format"
    clear
    cowsay -f /usr/share/cowsay/kiss.cow zheap and heap will love each other
    _wait_for_next_step "the great thing is that you can mix heap and zheap tables"
    clear
    _wait_for_next_step "the first additional implementation POC already showed up on the hackers list"
    echo "From: Ashwin Agrawal <aagrawal@pivotal.io>
Sent: Tuesday, April 9, 2019 02:27
To: PostgreSQL mailing lists
Subject: Zedstore - compressed in-core columnar storage"
echo " "
    echo "----------------------------------------------"
    echo "Heikki and I have been hacking recently for few weeks to implement
in-core columnar storage for PostgreSQL. Here's the design and initial
implementation of Zedstore, compressed in-core columnar storage (table
access method). Attaching the patch and link to github branch [1] to
follow along."
    _wait_for_next_step "How cool is that?"
    clear
    cowsay -f /usr/share/cowsay/cheese.cow Thank you for your attention
    _wait_for_next_step "Questions welcome (as long as I can answer them)"
    clear
    _title 1
}

# we are ready, lets start
_title
# who we are
_dbi
# print the little howto on how to create this demo setup
_zheap_setup_info
# print the disclaimer
_disclaimer
# setup a database which contains only heap tables
_setup_heap_datbase
# setup a databasw which contains only zheap tables
_setup_zheap_database
# compare heap and zheap tables
_compare_heap_and_zheap_space_consumption
# compare the row headers
_compare_row_headers
# what is bloat?
_what_is_bloat
# what happens in the background
_what_happens_in_the_background
# who writes the undo files and who dicards them?
_who_writes_undo_and_who_discards
# instant commit and rollback
_do_we_lose_instant_commit_and_rollback
# when do we still see bloat?
_when_do_we_see_bloat
## a few words about pluggable storage
_a_few_words_about_pluggable_storage
## conclusion and questions
_conclusion
