start transaction;
INSERT INTO public.reg_message_route (id_bot, id_messenger, id_event_type, id_target_system, id_user)
    VALUES (
            (select uuid from cls_bot where code = 'BOT_1' limit 1),
            (select id_messenger from cls_bot where code = 'BOT_1' limit 1),
            (select uuid from cls_event_type where code = 'EVENT_1' limit 1),
            (select id_target_system from cls_event_type where code = 'EVENT_1' limit 1),
            (select uuid from cls_user where code = 'USER1' limit 1)
        ),
        (
            (select uuid from cls_bot where code = 'BOT_2' limit 1),
            (select id_messenger from cls_bot where code = 'BOT_2' limit 1),
            (select uuid from cls_event_type where code = 'EVENT_2' limit 1),
            (select id_target_system from cls_event_type where code = 'EVENT_2' limit 1),
            (select uuid from cls_user where code = 'USER1' limit 1)
        ),
        (
            (select uuid from cls_bot where code = 'BOT_1' limit 1),
            (select id_messenger from cls_bot where code = 'BOT_1' limit 1),
            (select uuid from cls_event_type where code = 'EVENT_2' limit 1),
            (select id_target_system from cls_event_type where code = 'EVENT_2' limit 1),
            (select uuid from cls_user where code = 'USER1' limit 1)
        ),
        (
            (select uuid from cls_bot where code = 'BOT_2' limit 1),
            (select id_messenger from cls_bot where code = 'BOT_2' limit 1),
            (select uuid from cls_event_type where code = 'EVENT_1' limit 1),
            (select id_target_system from cls_event_type where code = 'EVENT_1' limit 1),
            (select uuid from cls_user where code = 'USER1' limit 1)
        );

INSERT INTO public.reg_incom_request (id_bot, id_messenger, id_event_type, id_target_system, id_user, status)
    VALUES (
            (select uuid from cls_bot where code = 'BOT_1' limit 1),
            (select id_messenger from cls_bot where code = 'BOT_1' limit 1),
            (select uuid from cls_event_type where code = 'EVENT_1' limit 1),
            (select id_target_system from cls_event_type where code = 'EVENT_1' limit 1),
            (select uuid from cls_user where code = 'USER1' limit 1), 0
        ),
        (
            (select uuid from cls_bot where code = 'BOT_2' limit 1),
            (select id_messenger from cls_bot where code = 'BOT_2' limit 1),
            (select uuid from cls_event_type where code = 'EVENT_2' limit 1),
            (select id_target_system from cls_event_type where code = 'EVENT_2' limit 1),
            (select uuid from cls_user where code = 'USER1' limit 1), 1
        ),
        (
            (select uuid from cls_bot where code = 'BOT_1' limit 1),
            (select id_messenger from cls_bot where code = 'BOT_1' limit 1),
            (select uuid from cls_event_type where code = 'EVENT_2' limit 1),
            (select id_target_system from cls_event_type where code = 'EVENT_2' limit 1),
            (select uuid from cls_user where code = 'USER1' limit 1), 2
        ),
        (
            (select uuid from cls_bot where code = 'BOT_2' limit 1),
            (select id_messenger from cls_bot where code = 'BOT_2' limit 1),
            (select uuid from cls_event_type where code = 'EVENT_1' limit 1),
            (select id_target_system from cls_event_type where code = 'EVENT_1' limit 1),
            (select uuid from cls_user where code = 'USER1' limit 1), 3
        ),
        (
            (select uuid from cls_bot where code = 'BOT_1' limit 1),
            (select id_messenger from cls_bot where code = 'BOT_1' limit 1),
            (select uuid from cls_event_type where code = 'EVENT_1' limit 1),
            (select id_target_system from cls_event_type where code = 'EVENT_1' limit 1),
            (select uuid from cls_user where code = 'USER1' limit 1), 3
        ),
        (
            (select uuid from cls_bot where code = 'BOT_2' limit 1),
            (select id_messenger from cls_bot where code = 'BOT_2' limit 1),
            (select uuid from cls_event_type where code = 'EVENT_2' limit 1),
            (select id_target_system from cls_event_type where code = 'EVENT_2' limit 1),
            (select uuid from cls_user where code = 'USER1' limit 1), 2
        ),
        (
            (select uuid from cls_bot where code = 'BOT_1' limit 1),
            (select id_messenger from cls_bot where code = 'BOT_1' limit 1),
            (select uuid from cls_event_type where code = 'EVENT_2' limit 1),
            (select id_target_system from cls_event_type where code = 'EVENT_2' limit 1),
            (select uuid from cls_user where code = 'USER1' limit 1), 1
        ),
        (
            (select uuid from cls_bot where code = 'BOT_2' limit 1),
            (select id_messenger from cls_bot where code = 'BOT_2' limit 1),
            (select uuid from cls_event_type where code = 'EVENT_1' limit 1),
            (select id_target_system from cls_event_type where code = 'EVENT_1' limit 1),
            (select uuid from cls_user where code = 'USER1' limit 1), 0
        );
COMMIT;