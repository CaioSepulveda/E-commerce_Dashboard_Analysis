-- ✅ GMV (Gross Merchandise Value) mensal
CREATE OR REPLACE VIEW `olist_silver.kpi_gmv_mensal` AS
SELECT
  FORMAT_DATE('%Y-%m', o.order_purchase_timestamp) AS ano_mes,
  SUM(oi.price + oi.freight_value) AS gmv
FROM `olist_clean.order_clean` o
JOIN `olist_clean.order_items_clean` oi USING(order_id)
GROUP BY 1
ORDER BY 1;

-- ✅ AOV (Average Order Value)
CREATE OR REPLACE VIEW `olist_silver.kpi_aov` AS
SELECT
  AVG(oi.price + oi.freight_value) AS avg_order_value
FROM `olist_clean.order_items_clean` oi;

-- ✅ Taxa de entrega pontual (on-time delivery)
CREATE OR REPLACE VIEW `olist_silver.kpi_delivery_on_time` AS
SELECT
  COUNTIF(order_delivered_customer_date <= order_estimated_delivery_date) * 1.0 /
  COUNT(*) AS on_time_delivery_rate
FROM `olist_clean.order_clean`
WHERE order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL;

-- ✅ NPS Proxy (Percentual de reviews >= 4)
CREATE OR REPLACE VIEW `olist_silver.kpi_nps_proxy` AS
SELECT
  COUNTIF(review_score >= 4) * 1.0 / COUNT(*) AS perc_promoters
FROM `olist_raw.reviews`
WHERE review_score BETWEEN 1 AND 5;

-- ✅ Top 10 cidades com maior volume de pedidos
CREATE OR REPLACE VIEW `olist_silver.kpi_top_cidades` AS
SELECT
  customer_city_clean,
  COUNT(DISTINCT order_id) AS total_pedidos
FROM `olist_clean.order_clean` o
JOIN `olist_clean.customers_clean` c USING(customer_id)
GROUP BY customer_city_clean
ORDER BY total_pedidos DESC
LIMIT 10;

-- ✅ GMV por categoria de produto
CREATE OR REPLACE VIEW `olist_silver.kpi_gmv_categoria` AS
SELECT
  p.product_category_name_clean AS categoria,
  SUM(oi.price + oi.freight_value) AS total_gmv
FROM `olist_clean.order_items_clean` oi
JOIN `olist_clean.product_clean` p USING(product_id)
GROUP BY categoria
ORDER BY total_gmv DESC;
