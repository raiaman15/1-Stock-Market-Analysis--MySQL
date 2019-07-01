-- --------------------------------------------------------------------------------------------------------------------------------------------
-- Loading Data: Data is already loaded using 'Table Data Import Wizard' feature of MySQL Workbench as suggested by TA.
-- While loading data, all default settings were selected.
-- --------------------------------------------------------------------------------------------------------------------------------------------

-- Using `Assignment` database
USE `Assignment`;

-- If UPDATE / DELETE operation is required to be performed, without using keys
-- SET SQL_SAFE_UPDATES = 0;

-- --------------------------------------------------------------------------------------------------------------------------------------------
-- 0. Exploring the dataset i.e. the structure and some content of each table.
-- --------------------------------------------------------------------------------------------------------------------------------------------

-- Analysing Bajaj Auto table
DESCRIBE `bajaj auto`;
SELECT * 
FROM `bajaj auto`
LIMIT 5;

-- Analysing Eicher Motors table
DESCRIBE `eicher motors`;
SELECT * 
FROM `eicher motors`
LIMIT 5;

-- Analysing Hero Motocorp table
DESCRIBE `hero motocorp`;
SELECT * 
FROM `hero motocorp`
LIMIT 5;

-- Analysing Infosys table
DESCRIBE `infosys`;
SELECT * 
FROM `infosys`
LIMIT 5;

-- Analysing TCS table
DESCRIBE `tcs`;
SELECT * 
FROM `tcs`
LIMIT 5;

-- Analysing TVS Motors table
DESCRIBE `tvs motors`;
SELECT * 
FROM `tvs motors`
LIMIT 5;


-- --------------------------------------------------------------------------------------------------------------------------------------------
-- 1. Create a new table named 'bajaj1' containing the date, close price, 20 Day MA and 50 Day MA. 
-- (This has to be done for all 6 stocks)

-- Getting more domain knowledge, I learnt, moving average is calculated on close price for stock analysis.
-- 
-- Thus, filtering the data and ignoring the rows with NULL value in `Close Price` or `Date` colums since question says:
-- 
-- Please note that for the days where it is not possible to calculate the required Moving Averages, it is
-- better to ignore these rows rather than trying to deal with NULL by filling it with average value as 
-- that would make no practical sense.
-- --------------------------------------------------------------------------------------------------------------------------------------------

-- Creating table `bajaj1`
-- Using MySQL function STR_TO_DATE to convert Date format since it is good practice to store date in SQL Date format
-- Using Window function to calculate moving average for 20 days and 50 days
CREATE TABLE `bajaj1` AS
	SELECT 
    STR_TO_DATE(`b`.`Date`, "%d-%M-%Y") as `Date`, 
    `Close Price`, 
    AVG(`Close Price`) OVER (ORDER BY `b`.`Date` ASC ROWS 19 PRECEDING) AS `20 Day MA`,
    AVG(`Close Price`) OVER (ORDER BY `b`.`Date` ASC ROWS 49 PRECEDING) AS `50 Day MA`
    FROM `bajaj auto` `b`
    WHERE `Close Price` IS NOT NULL AND `b`.`Date` IS NOT NULL;
-- Setting `Date` as Primary Key also to improve performance as operations using keys are much faster due to indexing
ALTER TABLE `bajaj1`
	ADD PRIMARY KEY (`Date`);

-- Creating table `eicher1`
-- Using MySQL function STR_TO_DATE to convert Date format since it is good practice to store date in SQL Date format
-- Using Window function to calculate moving average for 20 days and 50 days
CREATE TABLE `eicher1` AS
	SELECT 
    STR_TO_DATE(`e`.`Date`, "%d-%M-%Y") as `Date`, 
    `Close Price`, 
    AVG(`Close Price`) OVER (ORDER BY `e`.`Date` ASC ROWS 19 PRECEDING) AS `20 Day MA`,
    AVG(`Close Price`) OVER (ORDER BY `e`.`Date` ASC ROWS 49 PRECEDING) AS `50 Day MA`
    FROM `eicher motors` `e`
    WHERE `Close Price` IS NOT NULL AND `e`.`Date` IS NOT NULL;
