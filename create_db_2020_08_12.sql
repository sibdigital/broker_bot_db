--create database brbo;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

--Справочник «Целевые системы» (CLS_TARGET_SYSTEM).
-- В справочнике содержатся данные о тех системах, сообщения от которых будут идти в боты или которые будут отвечать на запросы
create table CLS_TARGET_SYSTEM
(
    UUID uuid not null DEFAULT uuid_generate_v1() constraint CLS_TARGET_SYSTEM_pkey primary key,
    code varchar(15),
    name text,
    date_create timestamp not null default current_timestamp,
    is_deleted boolean not null default false
)
;

--Справочник «Типы событий» (CLS_EVENT_TYPE).
-- События целевых систем, по которым будут приходить уведомления.
create table CLS_EVENT_TYPE
(
    UUID uuid not null DEFAULT uuid_generate_v1() constraint CLS_EVENT_TYPE_pkey primary key,
    code varchar(15),
    name text,
    date_create timestamp not null default current_timestamp,
    is_deleted boolean not null default false,
    Id_target_system uuid 		constraint CLS_EVENT_TYPE_CLS_TARGET_SYSTEM_uuid_fk references CLS_TARGET_SYSTEM not null,
    Id_parent uuid  constraint CLS_EVENT_TYPE_CLS_EVENT_TYPE_uuid_fk references CLS_EVENT_TYPE,
    type integer not null default 0
)
;
--Справочник «Мессенджеры» (CLS_MESSENGER).
-- Справочник доступных в системе мессенджеров
create table CLS_MESSENGER
(
    UUID uuid not null DEFAULT uuid_generate_v1() constraint CLS_MESSENGER_pkey primary key,
    code varchar(15),
    name text,
    date_create timestamp not null default current_timestamp,
    is_deleted boolean not null default false
)
;
--Справочник «Пользователи» (CLS_USER).
-- Пользователи брокер-бота с учетом соответствия пользователям целевых систем и мессенджеров
create table CLS_USER
(
    UUID uuid not null DEFAULT uuid_generate_v1() constraint CLS_USER_pkey primary key,
    code varchar(15),
    date_create timestamp not null default current_timestamp,
    is_deleted boolean not null default false,
    login text,
    firstname text,
    lastname text,
    patronymic text,
    email text,
    identificator varchar(32)
)
;
--Справочник «Боты» (CLS_BOT).
-- Справочник доступных в системе ботов и настроек, необходимых для отправки им сообщений
create table CLS_BOT
(
    UUID uuid not null DEFAULT uuid_generate_v1() constraint CLS_BOT_pkey primary key,
    code varchar(15),
    name text,
    date_create timestamp not null default current_timestamp,
    is_deleted boolean not null default false,
    Id_messenger uuid constraint CLS_BOT_CLS_MESSENGER_uuid_fk references CLS_MESSENGER not null,
    settings jsonb
)
;
--Регистр «Пользователи целевых систем» (REG_TARGET_SYSTEM_USER).
-- Соответствие пользователя брокер-бота пользователям целевых систем.
create table REG_TARGET_SYSTEM_USER
(
    UUID uuid not null DEFAULT uuid_generate_v1() constraint REG_TARGET_SYSTEM_USER_pkey primary key,
    date_create timestamp not null default current_timestamp,
    is_deleted boolean not null default false,
    Id_target_system uuid constraint REG_TARGET_SYSTEM_USER_CLS_TARGET_SYSTEM_uuid_fk references CLS_TARGET_SYSTEM not null,
    Id_user uuid constraint REG_TARGET_SYSTEM_USER_CLS_USER_uuid_fk references CLS_USER,
    Outer_id text,
    login text,
    firstname text,
    lastname text,
    patronymic text,
    email text
)
;
--Регистр «Пользователи мессенджеров» (REG_MESSENGER_USER).
-- Соответствие пользователя брокер-бота пользователям мессенджеров.
create table REG_MESSENGER_USER
(
    UUID uuid not null DEFAULT uuid_generate_v1() constraint REG_MESSENGER_USER_pkey primary key,
    date_create timestamp not null default current_timestamp,
    is_deleted boolean not null default false,
    Id_messenger uuid constraint REG_MESSENGER_USER_CLS_MESSENGER_uuid_fk references CLS_MESSENGER not null,
    Id_user uuid constraint REG_MESSENGER_USER_CLS_USER_uuid_fk references CLS_USER,
    Outer_id text,
    settings jsonb
)
;
--Регистр «Маршруты» (REG_MESSAGE_ROUTE).
-- Описание того, какие пользователи каких целевых систем получают определенные типы сообщений в определенные мессенджеры
create table REG_MESSAGE_ROUTE
(
    UUID uuid not null DEFAULT uuid_generate_v1() constraint REG_MESSAGE_ROUTE_pkey primary key,
    date_create timestamp not null default current_timestamp,
    is_deleted boolean not null default false,
    date_activation timestamp,
    Id_bot uuid constraint REG_MESSAGE_ROUTE_CLS_BOT_uuid_fk references CLS_BOT not null,
    Id_messenger uuid constraint REG_MESSAGE_ROUTE_CLS_MESSENGER_uuid_fk references CLS_MESSENGER not null,
    Id_event_type uuid constraint REG_MESSAGE_ROUTE_CLS_EVENT_TYPE_uuid_fk references CLS_EVENT_TYPE not null,
    Id_target_system uuid constraint REG_MESSAGE_ROUTE_CLS_TARGET_SYSTEM_uuid_fk references CLS_TARGET_SYSTEM not null,
    Id_user uuid constraint REG_MESSAGE_ROUTE_CLS_USER_uuid_fk references CLS_USER
)
;
--Регистр «Поступающие запросы» (REG_INCOM_REQUEST).
-- Запросы от пользователей ботов к целевым системам
create table REG_INCOM_REQUEST
(
    UUID uuid not null DEFAULT uuid_generate_v1()  constraint REG_INCOM_REQUEST_pkey primary key,
    date_create timestamp not null default current_timestamp,
    Id_bot uuid constraint REG_INCOM_REQUEST_CLS_BOT_uuid_fk references CLS_BOT not null,
    Id_messenger uuid constraint REG_INCOM_REQUEST_CLS_MESSENGER_uuid_fk references CLS_MESSENGER not null,
    Id_event_type uuid constraint RREG_INCOM_REQUEST_CLS_EVENT_TYPE_uuid_fk references CLS_EVENT_TYPE not null,
    Id_target_system uuid constraint REG_INCOM_REQUEST_CLS_TARGET_SYSTEM_uuid_fk references CLS_TARGET_SYSTEM not null,
    Id_user uuid constraint REG_INCOM_REQUEST_CLS_USER_uuid_fk references CLS_USER,
    status integer
)
;
--Регистр «Отправляемые сообщения» (REG_SENT_MESSAGE).
-- - Сообщения, генерируемые целевыми системами для отправки.
create table REG_SENT_MESSAGE
(
    UUID uuid not null DEFAULT uuid_generate_v1() constraint REG_SENT_MESSAGE_pkey primary key,
    date_create timestamp not null default current_timestamp,
    Id_event_type uuid constraint REG_SENT_MESSAGE_CLS_EVENT_TYPE_uuid_fk references CLS_EVENT_TYPE not null,
    Id_target_system uuid constraint REG_SENT_MESSAGE_CLS_TARGET_SYSTEM_uuid_fk references CLS_TARGET_SYSTEM not null,
    Id_user uuid constraint REG_SENT_MESSAGEE_CLS_USER_uuid_fk references CLS_USER,
    text text,
    status integer,
    Attached_file text,
    Attached_file_type varchar(10),
    Attached_file_size integer,
    Attached_file_hash text,
    id_incom_request uuid constraint REG_SENT_MESSAGE_REG_INCOM_REQUEST_uuid_fk references REG_INCOM_REQUEST,
    settings jsonb
)
;

create or replace view V_MESSENGER_USER_MESSAGE_ROUTE as (
    select *
    from (
             select mr.id_bot,
                    mr.id_messenger,
                    mr.id_event_type,
                    mr.id_target_system,
                    (select id_parent
                     from cls_event_type as et
                     where et.uuid = mr.id_event_type) as id_parent_event_type,
                    mr.id_user                         as id_user
             FROM reg_message_route as mr
             where mr.is_deleted = false
               and not mr.date_activation is null
         ) as mr
             inner join (select id_user  as id_user,
                                outer_id,
                                settings as user_settings
                         from reg_messenger_user as mu
                         where mu.is_deleted = false
    ) as mu
                        using (id_user)
             inner join(
        select uuid     as id_bot,
               name     as bot_name,
               settings as bot_settings
        from cls_bot as b
        where is_deleted = false
    ) as b
                       using (id_bot)
)
;
--Правки таблиц в ходе разработки
alter table cls_event_type alter column code type varchar(25) using code::varchar(25)
;
alter table reg_incom_request add request_body text
;
