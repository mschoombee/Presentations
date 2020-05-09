/************************************************************************************
Created By	: 	Martin Schoombee 
				@MartinSchoombee
Date		:	2/16/2015

Summary		:	This script illustrates how a running total can be calculated with 
				window functions.

				More on window functions: 
				https://msdn.microsoft.com/en-us/library/ms189461.aspx

*************************************************************************************/

set statistics io on;
set statistics time on;

--------------------------------------------------------------------------------------
-- database scope

use AdventureWorksDW2017
go


--------------------------------------------------------------------------------------
-- select with aggregate window function

with Sales_CTE
as
(
	select	dte.CalendarYear
		,	dte.MonthNumberOfYear
		,	dte.EnglishMonthName
		,	sum(sls.OrderQuantity) as OrderQuantity
		,	0 as RunningTotal

	from	dbo.FactInternetSales sls
	inner join dbo.DimDate dte on dte.DateKey = sls.OrderDateKey

	where	dte.CalendarYear in (2012, 2013)

	group by dte.CalendarYear
		,	dte.MonthNumberOfYear
		,	dte.EnglishMonthName
)
select	cte.CalendarYear
	,	cte.MonthNumberOfYear
	,	cte.EnglishMonthName
	,	cte.OrderQuantity
	,	sum(cte.OrderQuantity) over 
		(
			partition by cte.CalendarYear
			order by cte.MonthNumberOfYear -- the order by clause is important here
			range unbounded preceding -- this means: start at the first row in the partition
		) as RunningTotal

from	Sales_CTE cte
;


-- total reads: ~1,450 
-- note the elapsed time difference from the previous method (17 ms vs. 32 ms)