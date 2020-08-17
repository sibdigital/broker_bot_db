start transaction;
INSERT INTO public.reg_target_system_user (id_target_system, outer_id, login, firstname, lastname, email)
    VALUES (
            (select uuid from cls_target_system where code = 'TARGET1' limit 1),
            'login1', 'login1', 'first name', 'last name', 'test@test.ru'
        );

INSERT INTO public.cls_user (code, login, firstname, lastname, email, identificator)
    select 'USER1', login, firstname, lastname, email, 'USER1_IDENT'
    from reg_target_system_user as tsu where tsu.email = 'test@test.ru'
;

INSERT INTO public.reg_messenger_user (id_messenger, id_user, outer_id)
    VALUES (
            (select uuid from cls_messenger where code = 'TELEGRAM' limit 1),
            (select uuid from cls_user where code = 'USER1' limit 1),
            'login1_messenger'
        );
COMMIT;