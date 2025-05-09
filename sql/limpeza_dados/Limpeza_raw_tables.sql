-- Limpeza da tabela olist_orders_dataset
CREATE OR REPLACE VIEW `olist_clean.order_clean` AS
SELECT *
FROM `olist_raw.orders`
WHERE order_purchase_timestamp IS NOT NULL
  AND order_status IS NOT NULL
  AND customer_id IS NOT NULL
  AND order_delivered_customer_date IS NOT NULL;

-- Limpeza da tabela olist_order_items_dataset
CREATE OR REPLACE VIEW `olist_clean.order_items_clean` AS
SELECT *
FROM `olist_raw.order_items`
WHERE price IS NOT NULL
  AND product_id IS NOT NULL
  AND seller_id IS NOT NULL;

-- Limpeza da tabela olist_order_payments_dataset
CREATE OR REPLACE VIEW `olist_clean.order_payments_clean` AS
SELECT *
FROM `olist_raw.order_payments`
WHERE payment_value IS NOT NULL
  AND payment_type IS NOT NULL;


-- Limpeza da tabela olist_customers_dataset
CREATE OR REPLACE VIEW `olist_clean.customers_clean` AS
SELECT *
FROM `olist_raw.customers`
WHERE customer_id IS NOT NULL
  AND customer_city IS NOT NULL
  AND customer_state IS NOT NULL;

-- Limpeza da tabela olist_products_dataset
CREATE OR REPLACE VIEW `olist_clean.product_clean` AS
SELECT *
FROM `olist_raw.product`
WHERE product_id IS NOT NULL
  AND product_category_name IS NOT NULL
  AND product_weight_g > 0;

-- Limpeza da tabela olist_sellers_dataset
CREATE OR REPLACE VIEW `olist_clean.sellers_clean` AS
SELECT *
FROM `olist_raw.sellers`
WHERE seller_id IS NOT NULL
  AND seller_city IS NOT NULL
  AND seller_state IS NOT NULL;

-- Limpeza da tabela olist_geolocation_dataset (opcional: deduplicar por CEP)
CREATE OR REPLACE VIEW `olist_clean.geolocation_clean` AS
SELECT DISTINCT *
FROM `olist_raw.geolocation`
WHERE geolocation_zip_code_prefix IS NOT NULL
  AND geolocation_lat IS NOT NULL
  AND geolocation_lng IS NOT NULL;
