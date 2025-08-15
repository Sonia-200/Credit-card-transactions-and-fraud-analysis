                                     --KPIs--

--total records or transactions
select count(*) as total_txns
from creditcard
--2,83,726 total txns

--num of normal or non-fraud transactions
select count(*) as non_fraud_txns
from creditcard
where class=0
--2,83,253 non-fraud txns

--num of fraud transactions
select count(*) as fraud_txns
from creditcard
where class=1
--473 fraud txns


                                      --Basic trends--


--percent of fraud and non-fraud txns
select 
100.0*sum(case when class=0 then 1 else 0 end)/count(*) as non_fraud_perctile,
100.0*sum(case when class=1 then 1 else 0 end)/count(*) as fraud_percentile
from creditcard
-- there are ~99.8% normal txns and only ~0.16% fraud txns


--relation btwn class & amount
select 
class,
min(amount) as min_amount,
avg(amount) as avg_amount,
max(amount) as max_amount
from creditcard
group by class
--max amount of non-fraud-txns is less as compared to fraud-txns.
--however the avg_amount of fraud-txns are more than non-fraud-txns showing fraud-txns have more anomalies.


--relation btwn txn amount and their frequency
select
amount_bkt,
count(rn)
from creditcard
group by amount_bkt
order by count(amount_bkt) desc
--most txns were for 1-19 amount, txns with amount 1000+ were least.


--hour trend
select hour_of_day,
count(hour_of_day) as num_of_txns
from creditcard
group by hour_of_day
order by count(hour_of_day) desc
--late hours has the more number of transactions than early hours 


--num_of_large_txns 
select 
is_large_txn,
count(is_large_txn) as num_of_txns
from creditcard
group by is_large_txn
-- there were only 3064 txns with 1000&+ amount

select *
from creditcard




                                  --fraud transactions trend--


--relation between amount and fraud
select amount_bkt, 
count(amount_bkt)
from creditcard
where class =1
group by amount_bkt
order by count(amount_bkt) desc
--most fraud txns have transaction amount<5 and least txns with amount more than 1000


--Hour trend for fraud
select hour_of_day, 
count(hour_of_day)
from creditcard
where class =1
group by hour_of_day
order by count(hour_of_day) desc
-- most of the fraud txns took place during 11 & 2 hour of the day that means the afternoon times

select * 
from creditcard 
where class=1




                           -- Outcomes from sql queries--
/*
----kPIS
-2,83,726 total txns
-2,83,253 non-fraud txns          --Fraud is very rare <<1% of the total transactions
-473 fraud txns

----basic trends
-there are ~99.8% normal txns and only ~0.16% fraud txns
-max amount of non-fraud-txns is less as compared to fraud-txns.
however the avg_amount of fraud-txns are more than non-fraud-txns showing fraud-txns have more anomalies.
-most txns were for 1-19 amount, txns with amount 1000+ were least.
-late hours has the more number of transactions than early hours 
-there were only 3064 txns with 1000&+ amount

----Fraud trends
-most fraud txns have transaction amount<5 and least txns with amount more than 1000
-most of the fraud txns took place during 11 & 2 hour of the day that means the afternoon times
*/


                              --Insights--

/*
-Fraud is very rare <<1% of the total transactions
-Amount is highly skewed( many small txns, few very large txns)
-Fraudulent txns look more 'anamolous' in amount
-Most frauds occuring at midday or afternoon
*/


