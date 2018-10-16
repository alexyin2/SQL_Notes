-- SQL Notes
-- In SQL, this is the way of adding remarks.
-- In the command line of this note, 


mysql-ctl start
-- Start MySQL user monitor
mysql-ctl cli
mysql-ctl stop


help;
help content;


-- Sometimes there are warnings shown, we can run the following code to get more detail about it.
SHOW WARNINGS;


-- Show all the databases now in SQL.
show databases;
show @@hostname;


-- Create database
CREATE DATABASE <database name>;
-- Delete database
DROP DATABASE <database name>;


-- Select which database we will like to edit.
USE <database name>;
-- Show the database that are using now.
SELECT DATABASE();


-- Create a table in a database and remember that we have to first select a database to edit.
-- We can also set a default for each column.
-- When setting the columns, we can add NOT NULL in it.
-- Setting NOT NULL means that data in the column cannot be NULL.
-- In common condition, when we insert data into a table, those columns which are not given a data and don’t have a default will show NULL.
-- However, If we set the columns to be NOT NULL, those columns which are not given a data and don’t have a default cannot show NULL.
-- It will return 0 if the type of the column is integer and nothing if the type of the column is character.

CREATE TABLE <tablename>(
	<column_name> data_type NOT NULL DEFAULT <default>, 
	<column_name> data_type);

-- Next we’ll introduce an important term: Primary Key.
-- Column which are setted to be primary key means that the data in it cannot be the same.
-- We’ll use an example:
CREATE TABLE unique_cats(
	cat_id INT NOT NULL, 
	name VARCHAR(50), 
	age INT, 
	PRIMARY KEY (cat_id));
-- Besides, there’s another way of defining PRIMARY KEY
CREATE TABLE unique_cats(
	cat_id INT NOT NULL PRIMARY KEY, 
	name VARCHAR(50), 
	age INT);

-- Mostly it may be a pain to insert data which are just a sequence like 1, 2, 3, .... etc.
-- So there’s a command to solve this problem: AUTO_INCREMENT
-- Here’s the example:
CREATE TABLE unique_cats(
	cat_id INT NOT NULL AUTO_INCREMENT, 
	name VARCHAR(50), 
	age INT, 
	PRIMARY KEY (cat_id));


-- Delete table
DROP TABLE <tablename>;


-- Show all tables
SHOW TABLES;


-- Show the column names and data type in the table
SHOW COLUMNS FROM <tablename>;
-- Or we can use
DESC <tablename>;


-- Insert data into table
INSERT INTO <tablename>(<column_name>, <column_name>) VALUES (<data_name>, <data_name>);
-- Here is the example
INSERT INTO cats(name, age) VALUES('Ugly', 1);
-- There’s another example to insert a lot of rows at a time.
INSERT INTO cats(name, age) 
VALUES('Ugly', 1), 
	('Black', 3), 
	('Orange', 3);

-- After we’ve inserted the data, how do we show it?
SELECT * FROM <table_name>;
-- Instead of showing the whole data, we can also select specific columns.
SELECT <colname1>, <colname2> FROM <table_name>;


-- For a more specific way like selecting special names or something, we’ll use WHERE.
SELECT * FROM <table_name> WHERE <colname>=x; 

-- If we want to rename the column that we call out. We can use AS.
SELECT <colname> AS <new_colname> FROM <table_name>;


-- When using WHERE, sometimes there's a little problem.
-- For example, if we would like to find data that contains some specific strings, then using WHERE is not enough.
-- We'll introduce LIKE, which allows us to have more options of selecting data.
SELECT * FROM books WHERE author_fname LIKE '%da%';
-- The above command will select any data that contains 'da' in it's column author_fname.
-- Notice that 'DA', 'Da', 'da', 'dA' will all be selected.
-- % means that any data. If we only use 'da%', then only data that starts with 'da' will be selected.
-- There's another quite useful method
SELECT stock_quantity FROM books WHERE stock_quantity LIKE '____';
-- The above command means that we want to find data which has four digits in stock_quantitiy because we use four underscores.



-- We can also change existing data by UPDATE.
-- Remeber that before changing the data, it's better to first use SELECT to check that our logic is right.
-- Suppose we want to change the data from x to y.
UPDATE <table_name> SET <colname>=y WHERE <colname>=x;
-- Here’s another example: Change the data which are 'Tabby' in column 'breed' into 'Shorthair'.
UPDATE cats SET breed='Shorthair' WHERE breed='Tabby';
-- More examples: Change age to 14 for those data which has 'Misty' in the column 'name'.
UPDATE cats SET age=14 WHERE name='Misty';


-- Deleting data is quite similar to Selecting data.
-- Here are the examples:
DELETE FROM <table_name> WHERE <colname>=x;
-- Notice that the above code will delete rows which data in <col_name> is x.

-- Delete everything in a table
DELETE FROM <table_name>;


-- We can run commands from from a sql file since it helps a lot on editing our format.
-- Notice that before running sql files, we have to make sure that we're in the right place of the working directory.
SOURCE <file_name>.sql;
-- If we've got a bunch of different sql files in different directories, we can also add them in our command to run them.
-- Here's an example:
SOURCE /Users/alex/Desktop/test.sql;


