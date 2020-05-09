/************************************************************************************
Created By	: 	Martin Schoombee 
				@MartinSchoombee
Date		:	2/16/2015

Summary		:	This script illustrates how a running total can be calculated with 
				a cursor.

				Don't do it!!!

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

declare	@Calendar_Year int
	,	@Month_Number int
	,	@Month_Name varchar(50)
	,	@Order_Quantity int
	,	@Current_Calendar_Year int -- used to determine if we're still in the same year
	,	@Running_Total int = 0 -- this variable used to store the running total
;


--------------------------------------------------------------------------------------
-- declare cursor

declare Running_Total_Cursor cursor for
	select	CalendarYear
		,	MonthNumberOfYear
		,	EnglishMonthName
		,	OrderQuantity

	from	#Tmp_Sales

	order by CalendarYear
		,	MonthNumberOfYear
;


--------------------------------------------------------------------------------------
-- open cursor and fecth first row

open Running_Total_Cursor;

fetch next from Running_Total_Cursor into
		@Calendar_Year
	,	@Month_Number
	,	@Month_Name
	,	@Order_Quantity
;


--------------------------------------------------------------------------------------
-- set current year variable

set	@Current_Calendar_Year = @Calendar_Year;


--------------------------------------------------------------------------------------
-- loop through rows, calculating the running total

while @@fetch_status = 0 -- cursor has more rows
begin

	-- add to the running total if we're still in the same year, otherwise reset it
	if (@Calendar_Year = @Current_Calendar_Year)
		set @Running_Total = @Running_Total + @Order_Quantity
	else	
	begin

		select	@Current_Calendar_Year = @Calendar_Year
			,	@Running_Total = @Order_Quantity
	end
	;


	-- update temp table's running total field
	update	#Tmp_Sales
	set		RunningTotal = @Running_Total
	where	CalendarYear = @Calendar_Year
			and MonthNumberOfYear = @Month_Number
	;


	-- fetch next row from cursor
	fetch next from Running_Total_Cursor into
			@Calendar_Year
		,	@Month_Number
		,	@Month_Name
		,	@Order_Quantity

end
;


--------------------------------------------------------------------------------------
-- close and deallocate cursor

close Running_Total_Cursor;
deallocate Running_Total_Cursor;


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