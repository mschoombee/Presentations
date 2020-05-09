/************************************************************************************
Created By	: 	Martin Schoombee 
				@MartinSchoombee
Date		:	2/16/2015

Summary		:	This script illustrates how a running total can be calculated with 
				a recursive cte.

				More on recursive cte's: 
				https://technet.microsoft.com/en-us/library/ms186243(v=sql.105).aspx

*************************************************************************************/

set statistics io on;
set statistics time on;

--------------------------------------------------------------------------------------
-- database scope

use AdventureWorksDW2017
go


--------------------------------------------------------------------------------------
-- create temp table for our results

select	dte.CalendarYear
	,	dte.MonthNumberOfYear
	,	dte.EnglishMonthName
	,	sum(sls.OrderQuantity) as OrderQuantity
	,	0 as RunningTotal

into	#Tmp_Sales
from	dbo.FactInternetSales sls
inner join dbo.DimDate dte on dte.DateKey = sls.OrderDateKey

where	dte.CalendarYear in (2012, 2013)

group by dte.CalendarYear
	,	dte.MonthNumberOfYear
	,	dte.EnglishMonthName
;


--------------------------------------------------------------------------------------
-- select with aggregate window function

with Recursive_Sales_CTE as
(
	-- anchor query (the first month of each year)
	select	tmp.CalendarYear
		,	tmp.MonthNumberOfYear
		,	tmp.EnglishMonthName
		,	tmp.OrderQuantity
		,	tmp.OrderQuantity as RunningTotal
		--,	1 as [Level]

	from	#Tmp_Sales tmp

	where	tmp.MonthNumberOfYear = 1

	union all

	-- recursive query
	select	tmp.CalendarYear
		,	tmp.MonthNumberOfYear
		,	tmp.EnglishMonthName
		,	tmp.OrderQuantity
		,	tmp.OrderQuantity + cte.RunningTotal as RunningTotal
		--,	[Level] + 1 as [Level]

	from	#Tmp_Sales tmp
	inner join Recursive_Sales_CTE cte on cte.CalendarYear = tmp.CalendarYear and cte.MonthNumberOfYear + 1 = tmp.MonthNumberOfYear
)
update	#Tmp_Sales
set		RunningTotal = cte.RunningTotal

from	#Tmp_Sales tmp
inner join Recursive_Sales_CTE cte on cte.CalendarYear = tmp.CalendarYear and cte.MonthNumberOfYear = tmp.MonthNumberOfYear
;


--------------------------------------------------------------------------------------
-- results

select	*

from	#Tmp_Sales

order by CalendarYear
	,	MonthNumberOfYear
;


--------------------------------------------------------------------------------------
-- drop temp table

drop table #Tmp_Sales;

-- total reads: ~1,500