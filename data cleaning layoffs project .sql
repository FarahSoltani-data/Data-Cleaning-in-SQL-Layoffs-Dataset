SELECT *
 FROM layoffs;
create table layoffs_staging
like layoffs;
Insert layoffs_staging 
SELECT *
FROM layoffs ;

-- INDINAFING DUPLICATE 
SELECT * ,
ROW_NUMBER() OVER(
partition by company , location, industry,total_laid_off,percentage_laid_off,'date',stage,country,funds_raised_millions) as row_num
FROM layoffs_staging ;

WITH duplivate_cte AS
(
SELECT * ,
ROW_NUMBER() OVER(
partition by company , location, industry,total_laid_off,percentage_laid_off,'date',stage,country,funds_raised_millions) as row_num
FROM layoffs_staging 
)
SELECT * FROM duplicate_cte WHERE row_num > 1;

SELECT * FROM layoffs_staging WHERE company = 'Casper';

CREATE TABLE `layoffs_staging2` (
  `company` TEXT,
  `location` TEXT,
  `industry` TEXT,
  `total_laid_off` INT DEFAULT NULL,
  `percentage_laid_off` TEXT,
  `date` TEXT,
  `stage` TEXT,
  `country` TEXT,
  `funds_raised_millions` INT DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
SELECT *
FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT * ,
ROW_NUMBER() OVER(
partition by company , location, industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
FROM layoffs_staging ;

DELETE
 FROM layoffs_staging2 WHERE row_num > 1;
 DELETE
 FROM layoffs_staging2;

SELECT DISTINCT TRIM (company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM (COMPANY);

SELECT DISTINCT INDUTSRY 
FROM layoffs_staging2
ORDER BY 1 ;

UPDATE layoffs_staging2
SET industry = 'crypto'
where industry like 'crypto%';

SELECT DISTINCT country, TRIm(TRAILING '.' FROM country )
FROM layoffs_staging2
order by 1 ; 

UPDATE layoffs_staging2 
SET country = TRIm(TRAILING '.' FROM country )
where country like 'united states%' ;

SELECT `date`,
STR_TO_DATE (`date`,'%m/%d/%Y ')
from layoffs_staging2 ;

SELECT `date`
from layoffs_staging2 ;

UPDATE layoffs_staging2 
SET`date` = STR_TO_DATE ('date' ,'%m/%d/%Y ') ;

ALter TABLE layoffs_staging2
MODIFY COLUMN `date`DATE;
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL ;


update layoffs_staging2
set industry= NULL 
where industry ='';


SELECT *
FROM layoffs_staging2
WHERE industry  IS NULL 
or industry ='' ;

SELECT *
FROM layoffs_staging2
where company LIKE 'BALLY%';

SELECT t1.industry, t2.industry 
from layoffs_staging2 t1 
 join layoffs_staging2 t2
 on t1.company and t2.company 
where ( t1.industry is null or t1.industry ='')
AND t2.industry IS NOT NULL; 

UPDATE layoffs_staging2 t1 
join layoffs_staging2 t2
 on t1.company and t2.company 
 set t1.industry  =t2.industry 
 where ( t1.industry is null  )
 and t2.industry  is not null ;
 
 SELECT *
 FROM layoffs _staging2;

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL ;

Delete 
FROM layoffs_staging2
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL ;


SELECT *
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
Drop COLUMN  row_num ;


 
 

 
 