-- Setting `Date` as Primary Key also to improve performance as operations using keys are much faster due to indexing
ALTER TABLE `eicher1`
	ADD PRIMARY KEY (`Date`);

-- Creating table `hero1`
-- Using MySQL function STR_TO_DATE to convert Date format since it is good practice to store date in SQL Date format
-- Using Window function to calculate moving average for 20 days and 50 days
CREATE TABLE `hero1` AS
	SELECT 
    STR_TO_DATE(`h`.`Date`, "%d-%M-%Y") as `Date`, 
    `Close Price`, 
    AVG(`Close Price`) OVER (ORDER BY `h`.`Date` ASC ROWS 19 PRECEDING) AS `20 Day MA`,
    AVG(`Close Price`) OVER (ORDER BY `h`.`Date` ASC ROWS 49 PRECEDING) AS `50 Day MA`
    FROM `hero motocorp` `h`
    WHERE `Close Price` IS NOT NULL AND `h`.`Date` IS NOT NULL;
-- Setting `Date` as Primary Key also to improve performance as operations using keys are much faster due to indexing
ALTER TABLE `hero1`
	ADD PRIMARY KEY (`Date`);

-- Creating table `infosys1`
-- Using MySQL function STR_TO_DATE to convert Date format since it is good practice to store date in SQL Date format
-- Using Window function to calculate moving average for 20 days and 50 days
CREATE TABLE `infosys1` AS
	SELECT 
    STR_TO_DATE(`i`.`Date`, "%d-%M-%Y") as `Date`, 
    `Close Price`, 
    AVG(`Close Price`) OVER (ORDER BY `i`.`Date` ASC ROWS 19 PRECEDING) AS `20 Day MA`,
    AVG(`Close Price`) OVER (ORDER BY `i`.`Date` ASC ROWS 49 PRECEDING) AS `50 Day MA`
    FROM `infosys` `i`
    WHERE `Close Price` IS NOT NULL AND `i`.`Date` IS NOT NULL;
-- Setting `Date` as Primary Key also to improve performance as operations using keys are much faster due to indexing
ALTER TABLE `infosys1`
	ADD PRIMARY KEY (`Date`);

-- Creating table `tcs1`
-- Using MySQL function STR_TO_DATE to convert Date format since it is good practice to store date in SQL Date format
-- Using Window function to calculate moving average for 20 days and 50 days
CREATE TABLE `tcs1` AS
	SELECT 
    STR_TO_DATE(`t`.`Date`, "%d-%M-%Y") as `Date`, 
    `Close Price`, 
    AVG(`Close Price`) OVER (ORDER BY `t`.`Date` ASC ROWS 19 PRECEDING) AS `20 Day MA`,
    AVG(`Close Price`) OVER (ORDER BY `t`.`Date` ASC ROWS 49 PRECEDING) AS `50 Day MA`
    FROM `tcs` `t`
    WHERE `Close Price` IS NOT NULL AND `t`.`Date` IS NOT NULL;
-- Setting `Date` as Primary Key also to improve performance as operations using keys are much faster due to indexing
ALTER TABLE `tcs1`
	ADD PRIMARY KEY (`Date`);

-- Creating table `tvs1`
-- Using MySQL function STR_TO_DATE to convert Date format since it is good practice to store date in SQL Date format
-- Using Window function to calculate moving average for 20 days and 50 days
CREATE TABLE `tvs1` AS
	SELECT 
    STR_TO_DATE(`t`.`Date`, "%d-%M-%Y") as `Date`, 
    `Close Price`, 
    AVG(`Close Price`) OVER (ORDER BY `t`.`Date` ASC ROWS 19 PRECEDING) AS `20 Day MA`,
    AVG(`Close Price`) OVER (ORDER BY `t`.`Date` ASC ROWS 49 PRECEDING) AS `50 Day MA`
    FROM `tvs motors` `t`
    WHERE `Close Price` IS NOT NULL AND `t`.`Date` IS NOT NULL;
-- Setting `Date` as Primary Key also to improve performance as operations using keys are much faster due to indexing
ALTER TABLE `tvs1`
	ADD PRIMARY KEY (`Date`);


-- --------------------------------------------------------------------------------------------------------------------------------------------
-- 2. Create a master table containing the date and close price of all the six stocks.
-- (Column header for the price is the name of the stock)

