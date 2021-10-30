
-- Наполнение
USE Parking_system;

insert into parking_zone (zone_name)
VALUES  ('full parking');
insert into parking_zone (zone_name)
VALUES ('indoor parking');
insert into parking_zone (zone_name)
VALUES ('outdoor parking');

insert into type_devices (type_devices)
VALUES ('entry');
insert into type_devices (type_devices)
VALUES ('exit');
insert into type_devices (type_devices)
VALUES ('payment_terminal');
insert into type_devices (type_devices)
VALUES ('server PC');
insert into type_devices (type_devices)
VALUES ('client PC');

insert into devices (id_type_device,number_device)
values (1,101);
insert into devices (id_type_device,number_device)
values (1,102);
insert into devices (id_type_device,number_device)
values (1,103);
insert into devices (id_type_device,number_device)
values (1,104);
insert into devices (id_type_device,number_device)
values (1,105);
insert into devices (id_type_device,number_device)
values (2,201);
insert into devices (id_type_device,number_device)
values (2,202);
insert into devices (id_type_device,number_device)
values (2,203);
insert into devices (id_type_device,number_device)
values (2,204);
insert into devices (id_type_device,number_device)
values (3,601);
insert into devices (id_type_device,number_device)
values (3,602);
insert into devices (id_type_device,number_device)
values (3,603);
insert into devices (id_type_device,number_device)
values (3,604);
insert into devices (id_type_device,number_device)
values (3,605);
insert into devices (id_type_device,number_device)
values (3,606);
insert into devices (id_type_device,number_device)
values (4,701);
insert into devices (id_type_device,number_device)
values (5,801);
insert into devices (id_type_device,number_device)
values (5,802);


insert into system_users (type_user,full_name,telephone_number)
values ('system admin','Иванов Иван Иванович', '8-999-999-99-99');
insert into system_users (type_user,full_name,telephone_number)
values ('technic','Петров Петр Петрович', '8-991-999-99-99');
insert into system_users (type_user,full_name,telephone_number)
values ('technic','Сидоров Петр Иванович', '8-991-955-95-59');
insert into system_users (type_user,full_name,telephone_number)
values ('technic','Смирнов Фёдор Иванович', '8-921-925-25-29');
insert into system_users (type_user,full_name,telephone_number)
values ('chaiser','Карпова Наталья Петровна', '8-991-355-35-53');
insert into system_users (type_user,full_name,telephone_number)
values ('chaiser','Романова Елена Фёдоровина', '8-991-235-45-49');


insert into sales (sales_name, sales_tariff)
values ('выходного дня','бесплатные выходные');
insert into sales (sales_name, sales_tariff)
values ('посетители ашана','бесплатно 2 часа');
insert into sales (sales_name, sales_tariff)
values ('посетители мойки','бесплатно 3 часа');
insert into sales (sales_name, sales_tariff)
values ('посетители фитнеса','бесплатно 5 часов');
insert into sales (sales_name, sales_tariff)
values ('посетители кинотеатра','скидка 50%');


insert into type_payment (name_payment)
value ('cash');
insert into type_payment (name_payment)
value ('bank card');
insert into type_payment (name_payment)
value ('payment by invoice');
insert into type_payment (name_payment)
value ('payment in the app');


insert into tariffs (tariff_name,tariff_price_ticket,id_parking_zone)
value ('бесплатный','бесплатно',1);
insert into tariffs (tariff_name,tariff_price_ticket,id_parking_zone)
value ('тариф буднего дня','2 часа бесплатно далее 100руб час',2);
insert into tariffs (tariff_name,tariff_price_ticket,id_parking_zone)
value ('тариф выходного дня','20 мин бесплатно далее 100руб час',2);
insert into tariffs (tariff_name,tariff_price_ticket,id_parking_zone)
value ('тариф ВИП','5 мин бесплатно далее 200руб час',3);

insert into tariffs (tariff_name,tariff_price_season_card ,id_parking_zone)
value ('физ лица','5000руб месяц',2);
insert into tariffs (tariff_name,tariff_price_season_card ,id_parking_zone)
value ('юр лица','7500руб месяц',2);
insert into tariffs (tariff_name,tariff_price_season_card ,id_parking_zone)
value ('служба эксплуатации','бесплатно',3);


insert into open_barrier (user_id,device_id)
value (2,6);
insert into open_barrier (user_id,device_id)
value (3,9);
insert into open_barrier (user_id,device_id)
value (4,5);
insert into open_barrier (user_id,device_id)
value (5,1);
insert into open_barrier (user_id,device_id)
value (3,4);
insert into open_barrier (user_id,device_id)
value (6,2);
insert into open_barrier (user_id,device_id)
value (5,3);
insert into open_barrier (user_id,device_id)
value (3,8);
insert into open_barrier (user_id,device_id)
value (2,3);
insert into open_barrier (user_id,device_id)
value (4,6);


