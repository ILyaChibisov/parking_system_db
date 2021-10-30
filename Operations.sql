-- Скрипты характерных выборок (включающие группировки, JOIN'ы, вложенные таблицы)

-- Выборка по интервалу времени въезда пользователя

USE Parking_system;

select entry_time, card_type
from entry_parking_transactions ept 
where (entry_time between '2021-10-15 09:00:04' and '2021-10-15 10:00:00');

-- Cумма оплат на терминалах
select sum(client_payment)
from parking_ticket_payments ptp ; 

-- делаем группировку по пользователям, чтобы найти кто и что последний раз ремонтировал...

select se.type_errors, se.time_error, se.time_troubleshooting, su.full_name 
from system_errors se
join system_users su on se.user_id = su.id
group by su.full_name 
order by se.time_error desc; 

-- делаем запрос с вложенным  подзапросом, ищем  въезд и  выезда постоянного клиента с id = 1

select ept.entry_time, pz.zone_name, ex.exit_time 
from entry_parking_transactions ept
join parking_zone pz on ept.zone_id = pz.id
join exit_parking_transactions  as ex on  ept.id = ex.entry_info_id
where client_card_id in (select id from season_card_payments scp where id = 1);


-- Делаем обьединение таблиц(журнал событий стройств) группируем по времени 

select entry_time as `time`, d.number_device as `Device number`, td.type_devices as `current event`
from entry_parking_transactions ept
join devices d on ept.device_id = d.id
join type_devices td on d.id_type_device = td.id 
union all

select exit_time as `time`, d.number_device as `Device number`, td.type_devices as `current event`
from exit_parking_transactions ext
join devices d on ext.device_id = d.id
join type_devices td on d.id_type_device = td.id 
union all

select payment_time as `time`, d.number_device as `Device number`, td.type_devices as `current event` 
from parking_ticket_payments ptp
join devices d on ptp.device_id = d.id
join type_devices td on d.id_type_device = td.id
union all

select time_error as `time`, d.number_device as `Device number`, type_errors as `current event` 
from system_errors se
join devices d on se.device_id = d.id
group by `time`
order by  `Device number`;

-- Представления
-- делаем таблицу парковочной сессии въезд\выезд и время стоянки.

drop view if exists view_parking_session;
create view view_parking_session 
as
	select d1.number_device `entry`, en.entry_time, tp.parking_time, d2.number_device `exit`, ex.exit_time
	from entry_parking_transactions as en
		join exit_parking_transactions  as ex on  en.id = ex.entry_info_id
		join devices d1 on en.device_id = d1.id
		join devices d2 on ex.device_id = d2.id
		join parking_ticket_payments tp on en.id = tp.entry_id 
	where en.card_type = 'parking ticket';
	
select * from view_parking_session;

-- Таблица ручных открываний шлагбаума пользователями.

drop view if exists view_barrier_opened_users;
create view view_barrier_opened_users 
as
	select su.full_name, su.type_user, ob.time_to_open, d.number_device
	from open_barrier as ob
		join system_users  su on  ob.user_id = su.id
		join devices d on ob.device_id = d.id
		;
	
select * from view_barrier_opened_users;

-- Хранимые процедуры / триггеры
-- процедура вывода тарифа заехавшего  пользователя id

drop procedure if exists user_tariff;

DElIMITER &&
create procedure user_tariff(in for_id bigint)
	begin
		select tf.tariff_name as name, tf.tariff_price_ticket as price
		from parking_ticket_payments ptp
		join entry_parking_transactions as en on ptp.entry_id = en.id 
		join tariffs as tf on ptp.tariff_id = tf.id
		where ptp.entry_id = for_id
	union all
		select tf.tariff_name as name, tf.tariff_price_season_card as price
			from season_card_payments scp 
			join entry_parking_transactions as en on scp.id = en.client_card_id 
			join tariffs as tf on scp.tariff_id = tf.id
			where en.id = for_id; 
		
	end &&

DElIMITER ;

call user_tariff(1);


-- Делаем функцию подсёта точного времени стоянки пользователя не паркинге

DROP FUNCTION IF EXISTS parking_system.session_time;

DELIMITER $$

CREATE FUNCTION parking_system.session_time(for_id bigint)
RETURNS time reads sql data
begin
		declare time_ent datetime;
		declare time_ext datetime;
		declare results time; 
		
		set time_ent = (select entry_time from entry_parking_transactions ept where ept.id = for_id);
		set time_ext = (select exit_time from exit_parking_transactions ex where ex.entry_info_id = for_id);
		set results = timediff(time_ext,time_ent);
	return results;
end	  
	
DELIMITER ;

select session_time(4);


-- Триггер проверка смены времени въезда 

drop trigger if exists parking_system.check_entry_time_before_update;
DELIMITER $$
create trigger check_entry_time_before_update before update on parking_system.entry_parking_transactions
for each row 
	begin 
	DECLARE msg VARCHAR(255);

	if new.entry_time >= now() then
	set msg = concat('Error: Incorrect entry time!');
	signal sqlstate '45000' set message_text = msg;
	
	end if;	
end; 
$$
DELIMITER ;

-- Тестируем триггер

update entry_parking_transactions
set entry_time = now() where id = 1; 