-- This could be accomplished using join operation if all dates were matching. 
-- But, upon analysis, we found we have mismatching dates. Mismatching date: "2015-12-09", "2017-08-31"
-- If we try using INNER JOIN ON `Date`, that would skip the dates which are not present in first stock data.

-- Alternatively we would have used following combination of queries to ensure all rows are present in master table:
-- Create master table
-- Insert distinct date in master table from all 6 stocks
-- Insert value of closing price from all 6 stocks into master table for corresponding date

-- I am continuing with INNER JOIN ON `Date` to avoid NULL values in stock columns and amount of rows lost is 2 out of 889 is very small.
-- Since the JOIN is on `Date` which is the primary key in all 6 stock tables, the operation is optimized.
-- --------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE `master` AS
	SELECT
    `baj`.`Date`		AS `Date`, 
    `baj`.`Close Price` AS `Bajaj`,
    `tcs`.`Close Price` AS `TCS`,
    `tvs`.`Close Price` AS `TVS`,
    `inf`.`Close Price` AS `Infosys`,
    `eic`.`Close Price` AS `Eicher`,
    `her`.`Close Price` AS `Hero`
    FROM `bajaj1` `baj` 
    INNER JOIN `tcs1` 		`tcs` 	ON `baj`.`Date`=`tcs`.`Date`
    INNER JOIN `tvs1` 		`tvs` 	ON `tcs`.`Date`=`tvs`.`Date`
    INNER JOIN `infosys1` 	`inf` 	ON `tvs`.`Date`=`inf`.`Date`
    INNER JOIN `eicher1` 	`eic` 	ON `inf`.`Date`=`eic`.`Date`
    INNER JOIN `hero1` 		`her` 	ON `eic`.`Date`=`her`.`Date`;

-- --------------------------------------------------------------------------------------------------------------------------------------------
-- 3. Use the table created in Part(1) to generate buy and sell signal. 
-- Store this in another table named 'bajaj2'. Perform this operation for all stocks.

-- This could be accomplished using LAG() Window function. ROW_NUMBER() Window function is required to ignore initial rows with false moving average.
-- --------------------------------------------------------------------------------------------------------------------------------------------

-- Creating table `bajaj2`
-- Using LAG funcion to get values from the previous row and make decision (Hold/Sell/Buy)
-- Using ROW_NUMBER() to count and ignore first 50 rows as they will have false moving average
-- When the shorter-term moving average crosses above the longer-term moving average, it is a signal to BUY
-- When the shorter term moving average crosses below the longer term moving average, it is a signal to SELL
CREATE TABLE `bajaj2` AS
	SELECT 
    `Date`,
    `Close Price`,
    (CASE
		WHEN ROW_NUMBER() OVER(ORDER BY `Date`) < 50 THEN "Hold"
        WHEN LAG(`20 Day MA`,1) OVER(ORDER BY `Date`) > LAG(`50 Day MA`,1) OVER(ORDER BY `Date`) AND `20 Day MA` < `50 Day MA` THEN "Sell"
        WHEN LAG(`20 Day MA`,1) OVER(ORDER BY `Date`) < LAG(`50 Day MA`,1) OVER(ORDER BY `Date`) AND `20 Day MA` > `50 Day MA` THEN "Buy"
        ELSE "Hold"
	END) AS `Signal`
    FROM `bajaj1`;
-- Setting `Date` as Primary Key also to improve performance as operations using keys are much faster due to indexing
ALTER TABLE `bajaj2`
	ADD PRIMARY KEY (`Date`);

-- Creating table `eicher2`
-- Using LAG funcion to get values from the previous row and make decision (Hold/Sell/Buy)
-- Using ROW_NUMBER() to count and ignore first 50 rows as they will have false moving average
-- When the shorter-term moving average crosses above the longer-term moving average, it is a signal to BUY
-- When the shorter term moving average crosses below the longer term moving average, it is a signal to SELL
CREATE TABLE `eicher2` AS
	SELECT 
    `Date`,
    `Close Price`,
    (CASE
		WHEN ROW_NUMBER() OVER(ORDER BY `Date`) < 50 THEN "Hold"
        WHEN LAG(`20 Day MA`,1) OVER(ORDER BY `Date`) > LAG(`50 Day MA`,1) OVER(ORDER BY `Date`) AND `20 Day MA` < `50 Day MA` THEN "Sell"
        WHEN LAG(`20 Day MA`,1) OVER(ORDER BY `Date`) < LAG(`50 Day MA`,1) OVER(ORDER BY `Date`) AND `20 Day MA` > `50 Day MA` THEN "Buy"
        ELSE "Hold"
	END) AS `Signal`
    FROM `eicher1`;
