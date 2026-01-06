

USE Excursions;
GO

CREATE TABLE Buses (
    bus_id INT IDENTITY(1,1) PRIMARY KEY,
    model VARCHAR(50) NOT NULL,
    plate_number VARCHAR(15) NOT NULL UNIQUE,
    capacity INT CHECK (capacity > 0),
    [year] INT CHECK ([year] >= 1990)
);
GO

CREATE TABLE Drivers (
    driver_id INT IDENTITY(1,1) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    experience_years INT CHECK (experience_years >= 0),
    phone VARCHAR(20) UNIQUE
);
GO

CREATE TABLE Customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE
);
GO

CREATE TABLE Excursions (
    excursion_id INT IDENTITY(1,1) PRIMARY KEY,
    route_name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    duration_hours INT CHECK (duration_hours > 0),
    price DECIMAL(10,2) CHECK (price >= 0),
    bus_id INT NOT NULL,
    driver_id INT NOT NULL,
    customer_id INT NOT NULL,
    CONSTRAINT FK_Excursions_Buses FOREIGN KEY (bus_id) REFERENCES Buses(bus_id),
    CONSTRAINT FK_Excursions_Drivers FOREIGN KEY (driver_id) REFERENCES Drivers(driver_id),
    CONSTRAINT FK_Excursions_Customers FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
GO

CREATE TABLE Invoices (
    invoice_id INT IDENTITY(1,1) PRIMARY KEY,
    excursion_id INT NOT NULL UNIQUE,
    invoice_date DATE NOT NULL,
    total_amount DECIMAL(10,2) CHECK (total_amount >= 0),
    status VARCHAR(20)
        CHECK (status IN ('оплачено', 'частково', 'не оплачено')),
    CONSTRAINT FK_Invoices_Excursions FOREIGN KEY (excursion_id)
        REFERENCES Excursions(excursion_id)
);
GO

CREATE TABLE Payments (
    payment_id INT IDENTITY(1,1) PRIMARY KEY,
    invoice_id INT NOT NULL,
    payment_date DATE NOT NULL,
    amount DECIMAL(10,2) CHECK (amount > 0),
    CONSTRAINT FK_Payments_Invoices FOREIGN KEY (invoice_id)
        REFERENCES Invoices(invoice_id)
);
GO
