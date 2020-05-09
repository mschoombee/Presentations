/************************************************************************************
Created By	: 	Martin Schoombee 
				@MartinSchoombee
Date		:	2/16/2015

Summary		:	This script illustrates how a running total can be calculated with 
				a "quirky" update.

				T-SQL Update statement reference: 
				https://msdn.microsoft.com/en-us/library/ms177523.aspx

				"Quirky" Updates:
				http://www.sqlservercentral.com/articles/T-SQL/68467/

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
-- create clustered index

create clustered index idx_Tmp_Sales_1 on #Tmp_Sales(CalendarYear, MonthNumberOfYear);


--------------------------------------------------------------------------------------
-- declare local variables

declare	@Previous_Row_Calendar_Year int
	,	@Running_Total int
;


--------------------------------------------------------------------------------------
-- "quirky" update

update	#Tmp_Sales
set		@Running_Total = RunningTotal =	case
											when CalendarYear = @Previous_Row_Calendar_Year then OrderQuantity + @Running_Total
											else OrderQuantity
										end
	,	@Previous_Row_Calendar_Year = CalendarYear

from	#Tmp_Sales tmp with (tablockx)
option (maxdop 1)
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


-- total reads: ~1,300