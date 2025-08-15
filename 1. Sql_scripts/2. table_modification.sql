--modifying data
alter table credit_data
add column ts TIMESTAMP,
add column txn_date date,
add column hour_of_day int,
add column day_of_week int,
add column amount_bkt text,
add column is_large_txn boolean,
add column amount_log double precision


update credit_data
set
ts = timestamp '2024-01-01 00:00:00' + (time||'seconds')::interval,
txn_date = (timestamp '2024-01-01 00:00:00' + (time||'seconds')::interval)::date,
hour_of_day = extract(hour from(timestamp '2024-01-01 00:00:00' + (time||'seconds')::interval))::int,
day_of_week= extract(DOW from(timestamp '2024-01-01 00:00:00' + (time||'seconds')::interval))::int, 
amount_bkt = case
when amount is null then 'Unknown'
when amount<5 then '<5'
when amount<20 then '5-19'
when amount<50 then '20-49'
when amount<100 then '50-99'
when amount<500 then '100-499'
when amount<1000 then '500-999'
else '1000+'
end,
is_large_txn= (amount>999),
amount_log = case when amount>0 then LN(amount)
else null end;

 
--creating indexes
create index idx_ts on credit_data(ts);
create  index idx_class on credit_data(class);
create index idx_hour on credit_data(hour_of_day);
create index idx_amount_bkt on credit_data(amount_bkt);
create index idx_date on credit_data(txn_date);




