#!/usr/bin/env bash

PARAMS="-u ${MYSQL_USER:-root}"
[[ -z "$MYSQL_PASS" ]] || PARAMS="$PARAMS -P '${MYSQL_PASS}'"
[[ -z "$MYSQL_ASK_PASS" ]] || PARAMS="$PARAMS -p"

mysql $PARAMS -e "drop database if exists blog_test"
mysql $PARAMS -e "create database blog_test"
mysql $PARAMS -e "create user 'blog_user'@'localhost'"
mysql $PARAMS -e "grant all on blog_test.* to 'blog_user'@'localhost'"