-- Next, we'll introduce a new command: CONCAT
-- It combines data for cleaner output.
SELECT 
	CONCAT(<column_name1>, <column_name2>) 
FROM <table_name>;
-- We can also add something between the columns
SELECT 
	CONCAT(<column_name1>, 'any text we want to add', <column_name2>) 
FROM <table_name>;

-- Besides there's another command: CONCAT_WS, which means concat with seperator.
SELECT
	CONCAT_WS('_', <column_name1>, <column_name2>, <column_name3>)
FROM <table_name>;
-- The above command means that all the elements being concatenated will be seperated by '_'.


-- Next we're going to introduce a new command: SUBSTRING.
-- We will use an example to show how it works:
SELECT SUBSTRING('Hello World', 1, 4);
-- The above command means that our target is 'Hello World' and we will subtract the first string to the fourth string. So we will get the output 'Hell'.
-- Let's see another example
SELECT SUBSTRING('Hello World', 7);
-- The above command means that it will subtract the seventh string to the last. So we will get the output 'World'.
-- Then another example if we want to go backwards.
SELECT SUBSTRING('Hello World', -3);
-- The above command will get the output 'rld'.
-- Final example on extracting strings from column.
SELECT SUBSTRING(<column_name>, x, y) FROM <table_name>;


-- Next we'll introduce REPLACE, which replace parts of strings.
-- We will use an example to explain this.
SELECT REPLACE('Hello World', 'Hell', 'GoodBye');
-- The above command will get the output 'GoodBye World'.
-- Another example
SELECT REPLACE('Hello World', 'l', 7);
-- The above command will get the output 'He77o Wor7d'.
-- Final example
SELECT SUBSTRING(<column_name>, 'what we want to change', 'what we want to replace') FROM <table_name>;


-- We can use CONCAT, SUBSTRING and REPLACE together to do more complicated commands.


-- Next we'll introduce CHAR_LENGTH, which counts characters in a string.
SELECT CHAR_LENGTH('text');

-- Next we'll introduce UPPER and LOWER, which changes all the strings to upper case or lower case.
SELECT UPPER('Hello World');
-- We will get the output 'HELLO WORLD'.


-- We'll introduce DISTINCT, which is a very useful command.
SELECT DISTINCT <column_name> FROM <table_name>;
-- Besides only setting one column to be distinct, we can set more columns.
SELECT DISTINCT <column_name1>, <column_name2> FROM <table_name>;
-- The above command means that we want the combine of two columns to be distinct. So if there are two rows in column 1 are the same but different in column 2 then it will still show two rows.


-- We'll introduce sorting data using ORDER BY. The default is ascending.
SELECT <column_name> FROM <table_name> ORDER BY <column_name>;
-- Change ascending to descending.
SELECT <column_name> FROM <table_name> ORDER BY <column_name> DESC;
-- Introduce a more concise way.
SELECT <column_name1>, <column_name2>, <column_name3> FROM books ORDER BY 2;
-- The above command means that we will order the data frame by <column_name2>.
-- We can Also sort by more than one column.
SELECT <column_name> FROM <table_name> ORDER BY <column_name1>, <column_name2>;


-- We'll introduce LIMIT, which sets how many rows we would like to show.
SELECT * FROM <table_name> LIMIT x;
-- We can also specify the rows
SELECT * FROM <table_name> LIMIT x, y;
-- In the above command, x means starting point and y means how many rows we would like to show. Notice that in SQL, the first row start with 0.


-- We'll introduce COUNT.
SELECT COUNT(*) FROM <table_name>;
SELECT COUNT(<column_name>) FROM <table_name>;
SELECT COUNT(DISTINCE <column_name>) FROM <table_name>;
SELECT COUNT(*) FROM <table_name> WHERE <column_name> LIKE '%x%';


-- We'll introduce GROUP BY
-- GROUP BY summaries or aggregates identical data into single rows.
SELECT author_lname, COUNT(*) FROM books GROUP BY author_lname;
-- The COUNT(*) in the above command doesn't mean that it will count the number of total rows. Instead, it will count the number of rows in each group.
-- GROUP BY is a pretty useful command, high recommend to practice more.


-- MIN % MAX
SELECT MIN(<column_name>) FROM <table_name>;
-- However, there may be a problem that we occur.
-- Suppose we want to find out which book has the longest pages.
SELECT MAX(pages), title FROM books;
-- The above command looks fine but we will get the wrong answer.
-- We'll show how to get the output that we want.
SELECT title, pages FROM books WHERE pages = (SELECT MAX(pages) FROM books);
-- There's another way to do what we want and is faster because it doesn't need to do SELECT twice.
SELECT title, pages FROM books ORDER BY pages DESC LIMIT 1;
-- So when will we use GROUP BY?
SELECT CONCAT(author_fname, ' ', author_lname), MIN(released_year) FROM books GROUP BY author_fname, author_lname;


-- We'll introduce SUM
SELECT SUM(<column_name>) FROM <table_name>;
SELECT CONCAT(author_fname, ' ', author_lname), SUM(pages) FROM books
GROUP BY author_fname, author_lname;