-- Setting `Date` as Primary Key also to improve performance as operations using keys are much faster due to indexing
ALTER TABLE `eicher2`
	ADD PRIMARY KEY (`Date`);

-- Creating table `hero2`
-- Using LAG funcion to get values from the previous row and make decision (Hold/Sell/Buy)
-- Using ROW_NUMBER() to count and ignore first 50 rows as they will have false moving average
-- When the shorter-term moving average crosses above the longer-term moving average, it is a signal to BUY
-- When the shorter term moving average crosses below the longer term moving average, it is a signal to SELL

CREATE TABLE `hero2` AS
	SELECT 
    `Date`,
    `Close Price`,
    (CASE
		WHEN ROW_NUMBER() OVER(ORDER BY `Date`) < 50 THEN "Hold"
        WHEN LAG(`20 Day MA`,1) OVER(ORDER BY `Date`) > LAG(`50 Day MA`,1) OVER(ORDER BY `Date`) AND `20 Day MA` < `50 Day MA` THEN "Sell"
        WHEN LAG(`20 Day MA`,1) OVER(ORDER BY `Date`) < LAG(`50 Day MA`,1) OVER(ORDER BY `Date`) AND `20 Day MA` > `50 Day MA` THEN "Buy"
        ELSE "Hold"
	END) AS `Signal`
    FROM `hero1`;
-- Setting `Date` as Primary Key also to improve performance as operations using keys are much faster due to indexing
ALTER TABLE `hero2`
	ADD PRIMARY KEY (`Date`);

-- Creating table `infosys2`
-- Using LAG funcion to get values from the previous row and make decision (Hold/Sell/Buy)
-- Using ROW_NUMBER() to count and ignore first 50 rows as they will have false moving average
-- When the shorter-term moving average crosses above the longer-term moving average, it is a signal to BUY
-- When the shorter term moving average crosses below the longer term moving average, it is a signal to SELL

CREATE TABLE `infosys2` AS
	SELECT 
    `Date`,
    `Close Price`,
    (CASE
		WHEN ROW_NUMBER() OVER(ORDER BY `Date`) < 50 THEN "Hold"
        WHEN LAG(`20 Day MA`,1) OVER(ORDER BY `Date`) > LAG(`50 Day MA`,1) OVER(ORDER BY `Date`) AND `20 Day MA` < `50 Day MA` THEN "Sell"
        WHEN LAG(`20 Day MA`,1) OVER(ORDER BY `Date`) < LAG(`50 Day MA`,1) OVER(ORDER BY `Date`) AND `20 Day MA` > `50 Day MA` THEN "Buy"
        ELSE "Hold"
	END) AS `Signal`
    FROM `infosys1`;
-- Setting `Date` as Primary Key also to improve performance as operations using keys are much faster due to indexing
ALTER TABLE `infosys2`
	ADD PRIMARY KEY (`Date`);

-- Creating table `tcs2`
-- Using LAG funcion to get values from the previous row and make decision (Hold/Sell/Buy)
-- Using ROW_NUMBER() to count and ignore first 50 rows as they will have false moving average
-- When the shorter-term moving average crosses above the longer-term moving average, it is a signal to BUY
-- When the shorter term moving average crosses below the longer term moving average, it is a signal to SELL

CREATE TABLE `tcs2` AS
	SELECT 
    `Date`,
    `Close Price`,
    (CASE
		WHEN ROW_NUMBER() OVER(ORDER BY `Date`) < 50 THEN "Hold"
        WHEN LAG(`20 Day MA`,1) OVER(ORDER BY `Date`) > LAG(`50 Day MA`,1) OVER(ORDER BY `Date`) AND `20 Day MA` < `50 Day MA` THEN "Sell"
        WHEN LAG(`20 Day MA`,1) OVER(ORDER BY `Date`) < LAG(`50 Day MA`,1) OVER(ORDER BY `Date`) AND `20 Day MA` > `50 Day MA` THEN "Buy"
        ELSE "Hold"
	END) AS `Signal`
    FROM `tcs1`;
