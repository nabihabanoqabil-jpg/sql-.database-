USE messy_db;
SET SQL_SAFE_UPDATES = 0;

DROP TABLE IF EXISTS sales_clean;
CREATE TABLE sales_clean AS SELECT * FROM messy_sales;
UPDATE sales_clean SET product_name = TRIM(product_name), category = TRIM(category), status = LOWER(TRIM(status));
UPDATE sales_clean SET status = 'cancelled' WHERE status = 'canceled';
UPDATE sales_clean SET category = CASE WHEN LOWER(category) LIKE 'home%' THEN 'Home & Kitchen' ELSE CONCAT(UPPER(LEFT(category,1)), LOWER(SUBSTRING(category,2))) END;
UPDATE sales_clean SET product_name = CASE WHEN LOWER(product_name) = 'usb-c hub' THEN 'USB-C Hub' WHEN LOWER(product_name) = 'sql basics' THEN 'SQL Basics' WHEN LOWER(product_name) = 'cotton t-shirt' THEN 'Cotton T-Shirt' WHEN LOCATE(' ', product_name) = 0 THEN CONCAT(UPPER(LEFT(product_name,1)), LOWER(SUBSTRING(product_name,2))) ELSE CONCAT(UPPER(LEFT(product_name,1)), LOWER(SUBSTRING(product_name,2,LOCATE(' ',product_name)-1)), UPPER(SUBSTRING(product_name,LOCATE(' ',product_name)+1,1)), LOWER(SUBSTRING(product_name,LOCATE(' ',product_name)+2))) END;
UPDATE sales_clean SET quantity = CASE quantity WHEN 'one' THEN '1' WHEN 'two' THEN '2' WHEN 'three' THEN '3' WHEN '' THEN NULL ELSE quantity END;
UPDATE sales_clean SET quantity = NULL WHERE quantity LIKE '-%';
UPDATE sales_clean SET unit_price = NULLIF(REPLACE(REPLACE(unit_price,'$',''),' USD',''),'N/A');
UPDATE sales_clean SET sale_date = CASE WHEN sale_date LIKE '%/%' THEN STR_TO_DATE(sale_date, '%m/%d/%Y') WHEN sale_date REGEXP '^[0-9]{4}-' THEN sale_date ELSE STR_TO_DATE(sale_date, '%d %b %Y') END;
ALTER TABLE sales_clean MODIFY quantity INT, MODIFY unit_price DECIMAL(10,2), MODIFY sale_date DATE;
SELECT * FROM sales_clean LIMIT 5;
