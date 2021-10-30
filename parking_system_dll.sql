-- Курсовой проект: модель базы данных АПС(автоматизированной парковочной системы) 
-- данная бд взаимодействует с программным обеспечение АПС (сервером системы АПС)



DROP DATABASE IF exists Parking_system;
CREATE DATABASE Parking_system;
USE Parking_system;

-- в таблицу записывается информация по въездам автомобилей, тут могут быть как обычные разовые билеты так и карты постоянных клиентов,
-- информация по устройству через которое въехал клиент, зону паркинга (общую,крытый паркинг, уличный паркинг)

DROP TABLE IF EXISTS entry_parking_transactions;
CREATE TABLE entry_parking_transactions (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	entry_time DATETIME default now(),
	card_type VARCHAR(30),
	CONSTRAINT card_type CHECK(card_type = 'parking ticket' or card_type = 'season card'),
	client_card_id  BIGINT unsigned default null,
	zone_id BIGINT UNSIGNED NOT NULL,
	device_id BIGINT unsigned NOT NULL
	);

-- в таблицу записывается информация по выездам автомобилей,устройству выезда, есть ссылка на въезд данного клиент,
-- при объединении первых четырех таблиц можно формировать транзакции парковочной сессии (въезд,оплата,выезд) 
 
DROP TABLE IF EXISTS exit_parking_transactions;
CREATE TABLE exit_parking_transactions (
	id serial,
	exit_time DATETIME default now(),
	device_id BIGINT unsigned NOT null,
	entry_info_id BIGINT unsigned NOT null
	);
	
-- таблица учета времени стоянки и оплат разовых клиентов паркинга

DROP TABLE IF exists parking_ticket_payments;
CREATE table parking_ticket_payments (
id serial,
payment_time DATETIME default now(),
tariff_id BIGINT UNSIGNED NOT NULL,
parking_time VARCHAR(30),
client_payment BIGINT UNSIGNED NOT null,
id_type_payment BIGINT UNSIGNED NOT NULL,
device_id BIGINT unsigned NOT null,
sales_id BIGINT unsigned default null,
entry_id BIGINT unsigned NOT null
);

-- таблица учета оплат постоянных клиентов паркинга

DROP TABLE IF exists season_card_payments;
CREATE table season_card_payments (
id serial,
payment_time DATETIME default now(),
client_payment BIGINT UNSIGNED NOT null,
contract_number VARCHAR(30) NOT null,
client_card VARCHAR(30) NOT null,
type_client VARCHAR(20),
constraint type_client CHECK(type_client = 'company' or type_client = 'human'),
client_company_name VARCHAR(50) default null,
client_full_name VARCHAR(100) NOT null,
client_number_avto VARCHAR(100) default null,
tariff_id BIGINT UNSIGNED NOT null,
time_start_contract datetime default null,
time_end_contract datetime default null,
id_type_payment BIGINT UNSIGNED NOT NULL,
user_id  BIGINT UNSIGNED NOT null -- пользователь (кассир) заключивший контракт
);

-- таблица типов оборудования паркинга (въедз,выезд,терминал оплаты,модулей скидки,клиентских пк,сервер)

DROP TABLE IF exists type_devices;
CREATE table  type_devices (
id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
type_devices VARCHAR(50) NOT null unique,
created_at DATETIME default now()
);

-- таблица самих устройств (у них своих номера 100е-въезд, 200е-выезд, 600е -кассы и тд) так принято в АПС)

DROP TABLE IF exists devices;
CREATE table devices (
id serial,
id_type_device BIGINT UNSIGNED NOT null,
number_device BIGINT UNSIGNED NOT null unique,
created_at DATETIME default now()
);

-- таблица тарифов для разовых и постоянных клиентов

DROP TABLE IF exists tariffs;
CREATE table tariffs (
id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
tariff_name VARCHAR(50) NOT null,
tariff_price_ticket VARCHAR(50) default null, -- цена за еденицу (час) 
tariff_price_season_card VARCHAR(50) default null, -- цена за еденицу (месяц) 
id_parking_zone BIGINT UNSIGNED NOT null,
created_at DATETIME default now()
);