-- Setting `Date` as Primary Key also to improve performance as operations using keys are much faster due to indexing
ALTER TABLE `tcs2`
	ADD PRIMARY KEY (`Date`);

-- Creating table `tvs2`
-- Using LAG funcion to get values from the previous row and make decision (Hold/Sell/Buy)
-- Using ROW_NUMBER() to count and ignore first 50 rows as they will have false moving average
-- When the shorter-term moving average crosses above the longer-term moving average, it is a signal to BUY
-- When the shorter term moving average crosses below the longer term moving average, it is a signal to SELL

CREATE TABLE `tvs2` AS
	SELECT 
    `Date`,
    `Close Price`,
    (CASE
		WHEN ROW_NUMBER() OVER(ORDER BY `Date`) < 50 THEN "Hold"
        WHEN LAG(`20 Day MA`,1) OVER(ORDER BY `Date`) > LAG(`50 Day MA`,1) OVER(ORDER BY `Date`) AND `20 Day MA` < `50 Day MA` THEN "Sell"
        WHEN LAG(`20 Day MA`,1) OVER(ORDER BY `Date`) < LAG(`50 Day MA`,1) OVER(ORDER BY `Date`) AND `20 Day MA` > `50 Day MA` THEN "Buy"
        ELSE "Hold"
	END) AS `Signal`
    FROM `tvs1`;
-- Setting `Date` as Primary Key also to improve performance as operations using keys are much faster due to indexing
ALTER TABLE `tvs2`
	ADD PRIMARY KEY (`Date`);


-- --------------------------------------------------------------------------------------------------------------------------------------------
-- 4. Create a User defined function, that takes the date as input and returns the signal for that particular day (Buy/Sell/Hold) for the Bajaj stock.

-- This could be accomplished using UDF that returns result of a SELECT query on bajaj2 table.
-- --------------------------------------------------------------------------------------------------------------------------------------------

-- Dropping the UDF if it exists
drop function if exists bajaj_signal_for_date;

-- Creating the UDF to get Signal (Buy/Sell/Hold) for a date
DELIMITER $$
create function bajaj_signal_for_date(input_date date) 
  returns varchar(20)
  deterministic
begin
return (SELECT `Signal` FROM `bajaj2` where `Date` = input_date);
end $$
DELIMITER ;

-- Testing a few values "2016-06-29" expecting "Sell"
select bajaj_signal_for_date("2016-06-29") as `Signal`;
-- Testing a few values "2016-06-30" expecting "Buy"
select bajaj_signal_for_date("2016-06-30") as `Signal`;
-- Testing a few values "2016-07-01" expecting "Hold"
select bajaj_signal_for_date("2016-07-01") as `Signal`;




-- --------------------------------------------------------------------------------------------------------------------------------------------
-- 5. Write a brief summary of the results obtained and what inferences you can draw from the analysis performed. 
-- (Less than 250 words to be submitted in a pdf file)

-- Collecting various facts from our records for writing summary of analysis.
-- --------------------------------------------------------------------------------------------------------------------------------------------

