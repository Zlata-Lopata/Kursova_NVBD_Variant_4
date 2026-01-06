CREATE DATABASE Excursions_DWH;
GO

USE Excursions_DWH;
GO

CREATE TABLE DimDate (
    DateKey INT PRIMARY KEY,
    FullDate DATE NOT NULL,
    [Year] INT,
    [Quarter] INT,
    [Month] INT,
    [Day] INT
);

CREATE TABLE DimExcursion (
    ExcursionKey INT IDENTITY(1,1) PRIMARY KEY,
    excursion_id INT,        
    route_name VARCHAR(100)
);

CREATE TABLE DimBuses (
    BusKey INT IDENTITY(1,1) PRIMARY KEY,
    bus_id INT,
    model VARCHAR(50),
    plate_number VARCHAR(15),
    capacity INT,
    [year] INT
);

CREATE TABLE DimDrivers (
    DriverKey INT IDENTITY(1,1) PRIMARY KEY,
    driver_id INT,
    full_name VARCHAR(100),
    experience_years INT,
    phone VARCHAR(20)
);

CREATE TABLE DimCustomers (
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE FactExcursion (
    ExcursionKey INT,
    DateKey INT,
    BusKey INT,
    DriverKey INT,
    CustomerKey INT,
    duration_hours INT,
    price DECIMAL(10,2),
    num_customers INT
);

CREATE TABLE FactPayment (
    DateKey INT,
    ExcursionKey INT,
    CustomerKey INT,
    payment_id INT,
    amount DECIMAL(10,2),
    num_payments INT,
    outs_balance DECIMAL(10,2)
);


