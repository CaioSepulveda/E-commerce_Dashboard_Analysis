-- Limpeza da tabela olist_orders_dataset
CREATE OR REPLACE VIEW `olist_clean.order_clean` AS
SELECT *
FROM `olist_raw.orders`
WHERE order_purchase_timestamp IS NOT NULL
  AND order_status IS NOT NULL
  AND customer_id IS NOT NULL
  AND order_delivered_customer_date IS NOT NULL;

