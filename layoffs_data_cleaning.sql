-- =========================================
-- MySQL Layoffs Data Cleaning Project
-- =========================================

-- View raw data
SELECT *
FROM layoffs;

-- Create a copy of the raw table
CREATE TABLE layoffs_standard
LIKE layoffs;

INSERT INTO layoffs_standard
SELECT *
FROM layoffs;

SELECT *
FROM layoffs_standard;

-- =========================================
-- Step 1: Find duplicate records
-- =========================================

WITH duplicate_cte AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY company, location, industry, total_laid_off,
                            percentage_laid_off, `date`, stage, country,
                            funds_raised_millions
           ) AS row_no
    FROM layoffs_standard
)
SELECT *
FROM duplicate_cte
WHERE row_no > 1;

-- Example check for a specific company
SELECT *
FROM layoffs_standard
WHERE company = 'casper';

-- =========================================
-- Step 2: Create another table to remove duplicates
-- =========================================

CREATE TABLE `layoffs_standard2` (
  `company` TEXT,
  `location` TEXT,
  `industry` TEXT,
  `total_laid_off` INT DEFAULT NULL,
  `percentage_laid_off` TEXT,
  `date` TEXT,
  `stage` TEXT,
  `country` TEXT,
  `funds_raised_millions` INT DEFAULT NULL,
  `row_no` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_standard2;

INSERT INTO layoffs_standard2
SELECT *,
       ROW_NUMBER() OVER (
           PARTITION BY company, location, industry, total_laid_off,
                        percentage_laid_off, `date`, stage, country,
                        funds_raised_millions
       ) AS row_no
FROM layoffs_standard;

SELECT *
FROM layoffs_standard2
WHERE row_no > 1;

-- Turn off safe updates temporarily
SET SQL_SAFE_UPDATES = 0;

-- Remove duplicate records
DELETE
FROM layoffs_standard2
WHERE row_no > 1;

-- Turn safe updates back on
SET SQL_SAFE_UPDATES = 1;

-- =========================================
-- Step 3: Standardize data
-- =========================================

SELECT *
FROM layoffs_standard2;

-- Trim extra spaces from company names
SELECT company, TRIM(company)
FROM layoffs_standard2;

UPDATE layoffs_standard2
SET company = TRIM(company);

-- Check unique industries
SELECT DISTINCT industry
FROM layoffs_standard2
ORDER BY 1;

-- Standardize industry names
SELECT *
FROM layoffs_standard2
WHERE industry LIKE 'crypto%';

UPDATE layoffs_standard2
SET industry = 'crypto'
WHERE industry LIKE 'crypto%';

-- Check unique countries
SELECT DISTINCT country
FROM layoffs_standard2
ORDER BY 1;

-- Standardize country names
SELECT DISTINCT country
FROM layoffs_standard2
WHERE country LIKE 'United States%';

UPDATE layoffs_standard2
SET country = 'United States'
WHERE country LIKE 'United States%';

SELECT *
FROM layoffs_standard2;

-- =========================================
-- Step 4: Convert date from text to DATE format
-- =========================================

SELECT `date`,
       STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_standard2;

UPDATE layoffs_standard2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_standard2
MODIFY `date` DATE;

-- =========================================
-- Step 5: Handle null / missing values
-- =========================================

SELECT DISTINCT industry
FROM layoffs_standard2
ORDER BY 1;

-- Replace 'NULL' text with actual NULL
UPDATE layoffs_standard2
SET industry = NULL
WHERE industry LIKE 'NULL';

SELECT *
FROM layoffs_standard2
WHERE industry IS NULL;

-- Populate missing industry values using matching company records
SELECT DISTINCT l1.company, l1.industry, l2.company, l2.industry
FROM layoffs_standard2 l1
JOIN layoffs_standard2 l2
    ON l1.company = l2.company
   AND l1.industry IS NULL
   AND l2.industry IS NOT NULL;

UPDATE layoffs_standard2 l1
JOIN layoffs_standard2 l2
    ON l1.company = l2.company
SET l1.industry = l2.industry
WHERE l1.industry IS NULL
  AND l2.industry IS NOT NULL;

SELECT *
FROM layoffs_standard2;

-- =========================================
-- Step 6: Remove unnecessary rows
-- =========================================

SELECT *
FROM layoffs_standard2
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL;

DELETE
FROM layoffs_standard2
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs_standard2;

-- =========================================
-- Step 7: Drop helper column
-- =========================================

ALTER TABLE layoffs_standard2
DROP COLUMN row_no;

-- Final cleaned dataset
SELECT *
FROM layoffs_standard2;
