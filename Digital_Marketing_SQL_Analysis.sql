-- DATA-DRIVEN INSIGHTS FOR DIGITAL MARKETING CAMPAIGNS
-- SQL ANALYSIS SCRIPT
-- Table names correspond to the CSV/Excel analytical sheets.

-- 1. Channel performance
SELECT Channel, SUM(Users) AS Total_Users, SUM(New_users) AS New_Users,
       SUM(Cost) AS Total_Cost, SUM(Revenue) AS Total_Revenue,
       SUM(Revenue)/NULLIF(SUM(Cost),0) AS ROAS,
       (SUM(Revenue)-SUM(Cost))/NULLIF(SUM(Cost),0) AS ROI
FROM user_acquisition
GROUP BY Channel
ORDER BY Total_Revenue DESC;

-- 2. Engagement and key-event rate
SELECT Channel, AVG(Engagement_rate) AS Engagement_Rate,
       SUM(Key_events) AS Key_Events,
       SUM(Key_events)*1.0/NULLIF(SUM(Users),0) AS Key_Event_Rate
FROM user_acquisition
GROUP BY Channel
ORDER BY Engagement_Rate DESC;

-- 3. Conversion funnel
SELECT Event_name, SUM(Event_count) AS Event_Count, SUM(Total_users) AS Users
FROM events
WHERE Event_name IN ('view_item','add_to_cart','begin_checkout','purchase')
GROUP BY Event_name;

-- 4. Top landing pages
SELECT Landing_page, SUM(Sessions) AS Sessions, SUM(Users) AS Users,
       SUM(Total_revenue) AS Revenue
FROM landing_pages
GROUP BY Landing_page
ORDER BY Revenue DESC;

-- 5. Audience performance
SELECT Audience_name, SUM(Users) AS Users, SUM(Sessions) AS Sessions,
       SUM(Total_revenue) AS Revenue
FROM audience
GROUP BY Audience_name
ORDER BY Revenue DESC;

-- 6. Country performance
SELECT Country, SUM(Users) AS Users, SUM(Total_revenue) AS Revenue
FROM country
GROUP BY Country
ORDER BY Revenue DESC;

-- 7. Age performance
SELECT Age, SUM(Users) AS Users, SUM(Total_revenue) AS Revenue
FROM age
GROUP BY Age
ORDER BY Revenue DESC;

-- 8. Gender performance
SELECT Gender, SUM(Users) AS Users, SUM(Total_revenue) AS Revenue
FROM gender
GROUP BY Gender
ORDER BY Revenue DESC;

-- 9. Interest performance
SELECT Interests, SUM(Users) AS Users, SUM(Total_revenue) AS Revenue
FROM interests
GROUP BY Interests
ORDER BY Revenue DESC;

-- 10. Measurement reconciliation
SELECT
 (SELECT SUM(Total_users) FROM events WHERE Event_name='purchase') AS Purchase_Event_Users,
 (SELECT SUM(Users) FROM audience WHERE Audience_name='Purchasers') AS Purchasers_Audience_Users;
