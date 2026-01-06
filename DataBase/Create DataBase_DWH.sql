CREATE DATABASE Excursions_DWH;
GO

USE Excursions_DWH;
GO

CREATE TABLE Dim_Date (
    date_id INT PRIMARY KEY IDENTITY(1,1),
    Date DATE NULL,
    Year INT NULL,
    Month INT NULL,
    Day INT NULL
);
GO

CREATE TABLE Dim_Excursion (
    excursion_id INT PRIMARY KEY IDENTITY(1,1),
    route_name VARCHAR(100),
    excursion_key INT NULL
);
GO

CREATE TABLE Dim_Bus (
    bus_id INT PRIMARY KEY IDENTITY(1,1),
    model VARCHAR(50),
    plate_number VARCHAR(15),
    capacity INT,
    [year] INT,
    bus_key INT NULL
);
GO

CREATE TABLE Dim_Driver (
    driver_id INT PRIMARY KEY IDENTITY(1,1),
    full_name VARCHAR(100),
    experience_years INT,
    phone VARCHAR(20),
    driver_key INT NULL
);
GO

CREATE TABLE Dim_Customer (
    customer_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    customer_key INT NULL
);
GO

CREATE TABLE Dim_Invoice (
    invoice_id INT PRIMARY KEY IDENTITY(1,1),
    invoice_date DATE,
    total_amount DECIMAL(10,2),
    status VARCHAR(20) CHECK (status IN ('оплачено','частково','не оплачено')),
    invoice_key INT NULL
);
GO


Таблиці фактів:
CREATE TABLE Fact_Excursion (
    fact_id INT PRIMARY KEY IDENTITY(1,1),
    excursion_id INT NULL,
    date_id INT NULL,
    bus_id INT NULL,
    driver_id INT NULL,
    customer_id INT NULL,
    invoice_id INT NULL,
    duration_hours INT NULL,
    price DECIMAL(10,2) NULL,
    num_customers INT NULL,
    FOREIGN KEY (excursion_id) REFERENCES Dim_Excursion(excursion_id),
    FOREIGN KEY (date_id) REFERENCES Dim_Date(date_id),
    FOREIGN KEY (bus_id) REFERENCES Dim_Bus(bus_id),
    FOREIGN KEY (driver_id) REFERENCES Dim_Driver(driver_id),
    FOREIGN KEY (customer_id) REFERENCES Dim_Customer(customer_id),
    FOREIGN KEY (invoice_id) REFERENCES Dim_Invoice(invoice_id)
);
GO

-- Факт оплати
CREATE TABLE Fact_Payment (
    fact_id INT PRIMARY KEY IDENTITY(1,1),
    payment_id INT NULL, -- з OLTP
    invoice_id INT NULL,
    excursion_id INT NULL,
    customer_id INT NULL,
    date_id INT NULL,
    amount DECIMAL(10,2) NULL,
    FOREIGN KEY (invoice_id) REFERENCES Dim_Invoice(invoice_id),
    FOREIGN KEY (excursion_id) REFERENCES Dim_Excursion(excursion_id),
    FOREIGN KEY (customer_id) REFERENCES Dim_Customer(customer_id),
    FOREIGN KEY (date_id) REFERENCES Dim_Date(date_id)
);
GO
