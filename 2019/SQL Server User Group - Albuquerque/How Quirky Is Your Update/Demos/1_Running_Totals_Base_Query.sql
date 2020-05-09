/************************************************************************************
Created By	: 	Martin Schoombee 
				@MartinSchoombee
Date		:	2/16/2015

Summary		:	Using the AdventureWorksDW2017 database, this is the base query to 
				illustrate the running totals scenario.

				AdventureWorksDW2017 can be found here:
				https://github.com/Microsoft/sql-server-samples/releases/tag/adventureworks

*************************************************************************************/


--------------------------------------------------------------------------------------
-- database scope

use AdventureWorksDW2017
go


--------------------------------------------------------------------------------------
-- base query

select	dte.CalendarYear
	,	dte.MonthNumberOfYear
	,	dte.EnglishMonthName
	,	sum(sls.OrderQuantity) as OrderQuantity

from	dbo.FactInternetSales sls
inner join dbo.DimDate dte on dte.DateKey = sls.OrderDateKey

where	dte.CalendarYear in (2012, 2013)

group by dte.CalendarYear
	,	dte.MonthNumberOfYear
	,	dte.EnglishMonthName

order by dte.CalendarYear
	,	dte.MonthNumberOfYear
;