Create database Quantium;

use Quantium

CREATE TABLE Qsales (
    DATE DATE,
    STORE_NBR INT,
    LYLTY_CARD_NBR INT,
    TXN_ID INT,
    PROD_NBR INT,
    PROD_NAME VARCHAR(255),
    PROD_QTY INT,
    TOT_SALES DECIMAL(10, 2)
);

BUlk insert Qsales
from 'C:\Users\HP\Downloads\Forage-QVI-main\Forage-QVI-main\QVI_transaction_data_1.csv'
with
(
format='CSV',
firstrow=2,
fieldterminator=',',
rowterminator='\n'
);

Select * from Qsales
----------------------------------------------------------------------------------------------------------------------------

CREATE TABLE Qpurchase (
    LYLTY_CARD_NBR INT,
    LIFESTAGE VARCHAR(255),
    PREMIUM_CUSTOMER VARCHAR(50)
);

BUlk insert Qpurchase
from 'C:\Users\HP\Downloads\Forage-QVI-main\Forage-QVI-main\QVI_purchase_behaviour.csv'
with
(
format='CSV',
firstrow=2,
fieldterminator=',',
rowterminator='\n'
);

select * from Qpurchase

----------------------------------------------------------------------------------------------------------------------------

-------KPI
Select * from Qsales;
Select * from Qpurchase;

Select Round(sum(tot_sales),2)as Total_sales
from Qsales 

Select sum(PROD_QTY) as Total_quantity
from Qsales

select count(*) as Tot_transaction from Qsales

----------------------------------------------------------------------------------------------------------------------------

-----Total Sales done
Select Qp.PREMIUM_CUSTOMER,Round(sum(Qs.tot_sales),2) as sales
from Qpurchase as Qp
join Qsales as Qs
on Qp.LYLTY_CARD_NBR=Qs.LYLTY_CARD_NBR
group by qp.PREMIUM_CUSTOMER;


Select Qp.LIFESTAGE,Round(sum(Qs.tot_sales),2) as sales
from Qpurchase as Qp
join Qsales as Qs
on Qp.LYLTY_CARD_NBR=Qs.LYLTY_CARD_NBR
group by qp.LIFESTAGE;

----------------------------------------------------------------------------------------------------------------------------
-----Total Quantity Sold
Select Qp.PREMIUM_CUSTOMER,Round(sum(Qs.PROD_QTY),2) as TOT_QTD
from Qpurchase as Qp
join Qsales as Qs
on Qp.LYLTY_CARD_NBR=Qs.LYLTY_CARD_NBR
group by qp.PREMIUM_CUSTOMER;


Select Qp.LIFESTAGE,Round(sum(Qs.PROD_QTY),2) as TOT_QTD
from Qpurchase as Qp
join Qsales as Qs
on Qp.LYLTY_CARD_NBR=Qs.LYLTY_CARD_NBR
group by qp.LIFESTAGE;

----------------------------------------------------------------------------------------------------------------------------
----Total Transaction Count
Select Qp.PREMIUM_CUSTOMER,Round(count(Qs.PROD_QTY),2) as TOT_QTD
from Qpurchase as Qp
join Qsales as Qs
on Qp.LYLTY_CARD_NBR=Qs.LYLTY_CARD_NBR
group by qp.PREMIUM_CUSTOMER;


Select Qp.LIFESTAGE,Round(count(Qs.PROD_QTY),2) as TOT_QTD
from Qpurchase as Qp
join Qsales as Qs
on Qp.LYLTY_CARD_NBR=Qs.LYLTY_CARD_NBR
group by qp.LIFESTAGE

----------------------------------------------------------------------------------------------------------------------------
-----Store Wise
Select Distinct Qs.PROD_NBR,Round(sum(Qs.PROD_QTY),2) as TOT_QTD
from Qpurchase as Qp
join Qsales as Qs
on Qp.LYLTY_CARD_NBR=Qs.LYLTY_CARD_NBR
group by Qs.PROD_NBR
order by Qs.PROD_NBR asc;


Select Qs.PROD_NBR,Round(count(Qs.PROD_QTY),2) as TOT_QTD
from Qpurchase as Qp
join Qsales as Qs
on Qp.LYLTY_CARD_NBR=Qs.LYLTY_CARD_NBR
group by Qs.PROD_NBR
order by Qs.PROD_NBR asc;

----------------------------------------------------------------------------------------------------------------------------

------Year Wise Sales
Select year(Date) as year,Round(sum(TOT_sales),2) as Sales
from Qsales
group by year(Date)
order by year asc;

----------------------------------------------------------------------------------------------------------------------------
----Month Wise Sales
Select month(date) as Months, Round(sum(TOT_sales),2) as Sales
from Qsales
where year(Date)=2018
group by month(date)
order by months asc

Select month(date) as Months, Round(sum(TOT_sales),2) as Sales
from Qsales
where year(Date)=2019
group by month(date)
order by months asc

----------------------------------------------------------------------------------------------------------------------------
---Quater Wise Sales
Select DatePART(QUARTER,date) as Quarter, Round(sum(TOT_sales),2) as Sales
from Qsales
where year(Date)=2019
group by DatePART(QUARTER,date)

Select DatePART(QUARTER,date) as Quarter, Round(sum(TOT_sales),2) as Sales
from Qsales
where year(Date)=2018
group by DatePART(QUARTER,date)



