CREATE DATABASE IF NOT EXISTS marketing_analysis;
USE marketing_analysis;

CREATE TABLE marketing_campaigns (
    Campaign_ID INT,
    Channel_Used VARCHAR(50),
    Acquisition_Cost DECIMAL(12,2),
    ROI DECIMAL(6,4),
    Clicks INT,
    Impressions INT,
    Date DATE,
    CTR DECIMAL(8,6),
    CPC DECIMAL(8,6),
    CPM DECIMAL(8,6)
);

LOAD DATA INFILE 'marketing_campaign_dataset.csv'
INTO TABLE marketing_campaigns
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

SELECT COUNT(*) FROM marketing_campaigns;
SELECT * FROM marketing_campaigns LIMIT 10;


SELECT
  Channel_Used,
  SUM(Impressions) AS total_impressions,
  SUM(Clicks) AS total_clicks,
  ROUND(AVG(CTR)*100, 2) AS avg_ctr_percent,
  ROUND(AVG(CPC), 2) AS avg_cpc,
  ROUND(AVG(CPM), 2) AS avg_cpm,
  ROUND(AVG(ROI)*100, 2) AS avg_roi_percent
FROM marketing_campaigns
GROUP BY Channel_Used
ORDER BY avg_roi_percent DESC;

SELECT
  Channel_Used,
  ROUND(AVG(ROI)*100, 2) AS avg_roi_percent,
  SUM(Acquisition_Cost) AS total_spend
FROM marketing_campaigns
GROUP BY Channel_Used
ORDER BY avg_roi_percent DESC;

SELECT
  Campaign_ID, Channel_Used, CTR, CPC, CPM, ROI
FROM marketing_campaigns
ORDER BY ROI DESC
LIMIT 10;
