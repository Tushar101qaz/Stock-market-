
-- Average Daily Trading Volume 

Select ticker , concat(round(avg(Volume)/1000,1)," K") Avg_volume 
from 
stock_data 
group by ticker
order by avg_volume desc ; 

-- Most Volatile Stocks 

Select Ticker , Round(sum(beta),2) as Volatility 
from stock_data 
group by Ticker 
order by Volatility Desc ; 

-- Stocks with Highest Dividend and Lowest Dividend 

Select distinct(ticker) , devident  from 
(select distinct(Ticker) as ticker ,
sum(dividend_Amount) as devident ,
 dense_rank() over ( order by sum(Dividend_Amount) desc) as Rank_ from stock_data
group by ticker  )as A 
join 
stock_data 
using(ticker)
where rank_ in (1,5)
; 

-- Highest and lowest P/E ratios  

select distinct(ticker) , PE.PE_Ratio from (select ticker , round(avg(PE_Ratio),2) as PE_ratio, 
dense_rank() over(order by avg(PE_ratio) desc) as Rank_
from stock_data 
group by ticker ) as PE 
join stock_data 
using(Ticker) 
where rank_ in (1,5) 
order by PE.PE_ratio desc ; 

select ticker , round(avg(PE_ratio),2)pe
from stock_data 
group by Ticker 
order by pe desc ; 

-- Stocks with Highest Market Cap 

select Ticker , round(avg(Market_Cap),2) as Mrkt_capital ,
dense_rank()over (order by avg(Market_Cap) desc) as Rank_
from stock_data 
group by Ticker 
order by Mrkt_capital desc ;  

-- STock 52 week high

Select distinct(ticker) , max(WeekHigh_52) High 
from stock_data
group by ticker  
order by High desc ; 


Select distinct(ticker) , min(Week_Low_52) High
from stock_data
group by ticker  
order by High desc ; 


-- Strong selling signal 
-- when 0> buying signal , 0< selling signal 

Select Ticker , round(avg(MACD),2) MACD 
from stock_data 
group by ticker 
order by MACD desc
 ; 

-- Strong buying signal  
 select ticker , round(avg(RSI_14_days),2) as RSI 
 from stock_data 
 group by Ticker
 order by RSI ; 

-- Last 10 Years stock analysis 

Select year(Date_) year_,Ticker,
concat(round(avg(Volume)/1000000,2)," M") Avg_volume_traded
from stock_data 
group by year_ , Ticker
having year_ >=2013
order by year_ desc 
; 

-- Year wise market capital 

Select year(Date_) year_,Ticker,
concat(round(avg(market_cap)/1000000,2)," M") Avg_trading_amount_in_mill
from stock_data 
group by year_ , Ticker
having year_ >=2018
order by year_ desc 
; 














