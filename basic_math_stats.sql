---- answer1---
Select invoiceno,sum(quantity * unitprice) as total_amt
from ecommerce_clean
group by 1
order by 1 limit 10;

Select country,sum(quantity * unitprice) as total_amt,
avg(quantity * unitprice) as avg_amt,count(distinct invoiceno) as total_order
from ecommerce_clean
group by 1
order by 2 desc;

Select PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY unitprice) as q1,
PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY unitprice) as median,
PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY unitprice) as q3
from ecommerce_clean;

Select customerid,sum(quantity * unitprice) as total_amt,count(distinct invoiceno) as total_order
from ecommerce_clean
group by 1
having sum(quantity * unitprice) > 1000
order by 2 desc;

WITH price_counts AS (
    SELECT 
        Country,
        UnitPrice,
        COUNT(*) AS freq
    FROM ecommerce_clean
    GROUP BY Country, UnitPrice
),
ranked AS (
    SELECT 
        Country,
        UnitPrice,
        freq,
        ROW_NUMBER() OVER (PARTITION BY Country ORDER BY freq DESC) AS rn
    FROM price_counts
)
SELECT Country, UnitPrice, freq
FROM ranked
WHERE rn = 1
ORDER BY freq DESC
LIMIT 5;