-- We'll introduce AVG
SELECT AVG(<column_names>) FROM <table_name>;



-- Introducing data types
-- 1. VAR & VARCHAR, data types that stores 'text'.
-- CHAR has a fixed length, which means that any data we add in has to be of the same length. If less, then SQL will add spaces at right. If more, then it will only take the fixed length from left to right.
-- 2. DECIMAL
CREATE TABLE <table_name>(<column_name> DECIMAL(x, y));
-- x means that the maximum length of the data we insert; y means the length of decimals.
-- Highly recommend to create a column with DECIMAL(x, y) and try to insert some numbers to see how it works.
-- 3. FLOAT & DOUBLE, which stores larger numbers using less space but it comes at the cost of precision when the data's length is larger than 7(FLOAT) or 15(DOUBLE).
-- Instead of using FLOAT & DOUBLE, using DECIMAL is accurate but requires more space to store data.
-- 4. DATE, TIME & DATETIME
-- We'll use a command to show how these three data type looks like.
INSERT INTO people(name, birthdate, birthtime, birthdt)
VALUES('Padma', '19983-11-11', '10:07:35', '19983-11-11 10:07:35');
-- CURDATE(), CURTIME(), NOW(), which are quite useful when creating data.
INSERT INTO people(name, birthdate, birthtime, birthdt)
VALUES('Padma', CURDATE(), CURTIME(), NOW());
-- Notice that there are ways to extract a port of information from DATE, TIME & DATETIME. For example:
SELECT DAY(birthdate) FROM people;
-- A pretty useful way of dealing with date times is to use DATE_FORMAT()
SELECT DATE_FORMAT('2009-10-04 22:23:00', '%W %M %Y');
-- There are lot's of different parameters in DATE_FORMAT() and can be find on the internet.
-- We'll introduce some functions of calculating dates.
SELECT DATEDIFF('2009-10-04', '2009-10-10');
SELECT DATE_ADD('2009-10-04 22:23:00', INTERVAL 1 SECOND);
-- 5. TIMESTAMP
-- The biggest difference of DATETIME and TIMESTAMP is that TIMESTAMP has a range of '1970-01-01' to '2038-01-19' while DATETIME is from year 1000 to 9999.
-- The advantage of using TIMESTAMP is that it takes less space then TIMEDATE.



-- Logical Operators
-- 1. First, we can use not equal and equal to help extract the data we want.
SELECT * FROM <table_name> WHERE <column_name> != x;
-- 2. NOT LIKE
-- We have introduce how to use LIKE before, and of course we can use NOT LIKE.
SELECT title FROM books WHERE title NOT LIKE 'w%';
-- 3. GREATER THAN & LESS THAN
SELECT * FROM books WHERE released_year > 2000;
SELECT 'b' > 'a';
SELECT 'B' > 'a';
-- The above results will all be TRUE because in SQL it thinks that b is later than a in the alphabetical table. And there's no difference for capital and lower case.
-- 4. AND (&&)
SELECT * FROM books WHERE author_lname='Eggers' AND released_year > 2010;
SELECT * FROM books WHERE author_lname='Eggers' && released_year > 2010;
-- Notice that we use && to represent AND in SQL 
-- 5. OR (||)
SELECT * FROM books WHERE author_lname='Eggers' OR released_year > 2010;
SELECT * FROM books WHERE author_lname='Eggers' || released_year > 2010;
-- Notice that we use || to represent OR in SQL, 
-- 6. BETWEEN & NOT BETWEEN
SELECT * FROM books WHERE released_year BETWEEN 2004 AND 2015;
SELECT * FROM books WHERE released_year >= 2004 AND released_year <= 2015;
-- Note that the above two commands has the same meaning, implying that the two elements beside BETWEEN will also be selected.
-- Also remember that the AND in BETWEEN...AND is different from other ANDs, which means that this AND must always apppear after BETWEEN and has a different meaning than other ANDs.
SELECT * FROM books WHERE released_year NOT BETWEEN 2004 AND 2015;
SELECT * FROM books WHERE released_year < 2004 OR released_year > 2015;
-- Note that the above two commands has the same meaning.
-- 7. IN & NOT IN
-- We can use IN to make our task easier when we may use lots of OR.
SELECT * FROM books WHERE author_lname IN ('Carver', 'Lahiri', 'Smith');
-- 8. %
-- % means to get the remainder.
SELECT * FROM books WHERE released_year >= 2000 AND released_year % 2 != 0;
-- 9. Case
-- Case is a really important command that helps to generate new columns relying on existing columns.
SELECT title, released_year, 
	CASE 
		WHEN released_year >= 2000 THEN 'Modern Lit'
		ELSE '20th century Lit'
	END AS Genre
FROM books;
-- We'll give another example.
SELECT title, stock_quantity,
	CASE 
		WHEN stock_quantity BETWEEN 0 AND 50 THEN '*'
		WHEN stock_quantity BETWEEN 51 AND 100 THEN '**'
		ELSE '***'
	END AS Stock
FROM books;











