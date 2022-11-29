SELECT * FROM shark_tank;
SELECT COUNT(*) FROM shark_tank;

-- Total Episodes--

SELECT COUNT(DISTINCT Episode_no) FROM shark_tank;
SELECT MAX(Episode_no) FROM shark_tank;

-- CALCULATE NO. OF PITCHES--

SELECT COUNT(DISTINCT Brand) FROM shark_tank;

-- TOTAL NO. OF STARTSUPS WHICH GOT FUNDING --

SELECT SUM(a.CONVERTED_NOT_CONVERTED) AS funding_received, COUNT(*) AS total_pitches FROM
(
SELECT Amount_invested_lakhs ,
  case when Amount_invested_lakhs>0 then 1 else 0
  END AS CONVERTED_NOT_CONVERTED
  FROM shark_tank) a;
  
  -- TOTAL % OF STARTSUPS WHICH GOT FUNDING --
  
  SELECT CAST(SUM(a.CONVERTED_NOT_CONVERTED) AS FLOAT) / CAST(COUNT(*) AS FLOAT) FROM
(
SELECT Amount_invested_lakhs ,
  case when Amount_invested_lakhs>0 then 1 else 0
  END AS CONVERTED_NOT_CONVERTED
  FROM shark_tank) a;
  
  -- Total male --
  
  SELECT SUM(MALE) FROM shark_tank;
  
 -- Total female --
 
  SELECT SUM(FEMALE) FROM shark_tank;
  
  -- GENDER RATIO--
  
  SELECT SUM(FEMALE)/SUM(MALE) FROM shark_tank;
  SELECT SUM(MALE)/SUM(FEMALE) FROM shark_tank;
  
  -- Total amount invested --
  
  select sum(Amount_invested_lakhs) from shark_tank;
  
  -- Average Equity taken -- 
  
  SELECT avg(a.Equity_Taken) from (SELECT Equity_Taken FROM shark_tank WHERE Equity_Taken>0) a;
  
  -- Highest deal taken
  
  SELECT MAX(Amount_invested_lakhs) FROM shark_tank;
  
   -- Highest Equity taken
   
  SELECT MAX(Equity_Taken) FROM shark_tank;
  
  -- Finding out no. of business who had atleast 1 women--
  
  SELECT SUM(FEMALE_COUNT) FROM (SELECT FEMALE,
   CASE WHEN FEMALE>0 THEN 1 ELSE 0
   END AS FEMALE_COUNT
   FROM shark_tank) a;
  
  --  Finding out no. converetd pitches who had atleast 1 women--

SELECT * FROM shark_tank WHERE FEMALE>0 AND DEAL!="NO DEAL";

-- Find out total number of average team members--

SELECT AVG(Team_members) from shark_tank;

-- Avg amount invested in a deal --

SELECT avg(a.amount_invested_lakhs) AS avg_amount_invested_per_deal 
FROM 
(SELECT * FROM shark_tank WHERE DEAL!="NO DEAL") a;

-- Avg age group of contestants--

SELECT AVG_AGE,COUNT(AVG_AGE) AS AVG_AGE_COUNT FROM shark_tank GROUP BY AVG_AGE;

-- Location group of contestants -- 

SELECT Location, COUNT(Location) as Location_COUNT FROM shark_tank GROUP BY Location order by Location_COUNT desc;

-- SECTOR GROUP OF CONTESTANT--

SELECT Sector, COUNT(Sector) as Sector_COUNT FROM shark_tank GROUP BY Sector order by Sector_COUNT desc;

-- LIST OF START UPS IN DIFFERENT SECTORS WHERE HIGHEST AMOUNT HAS BEEN INVESTED --

SELECT BRAND, SECTOR, AMOUNT_INVESTED_LAKHS, RANK() OVER(PARTITION BY SECTOR ORDER BY AMOUNT_INVESTED_LAKHS DESC) RNK FROM shark_tank;

-- Rank 1 data--

SELECT c.* from
(SELECT BRAND, SECTOR, AMOUNT_INVESTED_LAKHS, RANK() OVER(PARTITION BY SECTOR ORDER BY AMOUNT_INVESTED_LAKHS DESC) RNK FROM shark_tank) c 
where c.rnk=1;