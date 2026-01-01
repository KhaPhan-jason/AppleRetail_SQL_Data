create view apple_data as 
select s.sale_id,sale_date,quantity,product_name,launch_date,price,category_name,store_name,city,country,claim_date,repair_status
from sales as s join products as p on s.product_id=p.Product_ID
join category as c on p.Category_ID=c.category_id
join stores as st on s.store_id=st.Store_ID
join warranty as w on s.sale_id=w.sale_id;


-----------------------------------------------------------------------------------------------------------------------------------------------------

-- Sale_date
-- Total units sold per year
select right(sale_date,4) as year,sum(quantity) as total_quantity
from apple_data
group by year
order by year asc;

-- Total units sold per product and category each year
select right(sale_date,4) as year,product_name,category_name,sum(quantity) as total_quantity
from apple_data
group by year,product_name,category_name
order by year asc, total_quantity desc;

-- Number of sales transactions per store each year
select right(sale_date,4) as year,store_name,city,country,count(store_name) as cnt_sale
from apple_data
group by year,store_name,city,country
order by year asc,cnt_sale desc;

-- Number of warranty cases by repair status per year
select right(sale_date,4) as year,repair_status,count(repair_status) as cnt
from apple_data
group by year,repair_status
order by year asc;

-- Top-selling product (by units sold) for each year
with product_year as 
(
select right(sale_date,4) as year, product_name, category_name, sum(quantity) as total_quantity
from apple_data
group by right(sale_date,4), product_name, category_name
),
ranked as 
(
select *,
rank() over (partition by year order by total_quantity desc) as rnk
from product_year
)
select year, product_name, category_name, total_quantity
from ranked
where rnk = 1
order by year;

-- Top-performing store by total units sold each year
with store_data as
(
select right(sale_date,4) as year,store_name,city,country,sum(quantity) as total_quantity
from apple_data
group by year,store_name,city,country
order by year,total_quantity
), ranked_store as
(
select *,rank() over (partition by year order by total_quantity desc) as rnk
from store_data
)
select year,store_name,city,country,total_quantity
from ranked_store
where rnk=1;

-----------------------------------------------------------------------------------------------------------------------------------------------------

-- Product_name
-- Percentage contribution of each product to total yearly sales volume
with quantity_data as
(
select right(sale_date,4) as year,product_name,category_name,sum(quantity) as total_quantity
from apple_data
group by product_name,category_name,year
order by year asc,total_quantity desc
)
select *,round(total_quantity*100/ sum(total_quantity) over (partition by year),2) as percent_sale
from quantity_data
order by year asc,percent_sale desc;

-- Revenue generated per sales transaction
select right(sale_date,4) as year,product_name,category_name,quantity,price,price * quantity as revenue
from apple_data
group by year,product_name,category_name,quantity,price;

-- Total revenue by product and category
with revenue_data as
(
select right(sale_date,4) as year,product_name,category_name,quantity,price,price * quantity as revenue
from apple_data
group by year,product_name,category_name,quantity,price
)
select product_name,category_name,sum(revenue) as total_revenue
from revenue_data
group by product_name,category_name
order by total_revenue desc;

-- Total units sold per product by store and year
select right(sale_date,4) as year,product_name,category_name,store_name,city,country,sum(quantity) as total_quantity
from apple_data
group by year,product_name,category_name,store_name,city,country
order by store_name,total_quantity desc,year asc;

-- Number of warranty cases by product and repair status
select product_name,category_name,repair_status,count(repair_status) as cnt_repair_status
from apple_data
group by product_name,category_name,repair_status
order by product_name,repair_status;

-- Best-selling product (by units sold) for each year
with product_year as 
(
select right(sale_date,4) as year, product_name, category_name, sum(quantity) as total_quantity
from apple_data
group by right(sale_date,4), product_name, category_name
),
ranked as 
(
select *,
rank() over (partition by year order by total_quantity desc) as rnk
from product_year
)
select year, product_name, category_name, total_quantity
from ranked
where rnk = 1
order by year;

-----------------------------------------------------------------------------------------------------------------------------------------------------

-- Price
-- Total revenue generated per year
select sum(quantity*price) as total_revenue,right(sale_date,4) as year 
from apple_data
group by year
order by total_revenue;

-- Revenue by category per year
select right(sale_date,4) as year,category_name,sum(quantity*price) as total_revenue
from apple_data
group by year,category_name
order by year,total_revenue desc;

-- Revenue by store per year
select right(sale_date,4) as year,store_name,city,country,sum(quantity*price) as total_revenue
from apple_data
group by year,store_name,city,country
order by year,total_revenue desc;

-- Top revenue-generating product for each year
with revenue_product as
(
select right(sale_date,4) as year,product_name,category_name,sum(quantity*price) as total_revenue
from apple_data
group by year,product_name,category_name
order by year,total_revenue desc
), ranked_product as
(
select *,rank() over (partition by year order by total_revenue desc) as rnk
from revenue_product
)
select year,product_name,category_name,total_revenue
from ranked_product
where rnk=1;

-- Top revenue-generating store for each year
with revenue_store as
(
select right(sale_date,4) as year,store_name,city,country,sum(quantity*price) as total_revenue
from apple_data
group by year,store_name,city,country
order by year,total_revenue desc
), ranked_store as
(
select *,rank() over (partition by year order by total_revenue desc) as rnk
from revenue_store
)
select year,store_name,city,country,total_revenue
from ranked_store
where rnk=1







