USE Netflix_Data

SELECT
	show_id,
	type,
	title,
	director,
	cast,
	country,
	date_added,
	release_year,
	rating,
	duration,
	listed_in,
	description
FROM dbo.netflix_titles;

CREATE TABLE OriginalData (
    show_id nvarchar(max),
	show_type nvarchar(max),
	title nvarchar(max),
	director nvarchar(max),
	cast nvarchar(max),
	country nvarchar(max),
	date_added datetime2,
	release_year int,
	rating nvarchar(max),
	duration nvarchar(max),
	listed_in nvarchar(max),
	description nvarchar(max));

SELECT * FROM OriginalData

INSERT INTO OriginalData
SELECT * FROM dbo.netflix_titles;

--Creating Views  --

CREATE VIEW title_year
AS
SELECT title, release_year
FROM OriginalData;

SELECT * FROM title_year


CREATE VIEW title_cast
AS
SELECT title, cast
FROM OriginalData;

SELECT * FROM title_cast;

CREATE VIEW title_director_year
AS
SELECT title, director, release_year
FROM OriginalData;

SELECT * FROM title_director_year

-- Queries--

SELECT 
	title,
	director,
	release_year
	FROM OriginalData
	WHERE release_year>=2000;

SELECT 
	show_id,
	title
	FROM OriginalData
	WHERE director='Remo D''Souza';  --  Need to use double single quotes where the string has a ' --

SELECT DISTINCT     -- To eliminate duplicates in a same column or columns of a table --
	director
	FROM OriginalData;

SELECT DISTINCT
	show_type, 
	rating
	FROM OriginalData;

SELECT DISTINCT
	director, 
	country
	FROM OriginalData;

SELECT *	
	FROM OriginalData
	ORDER BY director DESC;

SELECT
	title,
	director
	FROM OriginalData
	ORDER BY director DESC;

SELECT
	title,
	director,
	release_year
	FROM OriginalData
	WHERE release_year>2000 AND country='Colombia';

SELECT 
	show_type,
	title,
	release_year,
	rating
	FROM OriginalData
	WHERE country='Colombia' AND rating<>'TV-MA' 

SELECT 
	show_type,
	title,
	release_year,
	rating
	FROM OriginalData
	WHERE country='Colombia' AND rating='PG' 

SELECT 
	show_type,
	title,
	release_year,
	country
	rating
	FROM OriginalData
	WHERE country='Colombia' OR country='India' and release_year BETWEEN '2000' AND '2010' 
	ORDER BY country ASC

SELECT
	show_type,
	title,
	country,
	release_year,
	rating
	FROM OriginalData
	WHERE date_added BETWEEN '2020-01-01'  AND '2020-11-01';   --  Dates need to be in single quotes --

SELECT * FROM OriginalData

-- USING UNIONS --
USE Exercise1_DML_DDL
SELECT * FROM ZipCode_Income

SELECT 
	ZipCode,
	State,
	Population,
	FamilyIncome
	FROM ZipCode_Income
	WHERE FamilyIncome>25000
UNION
SELECT
	ZipCode,
	State,
	Population,
	FamilyIncome
	FROM ZipCode_Income
	WHERE Population>4000
ORDER BY State;

--INTERSECT --  Not done yet


SELECT* FROM StudentTable1;
