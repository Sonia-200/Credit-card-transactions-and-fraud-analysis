select * from credit_data --2,84,807 rows



--check for dublicates
select 
count(*) - count(distinct(time,v1,v2,v3,v4,v5,v6,v7,v8,v9,v10,v11,v12,v13,v14,v15,
v16,v17,v18,v19,v20,v21,v22,v23,v24,v25,v26,v27,v28,amount,class,ts,txn_date,hour_of_day,
day_of_week,amount_bkt,is_large_txn,amount_log)) as dup_values
from credit_data --1081 dublicate rows



--creating a table with no dublicate value 
create table creditcard as 
select * from 
( select *,
row_number() over(partition by time,v1,v2,v3,v4,v5,v6,v7,v8,v9,v10,v11,v12,v13,v14,v15,
v16,v17,v18,v19,v20,v21,v22,v23,v24,v25,v26,v27,v28,amount,class,ts,txn_date,hour_of_day,
day_of_week,amount_bkt,is_large_txn,amount_log
order by time) as rn
from credit_data
)
where rn=1 --2,83,726 rows



select * from creditcard