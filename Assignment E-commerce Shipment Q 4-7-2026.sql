-- E-commerce Shipment Tracking database. It includes multiple timestamps that allow for calculating durations, finding delays, and performing trend analysis.

CREATE DATABASE logistics_db;

USE logistics_db;

CREATE TABLE shipments (
shipment_id INT AUTO_INCREMENT PRIMARY KEY,
order_date DATETIME,
shipped_date DATETIME,
estimated_delivery_date DATETIME,
delivery_date DATETIME
);
INSERT INTO shipments (order_date, shipped_date, estimated_delivery_date, delivery_date) VALUES
('2026-01-05 10:00:00', '2026-01-06 09:00:00', '2026-01-10 18:00:00', '2026-01-09 14:00:00'),
('2026-01-12 11:30:00', '2026-01-13 10:00:00', '2026-01-17 18:00:00', '2026-01-18 09:00:00'),
('2026-01-20 08:00:00', '2026-01-21 07:00:00', '2026-01-25 18:00:00', NULL),
('2026-02-02 09:15:00', '2026-02-03 08:00:00', '2026-02-07 18:00:00', '2026-02-06 11:00:00'),
('2026-02-14 14:00:00', '2026-02-15 12:00:00', '2026-02-19 18:00:00', '2026-02-20 15:00:00'),
('2026-02-28 10:00:00', '2026-03-01 09:00:00', '2026-03-05 18:00:00', '2026-03-04 10:00:00'),
('2026-03-05 16:00:00', '2026-03-06 14:00:00', '2026-03-10 18:00:00', '2026-03-10 16:00:00'),
('2026-03-15 11:00:00', '2026-03-16 10:00:00', '2026-03-20 18:00:00', NULL),
('2026-04-01 09:00:00', '2026-04-02 08:00:00', '2026-04-06 18:00:00', '2026-04-05 09:00:00'),
('2026-04-10 10:00:00', '2026-04-11 09:00:00', '2026-04-15 18:00:00', '2026-04-16 12:00:00'),
('2026-04-20 08:00:00', '2026-04-21 07:00:00', '2026-04-25 18:00:00', '2026-04-24 17:00:00'),
('2026-05-01 12:00:00', '2026-05-02 11:00:00', '2026-05-06 18:00:00', '2026-05-06 10:00:00'),
('2026-05-15 09:00:00', '2026-05-16 08:00:00', '2026-05-20 18:00:00', '2026-05-21 09:00:00'),
('2026-05-25 14:00:00', '2026-05-26 13:00:00', '2026-05-30 18:00:00', '2026-05-30 15:00:00'),
('2026-06-01 10:00:00', '2026-06-02 09:00:00', '2026-06-06 18:00:00', NULL),
('2026-06-10 09:00:00', '2026-06-11 08:00:00', '2026-06-15 18:00:00', '2026-06-14 11:00:00'),
('2026-06-20 11:00:00', '2026-06-21 10:00:00', '2026-06-25 18:00:00', '2026-06-26 09:00:00'),
('2026-06-28 08:00:00', '2026-06-29 07:00:00', '2026-07-03 18:00:00', '2026-07-02 12:00:00'),
('2026-07-01 09:00:00', '2026-07-02 08:00:00', '2026-07-06 18:00:00', '2026-07-05 09:00:00'),
('2026-07-04 10:00:00', '2026-07-05 09:00:00', '2026-07-09 18:00:00', '2026-07-08 14:00:00');

-- Extract year, month, day
SELECT
    shipment_id,
    order_date,
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    DAY(order_date) AS order_day
FROM shipments;

-- 1. Find day of the week name

SELECT YEAR(order_date), MONTH(order_date), DAY(order_date) FROM shipments;

-- 2. Calculate total days to deliver

SELECT DAYNAME(order_date) FROM shipments;

-- 3. Identify late deliveries

SELECT shipment_id, DATEDIFF(delivery_date, order_date)
AS days_total FROM shipments;

-- 4. Filter orders by Month

SELECT * FROM shipments WHERE delivery_date > estimated_delivery_date;

-- 5. Filter orders by Month

SELECT * FROM shipments WHERE MONTH(order_date) = 2;

-- 6. Count orders per Year/Month

SELECT YEAR(order_date), MONTH(order_date), COUNT(*) FROM shipments GROUP BY 1, 2;

-- 7.Format date for report (DD/MM/YYYY)

SELECT DATE_FORMAT(order_date, '%d/%m/%Y') FROM shipments;

-- 8.Find shipments still in transit (NULL)

SELECT * FROM shipments WHERE delivery_date IS NULL;

-- 9 Add 3 days to order date (new estimation)

SELECT * FROM shipments WHERE delivery_date IS NULL;

-- 10. Find orders from a specific date range

SELECT * FROM shipments WHERE order_date BETWEEN '2026-03-01' AND '2026-03-31';

-- 11. Calculate transit time in hours

SELECT TIMESTAMPDIFF(HOUR, order_date, delivery_date) FROM shipments;

-- 12. Show day of the year (1-365)

SELECT DAYOFYEAR(order_date) FROM shipments;

-- 13. Filter orders by Quarter

SELECT * FROM shipments WHERE QUARTER(order_date) = 2;

-- 14. Get last day of the delivery month

SELECT LAST_DAY(delivery_date) FROM shipments;

-- 15. Identify fastest delivery (Order to Deliver)

SELECT * FROM shipments ORDER BY DATEDIFF(delivery_date, order_date) ASC LIMIT 1;

-- 16. Extract the hour of the order

SELECT HOUR(order_date) FROM shipments;

-- 17.Find orders placed on a weekend

SELECT * FROM shipments WHERE DAYOFWEEK(order_date) IN (1, 7);

-- 18. Compare current date vs order date

SELECT *, DATEDIFF(NOW(), order_date) AS days_since_order FROM shipments;

-- 19. Count shipments arrived on exact estimation

SELECT COUNT(*) FROM shipments WHERE delivery_date = estimated_delivery_date;
-- 20. Calculate avg shipping time (Process duration)

SELECT AVG(DATEDIFF(shipped_date, order_date)) FROM shipments;




