/************************************************************************************
Created By	: 	Martin Schoombee 
				@MartinSchoombee
Date		:	2/16/2015

Summary		:	This script illustrates how a running total can be calculated with 
				triangular joins.

				More on triangular joins: 
				http://www.sqlservercentral.com/articles/T-SQL/61539/

				Note: The syntax below could also have been changed to either use 
				the "APPLY" operator or a correlated sub-query.

*************************************************************************************/

set statistics io on;
set statistics time on;

--------------------------------------------------------------------------------------
-- database scope

use AdventureWorksDW2017
go


--------------------------------------------------------------------------------------
-- select with triangular join

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
	,	sum(c2.OrderQuantity) as RunningTotal

from	Sales_CTE cte
left outer join Sales_CTE c2 on c2.CalendarYear = cte.CalendarYear and c2.MonthNumberOfYear <= cte.MonthNumberOfYear

group by cte.CalendarYear
	,	cte.MonthNumberOfYear
	,	cte.EnglishMonthName
	,	cte.OrderQuantity
;

-- total reads: ~2,600