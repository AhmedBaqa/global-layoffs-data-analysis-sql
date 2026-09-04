-- ---------------------------------------------
-- Data Cleaning
-- ---------------------------------------------

-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null or Blank Values
-- 4. Remove Any Unnecessary Columns or Rows


-- 1. Remove Duplicates

Create Table layoffs_staging
Like layoffs_raw;

Select *
From layoffs_staging;

Insert layoffs_staging
Select *
From layoffs_raw;

With duplicate_CTE AS
(
Select *,
Row_Number() Over(Partition By company, location, industry, total_laid_off, 
percentage_laid_off, `date`, stage, country, funds_raised_millions) AS Row_Num
From layoffs_staging
)
Select *
From duplicate_CTE
Where Row_Num > 1;

Select *
From layoffs_staging
Where company = 'Oda';

-- Creates a copy of the Table that contains Raw Data and an extra Column containing Row Number
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `Row_Number` Int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

Insert Into layoffs_staging2
Select *,
Row_Number() Over(Partition By company, location, industry, total_laid_off, 
percentage_laid_off, `date`, stage, country, funds_raised_millions) AS Row_Num
From layoffs_staging;


-- 1. Deletes Any Duplicate Rows
Select *
From layoffs_staging2
Where `Row_Number` > 1;

DELETE
From layoffs_staging2
Where `Row_Number` > 1;

-- 2. Standardize the Data

Select company
From layoffs_staging2;

Update layoffs_staging2
Set company = Trim(company);

Select Distinct industry
From layoffs_staging2
Order by 1;

Select *
From layoffs_staging2
where industry Like 'Crypto%';

Update layoffs_staging2
Set industry = 'Crypto'
where industry Like 'Crypto%';

Select Distinct country
From layoffs_staging2
Order By 1;

Update layoffs_staging2
Set country = Trim(Trailing '.' From country)
Where country Like 'United States%';

Select `date`
From layoffs_staging2;

Update layoffs_staging2
Set `date` = str_to_date(`date`, '%m/%d/%Y');

Alter Table layoffs_staging2
Modify Column `date` date;

-- 3. Null or Blank Values

Select *
From layoffs_staging2
Where total_laid_off IS Null
And percentage_laid_off IS Null;

Select *
From layoffs_staging2
Where industry IS NULL
OR industry = '';

Select *
From layoffs_staging2
Where company = 'Airbnb';

Select t1.company, t1.industry, t2.company, t2.industry
From layoffs_staging2 t1
Join layoffs_staging2 t2
	On t1.company = t2.company
Where (t1.industry IS NULL OR t1.industry = '')
And t2.industry IS Not Null;

Update layoffs_staging2
Set industry = null
Where industry = '';

Update layoffs_staging2 t1
Join layoffs_staging2 t2
	On t1.company = t2.company
Set t1.industry = t2.industry
Where t1.industry IS NULL
And t2.industry IS Not Null;

-- 4. Remove Any Unnecessary Columns or Rows

Select *
From layoffs_staging2
Where total_laid_off IS Null
And percentage_laid_off IS Null;

DELETE
From layoffs_staging2
Where total_laid_off IS Null
And percentage_laid_off IS Null;

Alter Table layoffs_staging2
Drop Column `Row_Number`;

Select *
From layoffs_staging2;

-- ---------------------------------------------
-- Exploratory Data Analysis
-- ---------------------------------------------

Select *
From layoffs_staging2;

Select Max(total_laid_off), Max(percentage_laid_off)
From layoffs_staging2;

-- Companies with 100% layoff
Select *
From layoffs_staging2
Where percentage_laid_off = 1;

-- Number of companies within each industry that completely closed down (100% layoffs)
Select industry, Count(company) AS Num_of_companies
From layoffs_staging2
Where percentage_laid_off = 1
Group by industry
Order by Count(industry) desc;

-- Companies that laid off 100% of employees between 2020 and 2021
SELECT industry, COUNT(company) AS Num_of_companies
FROM layoffs_staging2
WHERE percentage_laid_off = 1
  AND YEAR(`date`) BETWEEN 2020 AND 2021
GROUP BY industry
ORDER BY count_of_companies DESC;

Select *
From layoffs_staging2
Where percentage_laid_off = 1
Order By total_laid_off Desc;

Select *
From layoffs_staging2
Where percentage_laid_off = 1
Order By funds_raised_millions Desc;

Select company, SUM(total_laid_off) 
From layoffs_staging2
Group By company
Order By 2 Desc;

Select industry, SUM(total_laid_off) 
From layoffs_staging2
Group By industry
Order By 2 Desc;

Select country, SUM(total_laid_off) 
From layoffs_staging2
Group By country
Order By 2 Desc;

Select Year(`date`), SUM(total_laid_off) 
From layoffs_staging2
Group By Year(`date`)
Order By 1 Desc;

Select stage, SUM(total_laid_off) 
From layoffs_staging2
Group By stage
Order By 2 Desc;

-- Total Off and Rolling Total within Each Month
WITH Rolling_Total AS 
(
Select SUBSTRING(`date`, 1, 7) AS `Month`, SUM(total_laid_off) AS total_off
From layoffs_staging2
Where SUBSTRING(`date`, 1, 7) IS NOT NULL
Group By `Month`
Order By 1 ASC
)
Select `Month`,total_off,  SUM(total_off) OVER(Order By `Month`) AS rolling_total
From Rolling_Total;

-- Total Off within Each Year
Select SUBSTRING(`date`, 1, 4) AS `Year`, SUM(total_laid_off) AS total_off
From layoffs_staging2
Where SUBSTRING(`date`, 1, 4) IS NOT NULL
Group By `Year`
Order By 1 ASC;

-- Top 5 Companies with Highest Lay offs Each Year (2020-2023)
WITH Company_Year (company, years, total_laid_off) AS
(
Select company, Year(`date`), SUM(total_laid_off)
From layoffs_staging2
Group By company, Year(`date`)
),Company_Year_Rank AS (
Select *, DENSE_RANK() OVER(Partition By years Order by total_laid_off DESC) AS Ranking
From Company_Year
Where years IS NOT NULL AND total_laid_off IS NOT NULL
)
Select* 
From Company_Year_Rank
Where Ranking <= 5

;


