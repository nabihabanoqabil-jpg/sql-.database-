# Data Cleaning with SQL + GitHub Actions

This project cleans messy sales data using MySQL.

## What was cleaned?
- Extra spaces and wrong capital letters in product_name, category
- 'canceled' -> 'cancelled'
- 'home' -> 'Home & Kitchen'
- quantity: 'one' -> 1, '' -> NULL, negative values -> NULL
- unit_price: '$', ' USD', 'N/A' removed
- sale_date: different formats -> YYYY-MM-DD

## Files
- messy_dataset.sql - messy data
- cleaning.sql - cleaning steps
- .github/workflows/run.yml - auto runs cleaning on every push

## Result
✅ GitHub Actions - Run Cleaning #1 - Success in 52s
