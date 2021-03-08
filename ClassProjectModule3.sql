USE Netflix_Data

SELECT * FROM OriginalData

CREATE TABLE table1 (
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

	CREATE TABLE table2 (
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



-- Splitting the OriginalData table in 2 ---

-- Creating a table selecting some rows from big table --

-- Table1 First 25 rows of the OriginalData table

INSERT INTO table1 (show_id, show_type, title, director, cast, country, date_added, release_year, rating, duration, listed_in, description)
SELECT top 25 
	show_id, show_type, title, director, cast, country, date_added, release_year, rating, duration, listed_in, description
FROM OriginalData

--Table 2 next 25 rowsof the OriginaData table

INSERT INTO table2 (show_id, show_type, title, director, cast, country, date_added, release_year, rating, duration, listed_in, description)
SELECT top 50 
	show_id, show_type, title, director, cast, country, date_added, release_year, rating, duration, listed_in, description
FROM OriginalData


DELETE TOP (25) FROM table2;  -- Remove first 25 rows in table 2 --

SELECT * FROM table1
SELECT * FROM table2

--Splitting a table in 2 by selecting the columns to include in each table --

--  table3: Selected columns from Original Data (show_id, show_type, title, country, release_year, rating) --
--  Table only includes the first 25 rows --

SELECT show_id, show_type, title, country, release_year, rating
FROM OriginalData
CREATE TABLE table3 (
	show_id nvarchar(max),
	show_type nvarchar(max),
	title nvarchar(max),
	country nvarchar(max),
	release_year int,
	rating nvarchar(max));

INSERT INTO table3 (show_id, show_type, title, country, release_year, rating)
SELECT TOP 25 show_id, show_type, title, country, release_year, rating
FROM OriginalData;

SELECT * FROM table3

--  table4:  Rest of the columns but including show_id  (show_id, director, cast, date_added, duration, listed_in, description)
--  Table only includes the first 25 rows --

SELECT show_id, director, cast, date_added, duration, listed_in, description
FROM OriginalData
	CREATE TABLE table4 (
	show_id nvarchar(max),
	director nvarchar(max),
	cast nvarchar(max),
	date_added datetime2,
	duration nvarchar(max),
	listed_in nvarchar(max),
	description nvarchar(max));

INSERT INTO table4
SELECT TOP 25 show_id, director, cast, date_added, duration, listed_in, description
FROM OriginalData;

SELECT* FROM table4


-- Using the UNION Clause --
-- The WHERE statement needs to be included for each table used in the UNION --
-- FOR ROWS --


SELECT show_id, show_type, title, release_year, rating
FROM table1
WHERE release_year BETWEEN 2000 AND 2020
UNION
SELECT show_id, show_type, title, release_year, rating
FROM table2
WHERE release_year BETWEEN 2000 AND 2020
ORDER BY release_year;  

SELECT show_id, show_type, title, release_year, rating
FROM table1
WHERE release_year >=2010
UNION
SELECT show_id, show_type, title, release_year, rating
FROM table2
WHERE release_year >=2010;       

SELECT show_id, show_type, title, release_year, rating
FROM table1
WHERE release_year >=2010 AND rating='TV-14'
UNION
SELECT show_id, show_type, title, release_year, rating
FROM table2
WHERE release_year >=2010 AND rating='TV-14'
ORDER BY release_year;   

SELECT * FROM table1
SELECT * FROM table2


--Using the INTERSECT Clause --
-- FOR ROWS --


SELECT release_year   --to see if both tables have movies and tv shows with the same release year --
FROM table1
INTERSECT
SELECT release_year
FROM table2;


SELECT country     --Countries that appear in both tables
FROM table1
INTERSECT
SELECT country
FROM table2;

-- Except --
-- FOR ROWS --

SELECT release_year   --to see release year not common to both tables--
FROM table1
EXCEPT
SELECT release_year
FROM table2;

--Using the JOIN Clause --
--FOR COLUMNS --

SELECT show_type, title, country, release_year, rating, cast FROM table3 INNER JOIN table4
ON table3.show_id=table4.show_id

SELECT show_type, title, country, release_year, rating, cast FROM table3 LEFT OUTER JOIN table4
ON table3.show_id=table4.show_id
WHERE table3.rating = 'TV-14'

SELECT show_type, title, country, release_year, rating, cast FROM table3 RIGHT OUTER JOIN table4
ON table3.show_id=table4.show_id

SELECT show_type, title, country, release_year, rating, cast FROM table3 FULL OUTER JOIN table4
ON table3.show_id=table4.show_id