-- This SQL Code includes the queries used in the Preparation stage of the project: Analysis of New York Hospital Mortality by Chadwick Johnson
-- Project location:https://github.com/cgjohnso/New_York_Hospital_Mortality_Analysis 



-- 1.3 Importing_Data

-- Create new table to house NY SPARC data
DROP TABLE IF EXISTS NYHospitals.dbo.SPARC2019
GO
CREATE TABLE NYhospitals.dbo.SPARC2019
	(
		ID INT IDENTITY (1,1) NOT NULL CONSTRAINT PK_ID PRIMARY KEY, 
		Hospital_Service_Area VARCHAR(15) null,
		Hospital_County VARCHAR(11) null,
		Operating_Certificate_Number VARCHAR(12) null,
		Permanent_Facility_Id INT null,
		Facility_Name VARCHAR(112) null,
		Age_Group VARCHAR(11) null,
		Zip_Code_3_digits VARCHAR(3) null,
		Gender VARCHAR(1) null,
		Race VARCHAR(32) null,
		Ethnicity VARCHAR(20) null,
		Length_of_Stay VARCHAR(5) null,
		Type_of_Admission VARCHAR(15) null,
		Patient_Disposition VARCHAR(37) null,
		Discharge_Year VARCHAR(4) null,
		CCSR_Diagnosis_Code VARCHAR(10) null,
		CCSR_Diagnosis_Description VARCHAR(250) null,
		CCSR_Procedure_Code VARCHAR(10) null,
		CCSR_Procedure_Description VARCHAR(250) null,
		APR_DRG_Code VARCHAR(3) null,
		APR_DRG_Description VARCHAR(500) null,
		APR_MDC_Code VARCHAR(2) null,
		APR_MDC_Description VARCHAR(500) null,
		APR_Severity_of_Illness_Code VARCHAR(1) null,
		APR_Severity_of_Illness_Description VARCHAR(8) null,
		APR_Risk_of_Mortality VARCHAR(8) null,
		APR_Medical_Surgical_Description VARCHAR(14) null,
		Payment_Typology_1 VARCHAR(25) null,
		Payment_Typology_2 VARCHAR(25) null,
		Payment_Typology_3 VARCHAR(25) null,
		Birth_Weight VARCHAR(5) null,
		Emergency_Department_Indicator VARCHAR(12) null,
		Total_Charges decimal(28,2) null,
		Total_Costs decimal(28,2) null

	)


-- Bulk Insert Statement loads large amount of data quickly
USE NYHospitals

BULK INSERT NYHospitals.dbo.rawdataview
FROM 'C:\Users\Bob\Downloads\Hospital_Inpatient_Discharges__SPARCS_De-Identified___2019.csv'
	WITH
		(
		BATCHSIZE = 100000
		,ERRORFILE = 'C:\Users\Bob\Downloads\Hospital_Inpatient_Discharges__SPARCS_De-Identified___2019_ERROR.log'
		,MAXERRORS = 1
		,FIRSTROW = 2
		,KEEPNULLS
		,FORMAT = 'CSV'
		,FIELDTERMINATOR = ','
		,ROWTERMINATOR = '0x0a'
		)

-- 1.4 Assessing and Cleaning the Data

-- 1.4a Checks if all data was imported. Used to audit the results of the data import into the table by giving summary statistics that include the full column name list from information_schem and counting the total rows in the table
;WITH Rowcte as
(
SELECT COUNT(*) as Total_Rows
FROM dbo.sparc2019
)
SELECT Column_Name, (SELECT rowcte.Total_Rows FROM Rowcte) as Total_Rows
FROM information_schema.columns 
WHERE Table_Name = 'SPARC2019'
ORDER BY Column_Name ASC


-- Shows our table structure with the values we assigned at creation
SELECT c.name, c.max_length, c.precision, c.scale, c.is_nullable, c.is_identity, ty.name 
FROM sys.tables T
INNER JOIN sys.columns C
		ON T.OBJECT_ID = C.OBJECT_ID
INNER JOIN sys.types Ty
		ON c.system_type_id = ty.system_type_id

WHERE t.name = 'sparc2019'
ORDER BY c.name asc



-- Counts the total null values within each specified column

