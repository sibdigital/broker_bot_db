start transaction;
INSERT INTO public.cls_target_system (code, name) VALUES ('TARGET1', 'Целевая система 1');
INSERT INTO public.cls_target_system (code, name) VALUES ('TARGET2', 'Целевая система 2');

INSERT INTO public.cls_messenger (code, name) VALUES ('TELEGRAM', 'Телеграм');
INSERT INTO public.cls_messenger (code, name) VALUES ('VIBER', 'Вайбер');

INSERT INTO public.cls_event_type (code, name, id_target_system) VALUES ('EVENT_1', 'Тип события целевой системы 1',
                                                                            (select uuid from cls_target_system where code = 'TARGET1' limit 1));
INSERT INTO public.cls_event_type (code, name, id_target_system) VALUES ('EVENT_2', 'Тип события целевой системы 2',
                                                                            (select uuid from cls_target_system where code = 'TARGET2' limit 1));

INSERT INTO public.cls_event_type (code, name, id_target_system) VALUES ('REQUEST_1', 'Запрос целевой системы 2',
                                                                            (select uuid from cls_target_system where code = 'TARGET2' limit 1));

INSERT INTO public.cls_event_type (code, name, id_target_system, id_parent) VALUES ('REQUEST_2', 'Запрос вложенный целевой системы 2',
                                                                                       (select uuid from cls_target_system where code = 'TARGET2' limit 1),
                                                                                       (select uuid from cls_event_type where code = 'REQUEST_1' limit 1));

INSERT INTO public.cls_bot (code, name, id_messenger)
    VALUES ('BOT_1', 'Бот 1',
             (select uuid from cls_messenger where code = 'TELEGRAM' limit 1));

INSERT INTO public.cls_bot (code, name, id_messenger)
    VALUES ('BOT_2', 'Бот 2',
             (select uuid from cls_messenger where code = 'VIBER' limit 1));
COMMIT;