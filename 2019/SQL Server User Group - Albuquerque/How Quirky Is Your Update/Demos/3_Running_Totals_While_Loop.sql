/************************************************************************************
Created By	: 	Martin Schoombee 
				@MartinSchoombee
Date		:	2/16/2015

Summary		:	This script illustrates how a running total can be calculated with 
				while-loops.

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
-- declare local variables

declare	@Last_Calendar_Year int
	,	@Last_Month_Number int
	,	@Current_Calendar_Year int
	,	@Current_Month_Number int
;


--------------------------------------------------------------------------------------
-- set year boundaries

select	@Current_Calendar_Year = min(CalendarYear)
	,	@Last_Calendar_Year = max(CalendarYear)

from	#Tmp_Sales
;


--------------------------------------------------------------------------------------
-- loop through rows, calculating the running total

while @Current_Calendar_Year <= @Last_Calendar_Year
-- loop through the years
begin

	-- reset month numbers
	select	@Current_Month_Number = min(MonthNumberOfYear)
		,	@Last_Month_Number = max(MonthNumberOfYear)

	from	#Tmp_Sales

	where	CalendarYear = @Current_Calendar_Year
	;


	-- loop through the months
	while @Current_Month_Number <= @Last_Month_Number
	begin

			-- update temp table with running total
			update	#Tmp_Sales
			set		RunningTotal = (
										select	sum(OrderQuantity)
										from	#Tmp_Sales sls
										where	sls.CalendarYear = @Current_Calendar_Year
												and sls.MonthNumberOfYear <= @Current_Month_Number	
									)

			where	CalendarYear = @Current_Calendar_Year
					and MonthNumberOfYear = @Current_Month_Number
			;


			-- increment month number
			set @Current_Month_Number = @Current_Month_Number + 1;

	end;


	-- increment year number
	set @Current_Calendar_Year = @Current_Calendar_Year + 1;

end
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