SELECT 'Hospital_Service_Area' as ColumnName,SUM(CASE WHEN Hospital_Service_Area IS NULL THEN 1 ELSE 0 END) as Total_Nulls FROM dbo.SPARC2019 UNION ALL 
SELECT 'Hospital_County',SUM(CASE WHEN Hospital_County IS NULL THEN 1 ELSE 0 END) as col2 FROM dbo.SPARC2019 UNION ALL 
SELECT 'Operating_Certificate_Number',SUM(CASE WHEN Operating_Certificate_Number IS NULL THEN 1 ELSE 0 END) as col3 FROM dbo.SPARC2019 UNION ALL 
SELECT 'Permanent_Facility_Id',SUM(CASE WHEN Permanent_Facility_Id IS NULL THEN 1 ELSE 0 END) as col4 FROM dbo.SPARC2019 UNION ALL 
SELECT 'Zip_Code_3_digits',SUM(CASE WHEN Zip_Code_3_digits IS NULL THEN 1 ELSE 0 END) as col5 FROM dbo.SPARC2019 UNION ALL 
SELECT 'CCSR_Diagnosis_Code',SUM(CASE WHEN CCSR_Diagnosis_Code IS NULL THEN 1 ELSE 0 END) as col6 FROM dbo.SPARC2019  UNION ALL
SELECT 'CCSR_Diagnosis_Description',SUM(CASE WHEN CCSR_Diagnosis_Description IS NULL THEN 1 ELSE 0 END) as col7 FROM dbo.SPARC2019 UNION ALL 
SELECT 'CCSR_Procedure_Code',SUM(CASE WHEN CCSR_Procedure_Code IS NULL THEN 1 ELSE 0 END) as col8 FROM dbo.SPARC2019  UNION ALL 
SELECT 'CCSR_Procedure_Description',SUM(CASE WHEN CCSR_Procedure_Description IS NULL THEN 1 ELSE 0 END) as col9 FROM dbo.SPARC2019 UNION ALL
SELECT 'APR_DRG_Code',SUM(CASE WHEN APR_DRG_Code IS NULL THEN 1 ELSE 0 END) as col10 FROM dbo.SPARC2019 UNION ALL 
SELECT 'APR_DRG_Description',SUM(CASE WHEN APR_DRG_Description IS NULL THEN 1 ELSE 0 END) as col11 FROM dbo.SPARC2019 UNION ALL 
SELECT 'APR_MDC_Code',SUM(CASE WHEN APR_MDC_Code IS NULL THEN 1 ELSE 0 END) as col12 FROM dbo.SPARC2019 UNION ALL
SELECT 'APR_MDC_Description',SUM(CASE WHEN APR_MDC_Description IS NULL THEN 1 ELSE 0 END) as col13 FROM dbo.SPARC2019 UNION ALL 
SELECT 'APR_Severity_of_Illness_Code',SUM(CASE WHEN APR_Severity_of_Illness_Code IS NULL THEN 1 ELSE 0 END) as col14 FROM dbo.SPARC2019 UNION ALL 
SELECT 'APR_Severity_of_Illness_Description',SUM(CASE WHEN APR_Severity_of_Illness_Description IS NULL THEN 1 ELSE 0 END) as col15 FROM dbo.SPARC2019 UNION ALL
SELECT 'APR_Risk_of_Mortality',SUM(CASE WHEN APR_Risk_of_Mortality IS NULL THEN 1 ELSE 0 END) as col16 FROM dbo.SPARC2019 UNION ALL
SELECT 'Payment_Typology_2',SUM(CASE WHEN Payment_Typology_2 IS NULL THEN 1 ELSE 0 END) as col17 FROM dbo.SPARC2019 UNION ALL 
SELECT 'Payment_Typology_3',SUM(CASE WHEN Payment_Typology_3 IS NULL THEN 1 ELSE 0 END) as col18 FROM dbo.SPARC2019 UNION ALL
SELECT 'Birth_Weight',SUM(CASE WHEN Birth_Weight IS NULL THEN 1 ELSE 0 END) as col19 FROM dbo.SPARC2019 ORDER BY 1

-- Pulls selected nulled records that are split into  agroup of 13 and 1447 records

SELECT *
FROM dbo.SPARC2019
WHERE APR_Severity_of_Illness_Description IS NULL
ORDER BY ID ASC

/*Pulls summary statistics for records with null values so their usability and fitness for purpose can be determined. Ungroupable, Principal Diagnosis Invalid DRG Description rule them 
out because they can't be compared to other record sets*/
SELECT ccsr_diagnosis_description, ccsr_Procedure_Description, apr_drg_description, apr_mdc_description, COUNT(*) as Total_Records
FROM dbo.SPARC2019
WHERE apr_severity_of_illness_description IS NULL
GROUP BY ccsr_diagnosis_description, ccsr_procedure_description, apr_drg_description, apr_mdc_description
ORDER BY ccsr_diagnosis_description, ccsr_procedure_description ASC


