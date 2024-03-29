# Data Cleaning Project: Nashville Housing Dataset 

## Objective
The objective of this project was to apply TSQL-based comprehensive data-cleaning techniques to the Nashville Housing dataset.

## Data Source 
The dataset was obtained from the following GitHub repository: [link](https://github.com/AlexTheAnalyst/PortfolioProjects/blob/main/Nashville%20Housing%20Data%20for%20Data%20Cleaning.xlsx). It comprises a list of houses sold in Nashville (the capital city of Tennessee, USA) between 2013 and 2019, with a total of 19 columns and 56,477 rows capturing various attributes of housing properties.

## Skills Used 
DML (Data Manipulation Language), DQL (Data Query Language), and DDL (Data Definition Language).

## Tools Used
SQL Server, Azure Data Studio, TSQL.
## Data Acquisition:

**Database Creation:** At first, a database named NashvilleHousing was created to store the dataset.

**Table Creation:** Within the NashvilleHousing database, Housing_Data table was created to accommodate the dataset.

**Data Loading:** The Housing_Data table was populated by importing data from the Excel file containing the raw data.

## Data Cleaning Process
### Data Understanding
**Original Dataset:** The dataset contained 56,477 rows and 19 columns.

**Initial Assessment:** Initial inspection revealed missing values, formatting errors, duplicate entries, and outliers.
### Data Preparation Steps
**Data Type Verification:** Checked and confirmed correct data types for all columns.

**Handling Missing Values:**
- Imputed missing values for PropertyAddress column based on ParcelID.
- Removed rows with many null values across multiple columns.
  
**Handling Formatting Errors:**
- Removed leading/trailing spaces.
- Standardized spaces within text fields.
- Resolved typing errors and standardized values in certain columns.
  
**Duplicate Removal:** Identified and removed duplicate rows based on specific criteria.
  
**Outlier Identification:** Detected outliers in the SalePrice column using quartiles and IQR.

**Column Splitting:** Split PropertyAddress and OwnerAddress columns into separate columns for city and state.

**Column Removal:** Removed original PropertyAddress and OwnerAddress columns as they were redundant.
## Results
**Dataset Size:** After cleaning, the dataset contains 25,967 rows and 22 columns.

**Missing Values:** Imputed 29 missing values in the PropertyAddress column.

**Formatting Errors:**
- Removed leading/trailing spaces: 1 row in PropertyAddress.
- Standardized spaces: 26,015 rows in PropertyAddress, OwnerName, and OwnerAddress.
- Resolved typing errors:
  - Corrected LandUse in 448 rows.
  - Updated LegalReference in 7 rows, set 4 rows to null.
  - Updated SoldAsVacant to 'NO' in 24,784 rows, and 'YES' in 1,231 rows.
  - Adjusted OwnerName in 117 rows (added comma before 'LLC').

**Duplicates:** Removed 48 duplicate rows.

**Outliers:** Identified outliers in the SalePrice column.

**Column Splitting:** Created new columns for city and state information extracted from PropertyAddress and OwnerAddress.
## Conclusion
The data-cleaning process resulted in a more refined and reliable dataset for further analysis. By addressing missing values, formatting errors, duplicates, and outliers, the overall quality of the data has been improved.
## Appendix
- View [complete project](https://github.com/oarisur/transact-sql-projects/blob/main/Data_Cleaning_Project/Nashville_housing_data_cleaning.ipynb) or [queries only](https://github.com/oarisur/transact-sql-projects/blob/main/Data_Cleaning_Project/Nashville_housing_data_cleaning.sql).
- Dataset [before](https://github.com/oarisur/transact-sql-projects/blob/main/Data_Cleaning_Project/Nashville_housing_data.xlsx) and [after](https://github.com/oarisur/transact-sql-projects/blob/main/Data_Cleaning_Project/Nashville_housing_data_cleaned.xlsx) data cleaning.
