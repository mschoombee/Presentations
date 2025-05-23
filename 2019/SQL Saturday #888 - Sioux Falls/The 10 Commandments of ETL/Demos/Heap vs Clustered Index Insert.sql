-- truncate staging tables
truncate table IMDB_Staging.IMDB.Movies_Heap;
truncate table IMDB_Staging.IMDB.Movies_Clustered_Index;

--------------------------------------------------------------------------
-- insert data
set statistics io on;
go
set statistics time on;
go


-- heap
insert into IMDB_Staging.IMDB.Movies_Heap
(
	Movie_List
)
(
	select	Movie_List
	from	IMDB_Staging.IMDB.Movies_Source_Data
);


-- clustered index
insert into IMDB_Staging.IMDB.Movies_Clustered_Index
(
	Movie_List
)
(
	select	Movie_List
	from	IMDB_Staging.IMDB.Movies_Source_Data
);