-- Cleans dataset of rows under APR columns with unusable data. 
BEGIN TRANSACTION
DELETE FROM dbo.SPARC2019
WHERE APR_Severity_of_Illness_Description IS NULL
GO

-- Identifies all 9065 nulled records in Second Approach step for Permanent_facility_id column

SELECT *
FROM dbo.SPARC2019
WHERE Permanent_Facility_Id is null

-- Deletes all 9065 nulled records in Second Approach step for Permanent_facility_id column
BEGIN TRAN
DELETE FROM dbo.SPARC2019
WHERE Permanent_Facility_Id is null
GO


-- Reveals the "not available" value in type_of_admission field
SELECT DISTINCT Type_of_Admission
FROM dbo.SPARC2019

-- counts total number of admission types listed as "Not Available"

SELECT COUNT(*) as number_of_unknown_admission_types
FROM dbo.SPARC2019
WHERE Type_of_Admission = 'Not Available'


-- Removes records listed as "Not Available"

BEGIN TRANSACTION
DELETE FROM dbo.SPARC2019
WHERE Type_of_Admission = 'Not Available'
ROLLBACK TRANSACTION


-- 1.4b Ensuring Data Are Unique

-- Obtains the total number of unique records in the dataset that have duplicates 
Select COUNT(group_count) as 'Unique_Records_With_Duplicates'
FROM
	(
		SELECT
		[Hospital_Service_Area], [Hospital_County], [Operating_Certificate_Number], [Permanent_Facility_Id], [Facility_Name], [Age_Group], [Zip_Code_3_digits], [Gender], [Race], [Ethnicity], 
		[Length_of_Stay], [Type_of_Admission], [Patient_Disposition], [CCSR_Diagnosis_Code],[CCSR_Procedure_Code], [APR_DRG_Code], [APR_MDC_Code], [APR_Severity_of_Illness_Code], [APR_Risk_of_Mortality],  
		[Payment_Typology_1], [Payment_Typology_2], [Payment_Typology_3], [Birth_Weight], [Emergency_Department_Indicator], [Total_Charges], [Total_Costs], COUNT(*) as group_count
		
		FROM dbo.SPARC2019
		GROUP BY
		[Hospital_Service_Area], [Hospital_County], [Operating_Certificate_Number], [Permanent_Facility_Id], [Facility_Name], [Age_Group], [Zip_Code_3_digits], [Gender], [Race], [Ethnicity], 
		[Length_of_Stay], [Type_of_Admission], [Patient_Disposition], [CCSR_Diagnosis_Code],[CCSR_Procedure_Code], [APR_DRG_Code], [APR_MDC_Code], [APR_Severity_of_Illness_Code], [APR_Risk_of_Mortality],  
		[Payment_Typology_1], [Payment_Typology_2], [Payment_Typology_3], [Birth_Weight], [Emergency_Department_Indicator], [Total_Charges], [Total_Costs]
		
		HAVING COUNT(*) > 1
	) Unique_Record_Count

-- Obtains the total number of duplicate records 
Select SUM(group_count) - COUNT(group_count) as 'Total_Duplicate_Records'
FROM
	(
		SELECT
		[Hospital_Service_Area], [Hospital_County], [Operating_Certificate_Number], [Permanent_Facility_Id], [Facility_Name], [Age_Group], [Zip_Code_3_digits], [Gender], [Race], [Ethnicity], 
		[Length_of_Stay], [Type_of_Admission], [Patient_Disposition], [CCSR_Diagnosis_Code],[CCSR_Procedure_Code], [APR_DRG_Code], [APR_MDC_Code], [APR_Severity_of_Illness_Code], [APR_Risk_of_Mortality],  
		[Payment_Typology_1], [Payment_Typology_2], [Payment_Typology_3], [Birth_Weight], [Emergency_Department_Indicator], [Total_Charges], [Total_Costs], COUNT(*) as group_count
		
		FROM dbo.SPARC2019
		GROUP BY
		[Hospital_Service_Area], [Hospital_County], [Operating_Certificate_Number], [Permanent_Facility_Id], [Facility_Name], [Age_Group], [Zip_Code_3_digits], [Gender], [Race], [Ethnicity], 
		[Length_of_Stay], [Type_of_Admission], [Patient_Disposition], [CCSR_Diagnosis_Code],[CCSR_Procedure_Code], [APR_DRG_Code], [APR_MDC_Code], [APR_Severity_of_Illness_Code], [APR_Risk_of_Mortality],  
		[Payment_Typology_1], [Payment_Typology_2], [Payment_Typology_3], [Birth_Weight], [Emergency_Department_Indicator], [Total_Charges], [Total_Costs]
		
		HAVING COUNT(*) > 1
	) Duplicate_Record_Count

