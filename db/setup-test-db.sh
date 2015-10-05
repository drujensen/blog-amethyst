#!/usr/bin/env bash

PARAMS="-u ${MYSQL_USER:-root}"
[[ -z "$MYSQL_PASS" ]] || PARAMS="$PARAMS -P '${MYSQL_PASS}'"
[[ -z "$MYSQL_ASK_PASS" ]] || PARAMS="$PARAMS -p"

mysql $PARAMS -e "drop database if exists blog"
mysql $PARAMS -e "create database blog"
mysql $PARAMS -e "create user 'admin'@'localhost'"
mysql $PARAMS -e "grant all on blog.* to 'admin'@'localhost'"