-- Analysing percentage of Signal for Bajaj | Inference: Hold 56.08% | Sell 22.85% | Buy 22.07%
SELECT `Signal`, ROUND(100*(COUNT(`Signal`)/(Select Count(*) From `bajaj2`)),2) 	AS `Signal Percentage`
FROM `bajaj2`
GROUP BY(`Signal`);
-- Analysing percentage of Signal for Eicher | Inference: Hold 62.73% | Sell 18.81% | Buy 18.47%
SELECT `Signal`, ROUND(100*(COUNT(`Signal`)/(Select Count(*) From `eicher2`)),2) 	AS `Signal Percentage`
FROM `eicher2`
GROUP BY(`Signal`);
-- Analysing percentage of Signal for Hero | Inference: Hold 57.32% | Sell 21.51% | Buy 21.17%
SELECT `Signal`, ROUND(100*(COUNT(`Signal`)/(Select Count(*) From `hero2`)),2) 		AS `Signal Percentage`
FROM `hero2`
GROUP BY(`Signal`);
-- Analysing percentage of Signal for Infosys | Inference: Hold 55.86% | Sell 22.41% | Buy 21.73%
SELECT `Signal`, ROUND(100*(COUNT(`Signal`)/(Select Count(*) From `infosys2`)),2) 	AS `Signal Percentage`
FROM `infosys2`
GROUP BY(`Signal`);
-- Analysing percentage of Signal for TCS | Inference: Hold 61.04% | Sell 19.82% | Buy 19.14%
SELECT `Signal`, ROUND(100*(COUNT(`Signal`)/(Select Count(*) From `tcs2`)),2) 		AS `Signal Percentage`
FROM `tcs2`
GROUP BY(`Signal`);
-- Analysing percentage of Signal for TVS | Inference: Hold 56.98% | Sell 21.62% | Buy 21.40%
SELECT `Signal`, ROUND(100*(COUNT(`Signal`)/(Select Count(*) From `tvs2`)),2) 		AS `Signal Percentage`
FROM `tvs2`
GROUP BY(`Signal`);


-- --------------------------------------------------------------------------------------------------------------------------------------------

-- Analysing maximum, minimum, standard deviation of Close Price for all stocks

-- Inference: None
SELECT "Bajaj" 		AS `Stock`, MIN(`Close Price`) AS `MIN`, MAX(`Close Price`) AS `MAX`, ROUND(STDDEV(`Close Price`),2) AS `STD DEVIATION`
FROM `bajaj2`
UNION
SELECT "Eicher" 	AS `Stock`, MIN(`Close Price`) AS `MIN`, MAX(`Close Price`) AS `MAX`, ROUND(STDDEV(`Close Price`),2) AS `STD DEVIATION`
FROM `eicher2`
UNION
SELECT "Hero" 		AS `Stock`, MIN(`Close Price`) AS `MIN`, MAX(`Close Price`) AS `MAX`, ROUND(STDDEV(`Close Price`),2) AS `STD DEVIATION`
FROM `hero2`
UNION
SELECT "Infosys" 	AS `Stock`, MIN(`Close Price`) AS `MIN`, MAX(`Close Price`) AS `MAX`, ROUND(STDDEV(`Close Price`),2) AS `STD DEVIATION`
FROM `infosys2`
UNION
SELECT "TCS" 		AS `Stock`, MIN(`Close Price`) AS `MIN`, MAX(`Close Price`) AS `MAX`, ROUND(STDDEV(`Close Price`),2) AS `STD DEVIATION`
FROM `tcs2`
UNION
SELECT "TVS" 		AS `Stock`, MIN(`Close Price`) AS `MIN`, MAX(`Close Price`) AS `MAX`, ROUND(STDDEV(`Close Price`),2) AS `STD DEVIATION`
FROM `tvs2`;


-- --------------------------------------------------------------------------------------------------------------------------------------------

-- Analysing the variation in Close Price with respect to time (YEAR from Date) &  (QUARTER FROM Date)