-- Retrieves the duplicate records 
SELECT *
FROM
	(
		SELECT *,
		DENSE_RANK() OVER(PARTITION BY 
			[Hospital_Service_Area], [Hospital_County], [Operating_Certificate_Number], [Permanent_Facility_Id], [Facility_Name], [Age_Group], [Zip_Code_3_digits], [Gender], [Race], [Ethnicity], 
			[Length_of_Stay], [Type_of_Admission], [Patient_Disposition], [CCSR_Diagnosis_Code],[CCSR_Procedure_Code], [APR_DRG_Code], [APR_MDC_Code], [APR_Severity_of_Illness_Code], [APR_Risk_of_Mortality],  
			[Payment_Typology_1], [Payment_Typology_2], [Payment_Typology_3], [Birth_Weight], [Emergency_Department_Indicator], [Total_Charges], [Total_Costs]

		ORDER BY ID) as AsRank
		FROM DBO.SPARC2019
	) RankCheck 
WHERE RankCheck.AsRank > 1


-- Deletes duplicate records from dataset

BEGIN TRANSACTION
DELETE FROM dbo.SPARC2019
WHERE ID IN 
	(
		SELECT ID
		FROM
			(
				SELECT *,
				DENSE_RANK() OVER(PARTITION BY 
					[Hospital_Service_Area], [Hospital_County], [Operating_Certificate_Number], [Permanent_Facility_Id], [Facility_Name], [Age_Group], [Zip_Code_3_digits], [Gender], [Race], [Ethnicity], 
					[Length_of_Stay], [Type_of_Admission], [Patient_Disposition], [CCSR_Diagnosis_Code],[CCSR_Procedure_Code], [APR_DRG_Code], [APR_MDC_Code], [APR_Severity_of_Illness_Code], [APR_Risk_of_Mortality],  
					[Payment_Typology_1], [Payment_Typology_2], [Payment_Typology_3], [Birth_Weight], [Emergency_Department_Indicator], [Total_Charges], [Total_Costs]
		
				ORDER BY ID) as AsRank
				FROM DBO.SPARC2019
			) RankCheck 
		WHERE RankCheck.AsRank > 1

	)
ROLLBACK TRANSACTION



-- 1.4c Ensuring Data Consistancy

-- Uncovers the unique values in each column
SELECT DISTINCT Length_of_Stay
FROM dbo.SPARC2019
ORDER BY length_of_stay ASC

-- Checks the column for any value containing non-numerical characters and counts the total number
SELECT DISTINCT length_of_stay as Unique_Values, count(*) as Total_Number_of_Values
FROM dbo.sparc2019
WHERE Length_of_Stay LIKE '%[^0-9]%'
GROUP BY Lenght_of_Stay

-- Lists all occurances of LOS 120 + days, removes the non numerical characters, and counts the length of the string to verify that only the numerical characters remain.
SELECT length_of_stay, REPLACE('120 +', ' +','') as Formatted_Text, LEN(REPLACE('120 +', ' +','')) as Character_Length
FROM dbo.SPARC2019
WHERE Length_of_Stay = '120 +'

-- Removes non numerical characters from value '120 +' in LOS column 
BEGIN TRANSACTION
UPDATE dbo.SPARC2019
SET Length_of_Stay = REPLACE(length_of_stay,'120 +','120') 
FROM dbo.SPARC2019
WHERE Length_of_Stay = '120 +'
ROLLBACK TRANSACTION


-- Checks the length of the columns to verify that only numerical digits remain
SELECT DISTINCT length_of_stay, LEN(length_of_stay) as Length_of_Characters
from dbo.SPARC2019

-- Checks the column for any value containing non-numerical characters and counts the total number
SELECT DISTINCT length_of_stay as Unique_Values, count(*) as Total_Number_of_Values
FROM dbo.sparc2019
WHERE Length_of_Stay LIKE '%[^0-9]%'
Group By Length_of_Stay

-- Change length_of_stay column data type to INT

BEGIN TRANSACTION
ALTER TABLE dbo.SPARC2019 ALTER COLUMN length_of_stay INT Null
ROLLBACK TRANSACTION

-- counts the total of patients with gender classified as "Unknown"

SELECT count(*) as total_Patients_with_unknown_gender
FROM dbo.SPARC2019
WHERE gender = 'U' AND Facility_Name <> 'Redacted for Confidentiality'



