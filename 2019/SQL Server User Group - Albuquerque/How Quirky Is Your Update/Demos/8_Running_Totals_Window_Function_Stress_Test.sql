/************************************************************************************
Created By	: 	Martin Schoombee 
				@MartinSchoombee
Date		:	2/16/2015

Summary		:	This script illustrates how a running total can be calculated with 
				window functions.

				More on window functions: 
				https://msdn.microsoft.com/en-us/library/ms189461.aspx

				Tally Tables:
				http://www.sqlservercentral.com/articles/T-SQL/62867/
				http://www.sqlservercentral.com/articles/Tally+Table/72993/

*************************************************************************************/

set statistics io on;
set statistics time on;


--------------------------------------------------------------------------------------
-- create temp table for our results
-- using an in-memory tally table to expand our source data set
;with E1(N) 
as 
(
	select 1 union all select 1 union all select 1 union all 
	select 1 union all select 1 union all select 1 union all
	select 1 union all select 1 union all select 1 union all 
	select 1
) -- 10E+1 or 10 rows
, 
E2(N) 
as 
(
	select	1 
	from	E1 a, E1 b
) --10E+2 or 100 rows
, 
E4(N) 
as 
(
	select	1 
	from	E2 a, E2 b
) --10E+4 or 10,000 rows max
, 
E16(N) 
as 
(
	select	1 
	from	E4 a, E4 b
) --10E+16 or 10,000,000,000,000,000 rows max
, 
Tally_CTE(N) 
as 
(
	select	0
	
	union all
	
	select	top 10000000 -- how many rows you want to return, 10 million in our case
			row_number() over (order by (select null)) 
			
	from	E16
)
select	N + 1 as Line_Number
	,	convert
		(
			bigint
		,	abs(checksum(newid())) % 100
		) as OrderQuantity
	,	convert(bigint,0) as RunningTotal

into	#Tmp_Sales
from	Tally_CTE
;


--------------------------------------------------------------------------------------
-- and just to prove that we have 10 million records

select	count(*)

from	#Tmp_Sales
;


--------------------------------------------------------------------------------------
-- create clustered index (in case it helps with performance)

create clustered index idx_Tmp_Sales_1 on #Tmp_Sales(Line_Number);


--------------------------------------------------------------------------------------
-- update with aggregate window function

with Sales_CTE
as
(
	select	tmp.Line_Number
		,	tmp.OrderQuantity
		,	sum(tmp.OrderQuantity) over 
			(
				order by tmp.Line_Number -- the order by clause is important here
				range unbounded preceding -- this means: start at the first row in the partition
			) as RunningTotal

	from	#Tmp_Sales tmp
)
update	#Tmp_Sales
set		RunningTotal = cte.RunningTotal

from	#Tmp_Sales tmp
inner join Sales_CTE cte on cte.Line_Number = tmp.Line_Number
;


--------------------------------------------------------------------------------------
-- results

select	*

from	#Tmp_Sales

order by Line_Number
;


--------------------------------------------------------------------------------------
-- drop temp table

drop table #Tmp_Sales;













-- total time: ~1:41
-- total reads: 120,555,671