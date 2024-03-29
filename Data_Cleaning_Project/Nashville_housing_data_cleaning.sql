-- Data Cleaning Project: Nashville Housing Dataset



-- Create a copy of the Housing_Data table

SELECT * 

INTO Housing_Data_Clean

FROM Housing_Data;



-- Retrieve all columns and their corresponding data types

SELECT COLUMN_NAME as ColumnName, DATA_TYPE as DataType

FROM INFORMATION_SCHEMA.COLUMNS

WHERE TABLE_NAME = 'Housing_Data_Clean';



-- Declare variables as the starting point of the null count report

DECLARE @TableName NVARCHAR(50)

SET @TableName = 'Housing_Data_Clean'

-- Initialize dynamic SQL string

DECLARE @SQL NVARCHAR(MAX) = ''

-- Construct SQL to count null values for each column

SELECT @SQL = @SQL + 

    'SELECT ''' + COLUMN_NAME + ''' AS column_name, 

    COUNT(CASE WHEN [' + COLUMN_NAME + '] IS NULL THEN 1 END) AS null_count

    FROM ' + @TableName + ' UNION ALL '

FROM INFORMATION_SCHEMA.COLUMNS

WHERE TABLE_NAME = @TableName

-- Remove the last 'UNION ALL' from the SQL string

SET @SQL = LEFT(@SQL, LEN(@SQL) - 10)

-- Final query to retrieve results

SET @SQL = '

SELECT column_name, SUM(null_count) AS null_count

FROM (' + @SQL + ') AS Result

GROUP BY column_name

ORDER BY column_name'
    
-- Execute the dynamic SQL

EXEC sp_executesql @SQL;



-- Retrieves all columns from the Housing_Data_Clean table

SELECT *

FROM Housing_Data_Clean;



-- Update table with missing PropertyAddresses

UPDATE Housing_Data_Clean

SET PropertyAddress = (

-- Search for PropertyAddress with a null value and fill that by a non-null PropertyAddress value from another record by matching their ParcelID

    SELECT TOP (1) hd.PropertyAddress

    FROM Housing_Data_Clean hd

    WHERE hd.ParcelID = Housing_Data_Clean.ParcelID

    AND hd.PropertyAddress IS NOT NULL

)

WHERE PropertyAddress IS NULL;



-- Delete rows where 11 column values are missing

DELETE 

FROM Housing_Data_Clean

WHERE

-- Check if the column is null

Acreage IS NULL

AND Bedrooms IS NULL

AND FullBath IS NULL

AND HalfBath IS NULL

AND LandValue IS NULL

AND OwnerAddress IS NULL

AND OwnerName IS NULL

AND TaxDistrict IS NULL

AND TotalValue IS NULL

AND YearBuilt IS NULL;



-- Convert SaleDate column values to date data type and filter out rows if conversion fails
SELECT *
FROM Housing_Data_Clean
WHERE TRY_CONVERT(date, SaleDate) IS NULL;



-- Filters out non-numeric rows of each numeric column

SELECT *

FROM Housing_Data_Clean

WHERE ISNUMERIC(UniqueID) = 0 

OR ISNUMERIC(SalePrice) = 0

OR ISNUMERIC(Acreage) = 0

OR ISNUMERIC(LandValue) = 0

OR ISNUMERIC(BuildingValue) = 0

OR ISNUMERIC(TotalValue) = 0

OR ISNUMERIC(YearBuilt) = 0

OR ISNUMERIC(Bedrooms) = 0

OR ISNUMERIC(FullBath) = 0

OR ISNUMERIC(HalfBath) = 0;



-- Filters out rows with leading/trailing spaces

SELECT *

FROM Housing_Data_Clean

WHERE LTRIM(RTRIM(UniqueID)) <> UniqueID

OR LTRIM(RTRIM(ParcelID)) <> ParcelID

OR LTRIM(RTRIM(LandUse)) <> LandUse

OR LTRIM(RTRIM(PropertyAddress)) <> PropertyAddress

OR LTRIM(RTRIM(SaleDate)) <> SaleDate

OR LTRIM(RTRIM(SalePrice)) <> SalePrice

OR LTRIM(RTRIM(LegalReference)) <> LegalReference

OR LTRIM(RTRIM(SoldAsVacant)) <> SoldAsVacant

OR LTRIM(RTRIM(OwnerName)) <> OwnerName

OR LTRIM(RTRIM(OwnerAddress)) <> OwnerAddress

OR LTRIM(RTRIM(Acreage)) <> Acreage

OR LTRIM(RTRIM(TaxDistrict)) <> TaxDistrict

OR LTRIM(RTRIM(LandValue)) <> LandValue

OR LTRIM(RTRIM(BuildingValue)) <> BuildingValue

OR LTRIM(RTRIM(TotalValue)) <> TotalValue

OR LTRIM(RTRIM(YearBuilt)) <> YearBuilt

OR LTRIM(RTRIM(Bedrooms)) <> Bedrooms

OR LTRIM(RTRIM(FullBath)) <> FullBath

OR LTRIM(RTRIM(HalfBath)) <> HalfBath;



-- View all columns

SELECT *

FROM Housing_Data_Clean;



-- Trim and update a cell with leading/trailing spaces

UPDATE Housing_Data_Clean

SET PropertyAddress = LTRIM(RTRIM(PropertyAddress))

WHERE UniqueID = 9095;



-- Standardize spaces in the PropertyAddress column by replacing multiple spaces with a single space

UPDATE Housing_Data_Clean

SET PropertyAddress = REPLACE(PropertyAddress, '  ', ' ');



-- Standardize spaces in the OwnerName column by replacing multiple spaces with a single space

UPDATE Housing_Data_Clean

SET OwnerName = REPLACE(OwnerName, '  ', ' ');



-- Standardize spaces in the OwnerAddress column by replacing multiple spaces with a single space

UPDATE Housing_Data_Clean

SET OwnerAddress = REPLACE(OwnerAddress, '  ', ' ');



-- Update the LandUse column to replace 'GREENBELT/RES GRRENBELT/RES' with 'GREENBELT/RES'

UPDATE Housing_Data_Clean

SET LandUse = 'GREENBELT/RES'

WHERE LandUse = 'GREENBELT/RES

GRRENBELT/RES';



-- Update the LandUse column to replace 'VACANT RES LAND' with 'VACANT RESIDENTIAL LAND'

UPDATE Housing_Data_Clean

SET LandUse = 'VACANT RESIDENTIAL LAND'

WHERE LandUse = 'VACANT RES LAND';



-- Update the LegalReference column where '10160622-0063516' is corrected to '20160622-0063516' 

UPDATE Housing_Data_Clean

SET LegalReference = '20160622-0063516'

WHERE LegalReference = '10160622-0063516';



-- Update the LegalReference column where '21040903-0080324' is corrected to '20140903-0080324' 

UPDATE Housing_Data_Clean

SET LegalReference = '20140903-0080324'

WHERE LegalReference = '21040903-0080324';



-- Update the LegalReference column where '20150310 -0020554' is corrected to '20150310-0020554'

UPDATE Housing_Data_Clean

SET LegalReference = '20150310-0020554'

WHERE LegalReference = '20150310 -0020554';



-- Update the LegalReference column where '20105031- 002049' is corrected to '20150310-0020497' 

UPDATE Housing_Data_Clean

SET LegalReference = '20150310-0020497'

WHERE LegalReference = '20105031- 002049';



-- Update the LegalReference column where '25015081- 008375' is corrected to '20150819-0083759' 

UPDATE Housing_Data_Clean

SET LegalReference = '20150815-0008375'

WHERE LegalReference = '25015081- 008375';



-- Update the LegalReference column where '20160408-00339999' is corrected to '20160408-0033999' 

UPDATE Housing_Data_Clean

SET LegalReference = '20160408-0033999'

WHERE LegalReference = '20160408-00339999';



-- Update the LegalReference column where '20130610-00588852' is corrected to '20130610-0058852'

UPDATE Housing_Data_Clean

SET LegalReference = '20130610-0058852'

WHERE LegalReference = '20130610-00588852';



-- Update the LegalReference column where '20015100- 010146' is corrected to null 

UPDATE Housing_Data_Clean

SET LegalReference = NULL

WHERE LegalReference = '20015100- 010146';



-- Update the LegalReference column where '-2020988' is corrected to null 

UPDATE Housing_Data_Clean

SET LegalReference = NULL

WHERE LegalReference = '-2020988';



-- Update the LegalReference column where '-2020879' is corrected to null 

UPDATE Housing_Data_Clean

SET LegalReference = NULL

WHERE LegalReference = '-2020879';



-- Update the LegalReference column where '-2016598' is corrected to null 

UPDATE Housing_Data_Clean

SET LegalReference = NULL

WHERE LegalReference = '-2016598';



-- Update the SoldAsVacant column where 'No' and 'N' are corrected to 'NO'

UPDATE Housing_Data_Clean

SET SoldAsVacant = 'NO'

WHERE SoldAsVacant = 'No' or SoldAsVacant = 'N';



-- Update the SoldAsVacant column where 'Yes' and 'Y' are corrected to 'YES'

UPDATE Housing_Data_Clean

SET SoldAsVacant = 'YES'

WHERE SoldAsVacant = 'Yes' or SoldAsVacant = 'Y';



-- Add a comma before 'LLC' if it is not already present in the OwnerName column

UPDATE Housing_Data_Clean

SET OwnerName = REPLACE(OwnerName, ' LLC', ', LLC')

WHERE OwnerName LIKE '% LLC' AND OwnerName NOT LIKE '%, LLC';



-- Use a CTE to assign row numbers to rows partitioned by ParcelID, SaleDate, SalePrice, and LegalReference. with an arbitrary ordering

WITH CTE AS (

    SELECT ParcelID, SaleDate, SalePrice, LegalReference,

        ROW_NUMBER() OVER(PARTITION BY ParcelID, SaleDate, SalePrice, LegalReference ORDER BY(SELECT NULL)) AS RowNum

    FROM Housing_Data_Clean

)

-- Retrieve rows from the CTE where the row number is greater than 1

SELECT *

FROM CTE

WHERE RowNum > 1;



-- Use a CTE to assign row numbers to rows partitioned by ParcelID, SaleDate, SalePrice, and LegalReference. with an arbitrary ordering

WITH CTE AS (

    SELECT ParcelID, SaleDate, SalePrice, LegalReference,

        ROW_NUMBER() OVER(PARTITION BY ParcelID, SaleDate, SalePrice, LegalReference ORDER BY(SELECT NULL)) AS RowNum

    FROM Housing_Data_Clean

)

-- Delete rows from the CTE where the row number is greater than 1

DELETE FROM CTE

WHERE RowNum > 1;



-- Calculate quartiles

WITH Quartiles AS (

    SELECT 

        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY SalePrice) OVER(PARTITION BY 1) AS Q1,

        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY SalePrice) OVER(PARTITION BY 1) AS Q3

    FROM Housing_Data_Clean

),

-- Calculate IQR

IQR AS (

    SELECT 

        MAX(Q1) AS Q1,

        MAX(Q3) AS Q3,

        MAX(Q3) - MAX(Q1) AS IQR

    FROM Quartiles

)

-- Identify outliers

SELECT *

FROM Housing_Data_Clean

WHERE SalePrice < (SELECT Q1 - 1.5 * IQR FROM IQR) OR SalePrice > (SELECT Q3 + 1.5 * IQR FROM IQR);



-- Add new columns to the table

ALTER TABLE Housing_Data_Clean

ADD ProAddress NVARCHAR (50),

    ProCity NVARCHAR (50),

    OwnAddress NVARCHAR (50),

    OwnCity NVARCHAR (50),

    OwnState NVARCHAR (50);



-- Update the new columns by adding extracted data from PropertyAddrsess 

UPDATE Housing_Data_Clean

SET ProAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1),

    ProCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 2, LEN(PropertyAddress)),



-- Update the new columns by adding extracted data from OwnerAddrsess 

    OwnAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),

    OwnCity = PARSENAME(REPLACE(OwnerAddress, ', ', '.'), 2),

    OwnState = PARSENAME(REPLACE(OwnerAddress, ', ', '.'), 1);



-- Remove specified columns from the table

ALTER TABLE Housing_Data_Clean

DROP COLUMN PropertyAddress, 

            OwnerAddress;
