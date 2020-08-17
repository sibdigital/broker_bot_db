start transaction;
INSERT INTO public.REG_SENT_MESSAGE (id_event_type, id_target_system, id_user, text, status, id_incom_request)
    VALUES (
            (select uuid from cls_event_type where code = 'EVENT_1' limit 1),
            (select id_target_system from cls_event_type where code = 'EVENT_1' limit 1),
            (select uuid from cls_user where code = 'USER1' limit 1),
            'текст сообщения 1',
            0,
            null
        ),
        (
            (select uuid from cls_event_type where code = 'EVENT_2' limit 1),
            (select id_target_system from cls_event_type where code = 'EVENT_2' limit 1),
            (select uuid from cls_user where code = 'USER1' limit 1),
            'текст сообщения 2',
            0,
            null
        ),
        (
            (select uuid from cls_event_type where code = 'EVENT_1' limit 1),
            (select id_target_system from cls_event_type where code = 'EVENT_1' limit 1),
            (select uuid from cls_user where code = 'USER1' limit 1),
            'текст сообщения 3',
            0,
            null
        ),
        (
            (select uuid from cls_event_type where code = 'EVENT_2' limit 1),
            (select id_target_system from cls_event_type where code = 'EVENT_2' limit 1),
            (select uuid from cls_user where code = 'USER1' limit 1),
            'текст сообщения 4',
            0,
            null
        ),
        (
            (select uuid from cls_event_type where code = 'EVENT_1' limit 1),
            (select id_target_system from cls_event_type where code = 'EVENT_1' limit 1),
            (select uuid from cls_user where code = 'USER1' limit 1),
            'текст сообщения 5',
            1,
            null
        ),
        (
            (select uuid from cls_event_type where code = 'EVENT_2' limit 1),
            (select id_target_system from cls_event_type where code = 'EVENT_2' limit 1),
            (select uuid from cls_user where code = 'USER1' limit 1),
            'текст сообщения 6',
            1,
            null
        ),
        (
            (select uuid from cls_event_type where code = 'EVENT_1' limit 1),
            (select id_target_system from cls_event_type where code = 'EVENT_1' limit 1),
            (select uuid from cls_user where code = 'USER1' limit 1),
            'текст сообщения 7',
            2,
            null
        ),
        (
            (select uuid from cls_event_type where code = 'EVENT_2' limit 1),
            (select id_target_system from cls_event_type where code = 'EVENT_2' limit 1),
            (select uuid from cls_user where code = 'USER1' limit 1),
            'текст сообщения 8',
            3,
            null
        ),
        (
            (select uuid from cls_event_type where code = 'EVENT_2' limit 1),
            (select id_target_system from cls_event_type where code = 'EVENT_2' limit 1),
            (select uuid from cls_user where code = 'USER1' limit 1),
            'текст сообщения 9',
            0,
            (select uuid from reg_incom_request where status = 0 limit 1)
        ),
         (
            (select uuid from cls_event_type where code = 'EVENT_1' limit 1),
            (select id_target_system from cls_event_type where code = 'EVENT_1' limit 1),
            (select uuid from cls_user where code = 'USER1' limit 1),
            'текст сообщения 10',
            1,
            (select uuid from reg_incom_request where status = 1 limit 1)
        );
COMMIT;