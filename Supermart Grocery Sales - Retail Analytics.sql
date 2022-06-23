create database SuperMarket

use SuperMarket

--We explore the data after it is fetched.

select * 
from SuperMarketSales


------------_____Cleaning Data_______----------------------

--Breaking out id into  only numbers.

select id from SuperMarketSales


select id,SUBSTRING(id,3,len(id)) as Order_ID

from SuperMarketSales


ALTER TABLE SuperMarketSales
Add Order_ID int;

Update SuperMarketSales
SET Order_ID = SUBSTRING(id,3,len(id))



-- Change DataType of (Order_date ,Sales).

SElect Order_date,CONVERT(date,Order_date) as Order_Date_converted

from SuperMarketSales

ALTER TABLE SuperMarketSales
Add Order_Date_converted date;

Update SuperMarketSales
SET Order_Date_converted =CONVERT(date,Order_date)

------------------

select Sales,CONVERT(int,Sales) as Sales_converted

from SuperMarketSales

ALTER TABLE SuperMarketSales
Add Sales_converted int;

Update SuperMarketSales
SET Sales_converted =CONVERT(int,Sales)

-------------------------------------------------
---- Delete Unused Columns.
ALTER TABLE SuperMarketSales
DROP COLUMN Profit_Evaluation,id,Order_date,Sales

select *
from SuperMarketSales


----------------------------------------------------------------------
--Add a column to evaluate the profit.
ALTER TABLE SuperMarketSales
Add Profit_Evaluation varchar(255);



--Insert the evaluation in Profit_Evaluation.


Update SuperMarketSales
SET Profit_Evaluation = CASE When Profit < 200  THEN 'is small profit' 
	   When Profit  between 200 and 400 THEN 'is medaim profit'
	   when Profit > 400 then 'is hight profit'
	   ELSE 'none'
	   END

-------------------___________Data Analysis__________-----------------------

-- Select The Data That we are going to be using.

select Order_ID,Order_Date_converted,Category,City,Region,Sales_converted,Profit,Profit_Evaluation

from SuperMarketSales

where Order_Date_converted is not null

order by Order_ID

---------------------------------------------
--To show the number of categories sold.

select Category,count(Order_ID) as nuber_of_category_sold

from SuperMarketSales

group by Category

order by nuber_of_category_sold desc


--------------------------------------------------
--To show which city bought the most.

select city,count(Order_ID) as number_of_cities

from SuperMarketSales

group by City

order by number_of_cities desc


------------------------------------------------------------------------------
--Calculate total sales and profits.

select Category,sum(Sales_converted) as Total_sales,sum(Profit) as Total_profit

from SuperMarketSales

group by Category


--------------------------------------------------------------------------------
--Calculation of total profits by region.

select Region,sum(Profit) as Total_Profit ,Profit_evaluation

from SuperMarketSales

group by Region ,Profit_evaluation

order by Total_Profit desc


------------------------------------------------
--Categories sales over the years.

select datepart(YEAR,Order_Date_converted) as Order_Date --We split the date to take the years only
 ,Category
,sum(Sales_converted )as Total_Sales

from SuperMarketSales

where Order_Date_converted is not null

group by datepart(YEAR,Order_Date_converted) , Category

order by Order_Date