insert into system_errors (device_id,type_errors,time_error,time_troubleshooting,user_id)
value (1,'поломка стрелы шлагбаума','2021-10-10 17:10:04','2021-10-10 19:52:04',2);
insert into system_errors (device_id,type_errors,time_error,time_troubleshooting,user_id)
value (12,'замятие фискальной ленты','2021-10-11 13:30:04','2021-10-11 13:52:04',5);
insert into system_errors (device_id,type_errors,time_error,time_troubleshooting,user_id)
value (15,'ошибка банковской оплаты','2021-10-11 23:30:04','2021-10-11 23:40:04',5);
insert into system_errors (device_id,type_errors,time_error,time_troubleshooting,user_id)
value (6,'застрял парковочный билет','2021-10-12 10:10:04','2021-10-12 10:23:04',3);
insert into system_errors (device_id,type_errors,time_error,time_troubleshooting,user_id)
value (3,'сбой питания 220 вольт','2021-10-14 21:30:04','2021-10-14 22:45:04',4);


insert into season_card_payments (payment_time,client_payment,contract_number,client_card,type_client,client_company_name,client_full_name,client_number_avto,tariff_id,time_start_contract,time_end_contract,id_type_payment,user_id)
value ('2021-09-25 17:10:04',7500,'№123А27ОТ','a4536bfe','company','ООО Ромашка','Иванов Иван','T234TT777',6,'2021-09-25 17:10:04','2021-10-25 17:10:04',2,5);
insert into season_card_payments (payment_time,client_payment,contract_number,client_card,type_client,client_full_name,client_number_avto,tariff_id,time_start_contract,time_end_contract,id_type_payment,user_id)
value ('2021-09-10 09:10:04',10000,'№47А2АВ22','a5566bac','human','Петр Сковоодкин','А654МР777',5,'2021-09-10 09:10:04','2021-11-10 09:10:04',1,6);


insert into entry_parking_transactions (entry_time,card_type,zone_id,device_id)
value ('2021-10-15 09:10:04','parking ticket',2,1);
insert into entry_parking_transactions (entry_time,card_type,zone_id,device_id)
value ('2021-10-15 09:40:04','parking ticket',2,3);
insert into entry_parking_transactions (entry_time,card_type,zone_id,device_id)
value ('2021-10-15 09:55:04','parking ticket',3,5);
insert into entry_parking_transactions (entry_time,card_type,zone_id,device_id)
value ('2021-10-15 10:25:04','parking ticket',3,5);
insert into entry_parking_transactions (entry_time,card_type,client_card_id,zone_id,device_id)
value ('2021-10-15 10:35:04','season card',1,2,2);
insert into entry_parking_transactions (entry_time,card_type,client_card_id,zone_id,device_id)
value ('2021-10-15 10:35:04','season card',2,3,5);


insert into exit_parking_transactions (exit_time,device_id,entry_info_id)
value ('2021-10-15 18:10:04',7,1);
insert into exit_parking_transactions (exit_time,device_id,entry_info_id)
value ('2021-10-15 18:30:04',8,2);
insert into exit_parking_transactions (exit_time,device_id,entry_info_id)
value ('2021-10-15 18:40:04',9,3);
insert into exit_parking_transactions (exit_time,device_id,entry_info_id)
value ('2021-10-15 18:45:04',9,4);
insert into exit_parking_transactions (exit_time,device_id,entry_info_id)
value ('2021-10-15 18:48:04',7,5);
insert into exit_parking_transactions (exit_time,device_id,entry_info_id)
value ('2021-10-15 18:50:04',9,6);

insert into parking_ticket_payments (payment_time,tariff_id,parking_time,client_payment,id_type_payment,device_id,entry_id)
value ('2021-10-15 18:00:04',2,'~ 9 часов','700',2,10,1);
insert into parking_ticket_payments (payment_time,tariff_id,parking_time,client_payment,id_type_payment,device_id,entry_id)
value ('2021-10-15 18:20:04',2,'~ 9 часов','700',1,12,2);
insert into parking_ticket_payments (payment_time,tariff_id,parking_time,client_payment,id_type_payment,device_id,entry_id)
value ('2021-10-15 18:25:04',4,'~ 9 часов','1400',2,14,3);
insert into parking_ticket_payments (payment_time,tariff_id,parking_time,client_payment,id_type_payment,device_id,entry_id)
value ('2021-10-15 18:30:04',4,'~ 9 часов','1400',1,15,4);