-- Inference: Bajaj Auto had its lowest average Close Price in second quarter of 2015, and, highest average in fourth quarter of 2017.
SELECT 
EXTRACT(YEAR FROM `Date`)		AS `Year`, 
EXTRACT(QUARTER FROM `Date`)	AS `Quarter`, 
AVG(`Close Price`) 				AS `Average Closing Price`
FROM `bajaj2`
GROUP BY `Year`, `Quarter`
ORDER BY AVG(`Close Price`) DESC;
-- Inference: Eicher Motors had its lowest average Close Price in first quarter of 2015, and, highest average in fourth quarter of 2017.
SELECT 
EXTRACT(YEAR FROM `Date`)		AS `Year`, 
EXTRACT(QUARTER FROM `Date`)	AS `Quarter`, 
AVG(`Close Price`) 				AS `Average Closing Price`
FROM `eicher2`
GROUP BY `Year`, `Quarter`
ORDER BY AVG(`Close Price`) DESC;
-- Inference: Hero Motocorp had its lowest average Close Price in second quarter of 2015, and, highest average in third quarter of 2017.
SELECT 
EXTRACT(YEAR FROM `Date`)		AS `Year`, 
EXTRACT(QUARTER FROM `Date`)	AS `Quarter`, 
AVG(`Close Price`) 				AS `Average Closing Price`
FROM `hero2`
GROUP BY `Year`, `Quarter`
ORDER BY AVG(`Close Price`) DESC;
-- Inference: Infosys had its lowest average Close Price in third quarter of 2017, and, highest average in first quarter of 2015.
SELECT 
EXTRACT(YEAR FROM `Date`)		AS `Year`, 
EXTRACT(QUARTER FROM `Date`)	AS `Quarter`, 
AVG(`Close Price`) 				AS `Average Closing Price`
FROM `infosys2`
GROUP BY `Year`, `Quarter`
ORDER BY AVG(`Close Price`) DESC;
-- Inference: TCS had its lowest average Close Price in third quarter of 2018, and, highest average in first quarter of 2018.
SELECT 
EXTRACT(YEAR FROM `Date`)		AS `Year`, 
EXTRACT(QUARTER FROM `Date`)	AS `Quarter`, 
AVG(`Close Price`) 				AS `Average Closing Price`
FROM `tcs2`
GROUP BY `Year`, `Quarter`
ORDER BY AVG(`Close Price`) DESC;
-- Inference: TVS Motors had its lowest average Close Price in second quarter of 2015, and, highest average in fourth quarter of 2017.
SELECT 
EXTRACT(YEAR FROM `Date`)		AS `Year`, 
EXTRACT(QUARTER FROM `Date`)	AS `Quarter`, 
AVG(`Close Price`) 				AS `Average Closing Price`
FROM `tvs2`
GROUP BY `Year`, `Quarter`
ORDER BY AVG(`Close Price`) DESC;

-- Combined Inference: Companies in automobile sector (Bajaj Auto, Eicher Motors, Hero Motocorp, TVS Motors) 
-- had high average close price in first-second quarter of 2015 and low average close in third-fourth quarter of 2017


-- --------------------------------------------------------------------------------------------------------------------------------------------

-- Analysing the variation in Signal with respect to time (YEAR from Date) &  (QUARTER FROM Date)

-- Inference: Bajaj Auto stock prices went up by 26.84% from January, 2015 to July, 2018.
SELECT 
EXTRACT(YEAR FROM `Date`)
AS `Year`, 
AVG(`Close Price`)-(SELECT AVG(`Close Price`) FROM `bajaj2`WHERE EXTRACT(YEAR FROM `Date`)=2015)
AS `Average Close Price Change`,
100*((AVG(`Close Price`)-(SELECT AVG(`Close Price`) FROM `bajaj2`WHERE EXTRACT(YEAR FROM `Date`)=2015))/(SELECT AVG(`Close Price`) FROM `bajaj2`WHERE EXTRACT(YEAR FROM `Date`)=2015))
AS `Average Close Price Change Percentage`
FROM `bajaj2`
GROUP BY `Year`;

-- Inference: Eicher Motors stock prices went up by 65.59% from January, 2015 to July, 2018.
SELECT 
EXTRACT(YEAR FROM `Date`)
AS `Year`, 
AVG(`Close Price`)-(SELECT AVG(`Close Price`) FROM `eicher2`WHERE EXTRACT(YEAR FROM `Date`)=2015)
AS `Average Close Price Change`,
100*((AVG(`Close Price`)-(SELECT AVG(`Close Price`) FROM `eicher2`WHERE EXTRACT(YEAR FROM `Date`)=2015))/(SELECT AVG(`Close Price`) FROM `eicher2`WHERE EXTRACT(YEAR FROM `Date`)=2015))
AS `Average Close Price Change Percentage`
FROM `eicher2`
GROUP BY `Year`;

-- Inference: Hero Motocorp stock prices went up by 37.96% from January, 2015 to July, 2018.
SELECT 
EXTRACT(YEAR FROM `Date`)
AS `Year`, 
AVG(`Close Price`)-(SELECT AVG(`Close Price`) FROM `hero2`WHERE EXTRACT(YEAR FROM `Date`)=2015)
AS `Average Close Price Change`,
100*((AVG(`Close Price`)-(SELECT AVG(`Close Price`) FROM `hero2`WHERE EXTRACT(YEAR FROM `Date`)=2015))/(SELECT AVG(`Close Price`) FROM `hero2`WHERE EXTRACT(YEAR FROM `Date`)=2015))
AS `Average Close Price Change Percentage`
FROM `hero2`
GROUP BY `Year`;

