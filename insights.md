# Key Insights

- The dataset contained duplicate records, which were identified and removed using `ROW_NUMBER()`.
- Company names had extra spaces and inconsistent formatting, which were cleaned using `TRIM()`.
- Industry and country names were standardized to make analysis more accurate.
- The date column was originally stored as text and converted into proper DATE format.
- Missing industry values were populated where possible by matching records from the same company.
- Rows with both `total_laid_off` and `percentage_laid_off` missing/NULL were removed because they were not useful for analysis.
- Exploratory analysis showed layoff trends across countries, years, months, and companies.
- The cleaned dataset became more reliable and ready for further business analysis.
