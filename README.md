## Table of Contents
- [Analysis of Mortality in New York Hospitals Part 1 - Preparation](#Analysis_of_Mortality_in_New_York_Hospitals_Part_1_-_Preparation)

# Introduction

With this deep dive project walk through, I will demonstrate my process for taking on a healthcare business task, and deliver insights.  

Tools Used in this project are:
-	SQL Server Management Studio	19 (SSMS)
*	Microsoft SQL Server Developer (16.0.1000.6)
+	Notepad++
+	Tableau Desktop

## Business Problem
Local news reporting an unfortunate inpatient care incident has prompted state health officials to review all hospitals for discharges resulting in mortality, and identify potential systemic problems. They want to know the types of patients coming into facilities, the conditions they present with, and the main factors contributing to mortality. The aim of the study is to prepare a report on recommendations to increase hospitals’ accountability for the care they deliver, and establish resources to support health facilities. The healthcare analytics division must gather data, and report back our findings.

## Results

For this project I use TSQL joins, delete and update clauses, case statements, aggregate functions, window functions, and bulk insert to ingest, clean and explore data to discover, and answer research questions. I use Notepad++ to locate dataset characters interfering with data ingestion. Tableau is used to visualize findings, and build a final report.

## Methodology

We will follow tried and true data science work flow beginning with data preparation where we will collect the data set, discuss any limitations, import it into Microsoft SQL Server, review the data quality, and clean it before moving on to exploratory data analysis (EDA). 
During EDA we will find out basic information about the data through summary statistics, note any observations to help develop our research questions, and determine if further transformations to the data set are needed for data analysis. 
In the Data Analysis stage, we will interpret the findings, share the results through tableau, and wrap up with our take away conclusions. Let’s get started!

# [Analysis_of_Mortality_in_New_York_Hospitals_Part_1_-_Preparation](https://github.com/cgjohnso/New_York_Hospital_Mortality_Analysis/blob/main/SPARC2019_NY_Hospital_Mortality_Analysis_Part1.pdf)
