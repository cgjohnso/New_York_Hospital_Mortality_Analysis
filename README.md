# Introduction

With this deep dive project walk through, I will demonstrate my process for taking on a healthcare business task, and deliver insights.  

## Business Problem
Local news reporting an unfortunate inpatient care incident has prompted state health officials to review all hospitals for discharges resulting in mortality, and identify potential systemic problems. They want to know the types of patients coming into facilities, the conditions they present with, and the main factors contributing to mortality. The aim of the study is to prepare a report on recommendations to increase hospitalsâ€™ accountability for the care they deliver, and establish resources to support health facilities. The healthcare analytics division must gather data, and report back our findings.

## Tools & Skills Used In This Project
+ TSQL: create table, view, and identity column, execute joins, delete and update clauses, case statements, aggregate functions, window functions, and bulk insert to ingest, clean, explore data, and answer research questions
+	Notepad++: locate characters interfering with data ingestion
+	Tableau Desktop: visualize findings, and build a final report
+	SQL Server Management Studio	19 (SSMS)
+	Microsoft SQL Server Developer (16.0.1000.6)

## Data Set
- Hospital Inpatient Discharges (SPARCS De-Identified): 2019 - [Download](https://health.data.ny.gov/Health/Hospital-Inpatient-Discharges-SPARCS-De-Identified/4ny4-j5zv).


## Research Questions

Which factors correlate strongest to mortality?

Who are the patients that are coming into the facilities?

+ How many people die during admission? 
+ What are the demographics of the patients? Age, race, gender, ethnicity, insurance status
+ What type of admission do patients fall under upon arriving at facilities?


What are the conditions that patients present with?
+ Which diagnoses cover 80% of all discharges?
+ What is their severity of illness?
+ What procedures are they having while admitted?





## Methodology

I begin with data preparation where I collect the data set, discuss any limitations, import it into Microsoft SQL Server, review the data quality, and clean it before moving on to exploratory data analysis (EDA). During EDA I find basic information about the data through summary statistics, note any observations that help develop my research questions, gain insights, and determine if further transformations are needed for data analysis. In the Data Analysis stage, I interpret the findings, share the results through tableau, and wrap up with my take away conclusions. 



# [Step 1 - Preparation (Walkthrough)](https://github.com/cgjohnso/New_York_Hospital_Mortality_Analysis/blob/main/SPARC2019_NY_Hospital_Mortality_Analysis_Part1.pdf)
# [Step 1 - Preparation (SQL CODE)](https://github.com/cgjohnso/New_York_Hospital_Mortality_Analysis/blob/main/SQL_Analysis_of_New_York_Hospitals_Mortality_Part_1.sql)
