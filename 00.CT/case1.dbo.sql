--liquibase formatted sql

--changeset Emiliano:13
create table users(
  name varchar(30),
  keys  varchar(10)
)