-- Inference: Infosys stock prices went down by 23.03% from January, 2015 to July, 2018.
SELECT 
EXTRACT(YEAR FROM `Date`)
AS `Year`, 
AVG(`Close Price`)-(SELECT AVG(`Close Price`) FROM `infosys2`WHERE EXTRACT(YEAR FROM `Date`)=2015)
AS `Average Close Price Change`,
100*((AVG(`Close Price`)-(SELECT AVG(`Close Price`) FROM `infosys2`WHERE EXTRACT(YEAR FROM `Date`)=2015))/(SELECT AVG(`Close Price`) FROM `infosys2`WHERE EXTRACT(YEAR FROM `Date`)=2015))
AS `Average Close Price Change Percentage`
FROM `infosys2`
GROUP BY `Year`;

-- Inference: TCS stock prices went up by 7.53% from January, 2015 to July, 2018.
SELECT 
EXTRACT(YEAR FROM `Date`)
AS `Year`, 
AVG(`Close Price`)-(SELECT AVG(`Close Price`) FROM `tcs2`WHERE EXTRACT(YEAR FROM `Date`)=2015)
AS `Average Close Price Change`,
100*((AVG(`Close Price`)-(SELECT AVG(`Close Price`) FROM `tcs2`WHERE EXTRACT(YEAR FROM `Date`)=2015))/(SELECT AVG(`Close Price`) FROM `tcs2`WHERE EXTRACT(YEAR FROM `Date`)=2015))
AS `Average Close Price Change Percentage`
FROM `tcs2`
GROUP BY `Year`;

-- Inference: TVS Motors stock prices went up by 144.20% from January, 2015 to July, 2018.
SELECT 
EXTRACT(YEAR FROM `Date`)
AS `Year`, 
AVG(`Close Price`)-(SELECT AVG(`Close Price`) FROM `tvs2`WHERE EXTRACT(YEAR FROM `Date`)=2015)
AS `Average Close Price Change`,
100*((AVG(`Close Price`)-(SELECT AVG(`Close Price`) FROM `tvs2`WHERE EXTRACT(YEAR FROM `Date`)=2015))/(SELECT AVG(`Close Price`) FROM `tvs2`WHERE EXTRACT(YEAR FROM `Date`)=2015))
AS `Average Close Price Change Percentage`
FROM `tvs2`
GROUP BY `Year`;

-- Combined Inference: TVS Motors (with 144.20% up) and Eicher Motors (with 65.59% up) turned out to be good stock options 
-- while Infosys (with 23.03% down) and TCS (with 7.53% up) turned out to be bad stock options for the duration of January 2015 to July 2018.


-- --------------------------------------------------------------------------------------------------------------------------------------------
-- CONCLUSION OF ANALYSIS (ALSO SAVED IN PDF FILE)

-- Companies in the automobile sector (Bajaj Auto, Eicher Motors, Hero Motocorp, TVS Motors) followed a similar trend with high average close price in the first and second quarter of 2015 and low average close price in the third and fourth quarter of 2017.
-- Companies in the IT sector (Infosys and TCS) did not follow a similar trend.
-- Infosys had a high average close price in the first quarter of 2015 and low average close price in the third quarter of 2017.
-- TCS had a high average close price in the first quarter of 2018 and low average close price in the third quarter of 2018.
-- TVS Motors (with 144.20% increase in average stock close price) and Eicher Motors (with 65.59% increase in average stock close price) were good stock options for the duration of January 2015 to July 2018.
-- TCS (with just 7.53% increase in average stock close price) and Infosys (with 23.03% decrease in average stock close price) were bad stock options for the duration of January 2015 to July 2018.
-- Hero Motocorp (with 37.96% increase in average stock close price) and Bajaj (with 26.84% increase in average stock close price) were fair stock options for the duration of January 2015 to July 2018.
-- --------------------------------------------------------------------------------------------------------------------------------------------