-- таблица скидок

DROP TABLE IF exists sales;
CREATE table sales (
id serial,
sales_name VARCHAR(50) NOT null unique,
sales_tariff VARCHAR(50) NOT null,
created_at DATETIME default now()
);

-- таблица пользователей системы

DROP TABLE IF exists system_users;
CREATE table system_users (
id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
type_user VARCHAR(50) NOT null,
constraint type_user CHECK(type_user = 'technic' or type_user = 'system admin' or type_user = 'chaiser'), -- права доступа
full_name VARCHAR(100) NOT null unique,
telephone_number VARCHAR(50) default null unique,
created_at DATETIME default now()
);

-- таблица зон паркинга (крытый,закрыты, общий)

DROP TABLE IF exists parking_zone;
CREATE table parking_zone (
id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
zone_name VARCHAR(50) NOT null,
constraint zone_name CHECK(zone_name = 'full parking' or zone_name = 'indoor parking' or zone_name = 'outdoor parking' )
);

-- таблица неисправностей устройств и пользоватей которые их исправили

DROP TABLE IF exists system_errors;
CREATE table system_errors (
id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
device_id BIGINT unsigned NOT null,
type_errors VARCHAR(150) NOT null, -- система собирает логи ошибок со всех устройств 
time_error DATETIME default now(),
time_troubleshooting DATETIME default null,
user_id BIGINT UNSIGNED default null  -- какой пользователь устранил ошибку
);

-- таблица ручных открытий шлагбаума через клиентский софт

DROP TABLE IF exists open_barrier;
CREATE table open_barrier (
id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
user_id  BIGINT UNSIGNED NOT null,
device_id BIGINT unsigned NOT null,
time_to_open datetime default now()
);

-- таблица типов платежей( наличные,безналичные,счет)

DROP TABLE IF exists type_payment;
CREATE table type_payment (
id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name_payment VARCHAR(150) NOT null unique
);


-- Связываем таблицы

alter table entry_parking_transactions add constraint
foreign key (client_card_id) references season_card_payments(id);


alter table entry_parking_transactions add constraint
foreign key (zone_id) references parking_zone(id);

alter table entry_parking_transactions add constraint
foreign key (device_id) references devices(id);

alter table devices add constraint
foreign key (id_type_device) references type_devices(id);

alter table exit_parking_transactions add constraint
foreign key (entry_info_id) references entry_parking_transactions(id);

alter table parking_ticket_payments add constraint
foreign key (entry_id) references entry_parking_transactions(id);


alter table exit_parking_transactions add constraint
foreign key (device_id) references devices(id);

alter table exit_parking_transactions add constraint
foreign key (device_id) references devices(id);

alter table parking_ticket_payments add constraint
foreign key (id) references entry_parking_transactions(id);

alter table parking_ticket_payments add constraint
foreign key (tariff_id) references tariffs(id);

alter table parking_ticket_payments add constraint
foreign key (id_type_payment) references type_payment(id);

alter table parking_ticket_payments add constraint
foreign key (device_id) references devices(id);

alter table parking_ticket_payments add constraint
foreign key (sales_id) references sales(id);

alter table season_card_payments add constraint
foreign key (tariff_id) references tariffs(id);

alter table season_card_payments add constraint
foreign key (id_type_payment) references type_payment(id);

alter table season_card_payments add constraint
foreign key (user_id) references system_users(id);

alter table tariffs add constraint
foreign key (id_parking_zone) references parking_zone(id);

alter table system_errors add constraint
foreign key (device_id) references devices(id);

alter table system_errors add constraint
foreign key (user_id) references system_users(id);

alter table open_barrier add constraint
foreign key (user_id) references system_users(id);

alter table open_barrier add constraint
foreign key (device_id) references devices(id);



