
--- @rahmani3101
--- sales funnel analysis

SELECT * FROM `sales-funnel-analysis-487918.users.user_events` 
LIMIT 10;

WITH tunnel_stages as(
  SELECT
  COUNT(DISTINCT CASE WHEN event_type ='page_view' THEN user_id END) as stage_1_view,
  COUNT(DISTINCT CASE WHEN event_type ='add_to_cart' THEN user_id END) as stage_2_view,
  COUNT(DISTINCT CASE WHEN event_type ='checkout_start' THEN user_id END) as stage_3_view,
  COUNT(DISTINCT CASE WHEN event_type ='payment_info' THEN user_id END) as stage_4_view,
  COUNT(DISTINCT CASE WHEN event_type ='purchase' THEN user_id END) as stage_5_view
  FROM `sales-funnel-analysis-487918.users.user_events`
  WHERE event_date >= TIMESTAMP(DATE_SUB(CURRENT_DATE(),INTERVAL 30 DAY))
 
)

SELECT * FROM tunnel_stages


-- conversion rate through the funnel

WITH funnel_stage AS (
    SELECT
        COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS stage_1_view,
        COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) AS stage_2_cart,
        COUNT(DISTINCT CASE WHEN event_type = 'checkout_start' THEN user_id END) AS stage_3_checkout,
        COUNT(DISTINCT CASE WHEN event_type = 'payment_info' THEN user_id END) AS stage_4_payment,
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS stage_5_purchase
    FROM `sales-funnel-analysis-487918.users.user_events` 
    WHERE event_date >= TIMESTAMP(DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY))
)
SELECT 
  stage_1_view,
  stage_2_cart,
  ROUND(stage_2_cart * 100.0 / stage_1_view, 2) AS view_to_cart_rate,
  stage_3_checkout,
  ROUND(stage_3_checkout * 100.0 / stage_2_cart, 2) AS cart_to_checkout_rate,
  stage_4_payment,
  ROUND(stage_4_payment * 100.0 / stage_3_checkout, 2) AS checkout_to_payment_rate,
  stage_5_purchase,
  ROUND(stage_5_purchase * 100.0 / stage_4_payment, 2) AS payment_to_purchase_rate,
  ROUND(stage_5_purchase * 100.0 / stage_1_view, 2) AS overall_conversion_rate
FROM funnel_stage;



-- funnel by source

WITH source_funnel AS
(
  SELECT
  traffic_source,
        COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS views,
        COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) AS carts,
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS purchases
    FROM `sales-funnel-analysis-487918.users.user_events` 
    WHERE event_date >= TIMESTAMP(DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY))
    GROUP BY traffic_source

)
SELECT 
  traffic_source,
  views,
  carts,
  purchases,
  ROUND(carts * 100.0 / views, 2) AS cart_conversion_rate,
  ROUND(purchases * 100.0 / views, 2) AS purchases_conversion_rate,
  ROUND(purchases * 100.0 / carts, 2) AS cart_to_purchases_conversion_rate,
FROM source_funnel
ORDER BY purchases DESC

--- time to conversion analysis

WITH user_journey AS
(
  SELECT
  user_id,
        MIN( CASE WHEN event_type = 'page_view' THEN event_date END) AS view_time,
        MIN( CASE WHEN event_type = 'add_to_cart' THEN event_date END) AS cart_time,
        MIN(CASE WHEN event_type = 'purchase' THEN event_date END) AS purchase_time
    FROM `sales-funnel-analysis-487918.users.user_events` 
    WHERE event_date >= TIMESTAMP(DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY))
    GROUP BY user_id
    HAVING MIN(CASE WHEN event_type = 'purchase' THEN event_date END) IS NOT NULL

)
SELECT
  COUNT(*) AS converted_users,
  ROUND(AVG(TIMESTAMP_DIFF(cart_time,view_time,MINUTE)),2) as avg_view_to_cart_minutes,
  ROUND(AVG(TIMESTAMP_DIFF(purchase_time,cart_time,MINUTE)),2) as avg_cart_to_purchage_minutes,
  ROUND(AVG(TIMESTAMP_DIFF(purchase_time,view_time,MINUTE)),2) as avg_view_total_journey_minutes
FROM user_journey  


--- revenue funnel analysis

WITH funnel_revenue AS
(
  SELECT
  
    COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS total_visitor,
    COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS total_buyers,
    SUM(CASE WHEN event_type = 'purchase' THEN amount END) AS total_revenue,
    COUNT(CASE WHEN event_type = 'purchase' THEN 1 END) AS total_orders,
    
    
    FROM `sales-funnel-analysis-487918.users.user_events` 
    WHERE event_date >= TIMESTAMP(DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY))

)
SELECT 
  total_visitor,
  total_buyers,
  total_revenue,
  total_orders,
  total_revenue / total_orders as avg_order_value,
  total_revenue / total_buyers as revenue_per_buyer,
  total_revenue / total_visitor as revenue_per_visitor,    
FROM funnel_revenue