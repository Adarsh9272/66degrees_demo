CREATE OR REPLACE TABLE `first-316417.66d_demo.customers` (
    `Customer type` STRING,
    Gender STRING,
    City STRING,
    Branch STRING
);

CREATE OR REPLACE TABLE `first-316417.66d_demo.products` (
    `Product line` STRING,
    `Unit price` FLOAT64
);

CREATE OR REPLACE TABLE `first-316417.66d_demo.sales` (
    `Invoice ID` STRING,
    `Order Timestamp` timestamp,
    Quantity INT64,
    `Tax 5%` FLOAT64,
    Total FLOAT64,
    cogs FLOAT64,
    `gross margin percentage` FLOAT64,
    `gross income` FLOAT64,
    Rating FLOAT64,
    Payment STRING,
    `Product line` STRING,
    Branch STRING
);