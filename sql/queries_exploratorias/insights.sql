-- 📌 Insight 1: Produtos mais vendidos em quantidade
SELECT
  p.product_category_name_clean AS categoria,
  COUNT(oi.product_id) AS total_vendido
FROM `olist_clean.order_items_clean` oi
JOIN `olist_clean.product_clean` p USING(product_id)
GROUP BY categoria
ORDER BY total_vendido DESC
LIMIT 10;

-- 📌 Insight 2: Cidades com maior tempo médio de entrega
SELECT
  c.customer_city_clean AS cidade,
  AVG(DATE_DIFF(o.order_delivered_customer_date, o.order_purchase_timestamp, DAY)) AS media_entrega_dias
FROM `olist_clean.order_clean` o
JOIN `olist_clean.customers_clean` c USING(customer_id)
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY cidade
ORDER BY media_entrega_dias DESC
LIMIT 10;

-- 📌 Insight 3: Categorias com maior valor médio por item
SELECT
  p.product_category_name_clean AS categoria,
  AVG(oi.price) AS valor_medio
FROM `olist_clean.order_items_clean` oi
JOIN `olist_clean.product_clean` p USING(product_id)
GROUP BY categoria
ORDER BY valor_medio DESC
LIMIT 10;

-- 📌 Insight 4: Correlação entre nota de avaliação e tempo de entrega
SELECT
  r.review_score,
  ROUND(AVG(DATE_DIFF(o.order_delivered_customer_date, o.order_purchase_timestamp, DAY)), 2) AS media_entrega
FROM `olist_raw.reviews` r
JOIN `olist_clean.order_clean` o USING(order_id)
WHERE r.review_score BETWEEN 1 AND 5
GROUP BY review_score
ORDER BY review_score;

-- 📌 Insight 5: Formas de pagamento mais utilizadas
SELECT
  payment_type_clean,
  COUNT(*) AS total_pagamentos,
  ROUND(SUM(payment_value), 2) AS valor_total
FROM `olist_clean.order_payments_clean`
GROUP BY payment_type_clean
ORDER BY total_pagamentos DESC;