-- Removes records where patient gender is classified as "Unknown"
BEGIN TRANSACTION
DELETE FROM dbo.SPARC2019
WHERE gender = 'U' AND Facility_Name <> 'Redacted for Confidentiality'
ROLLBACK TRANSACTION

-- Makes the Birth_Weight column consistant to only containing INT data type by removing 'unkn' strings through out and replacing all occuranes with NULL value.
BEGIN TRANSACTION
UPDATE dbo.SPARC2019
SET Birth_Weight = NULL
WHERE Birth_Weight = 'unkn'
ROLLBACK TRANSACTION



-- Checks if there are any remaining 'UNKN' values in the Birth_Weight column
select count(*) as Total_Patients
from dbo.SPARC2019
where Birth_Weight = 'unkn'

-- Checks character length of values in birth_weight column to determine the presence of any inconsistant lengths or inappropriate character types in the column
SELECT LEN(birth_weight) as length
FROM dbo.SPARC2019
WHERE birth_weight IS NOT NULL
GROUP BY LEN(birth_weight)

-- Removes leading zeros, extra spaces, and updates birth_weight column with cleaned number set
BEGIN TRANSACTION
UPDATE dbo.SPARC2019
SET Birth_Weight =
TRIM(SUBSTRING(
	birth_weight,
	PATINDEX('%[1-9]%',birth_weight), 
	LEN(birth_weight) - PATINDEX('%[1-9]%',birth_weight) +1))
WHERE Birth_Weight IS NOT NULL
ROLLBACK TRANSACTION



-- Pulls sample from birth_weight column and Confirms column update was appropriately changed
SELECT DISTINCT top(100) birth_weight
FROM dbo.SPARC2019
WHERE birth_weight is not null
ORDER BY birth_weight ASC


-- Converts column to INT data type
BEGIN TRANSACTION
ALTER TABLE dbo.SPARC2019
ALTER COLUMN birth_weight INT NULL
ROLLBACK TRANSACTION


-- 1.4d Ensuring Data Are Accurate

-- Displays any instance where patient is assigned male gender, and receives female exclusive medical care
SELECT *
FROM dbo.SPARC2019
WHERE Gender = 'M' AND APR_MDC_Description LIKE '%female%'

-- Displays any instance where patient is assigned female gender, and receives male exclusive medical care
SELECT *
FROM dbo.SPARC2019
WHERE Gender = 'F' AND APR_MDC_Description LIKE '%The Male%'

-- Displays any instance where patient is assigned male gender, and receives female exclusive medical care
SELECT *
FROM dbo.SPARC2019
WHERE Gender = 'M' AND CCSR_Diagnosis_Description LIKE '%female%'


-- Displays any instance where patient is assigned female gender, and receives male exclusive medical care
SELECT *
FROM dbo.SPARC2019
WHERE Gender = 'F' AND CCSR_Procedure_Description IN ('Male Perineum', 'Male Reproductive System Procedures, Nec') 



-- Assigns female gender to replace male gender
BEGIN TRANSACTION
UPDATE dbo.SPARC2019
SET Gender = 'F'
WHERE Gender = 'M' AND APR_MDC_Description LIKE '%female%'
ROLLBACK TRANSACTION

-- Assigns male gender to replace femle gender
BEGIN TRANSACTION
UPDATE dbo.SPARC2019
SET Gender = 'M'
WHERE ID IN ('305475','868791','1144608','1264757','1771897')
ROLLBACK TRANSACTION

-- Deletes records that have conflicting medical histories as these cannot be reconciled without consulting clinician or the patient record
BEGIN TRANSACTION
DELETE FROM dbo.SPARC2019
WHERE ID IN ('905201','670610','1950761','26823','909126','233739','1085602','1034884')
ROLLBACK TRANSACTION

-- Deletes records that have excessively vague medical history where gender cannot be reasonably identified without consulting clinician or the patient record
BEGIN TRANSACTION
DELETE FROM dbo.SPARC2019
WHERE ID IN ('2313318','364323','836567')
ROLLBACK TRANSACTION


-- Checks for age groups that are not appropriate to be classified under Newborn admission type
SELECT *
FROM dbo.SPARC2019
WHERE Type_of_Admission  = 'newborn' AND Birth_Weight IS NULL AND Age_Group <> '0 to 17'

-- Deletes records for age groups that are not appopriate to newborn admission type
BEGIN TRANSACTION
DELETE FROM dbo.SPARC2019
WHERE Type_of_Admission  = 'newborn' AND Birth_Weight IS NULL AND Age_Group <> '0 to 17'
ROLLBACK TRANSACTION

