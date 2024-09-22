use Barber_Shop;

CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(255),
    password VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    social_login BIT,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE Profiles (
    profile_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT FOREIGN KEY REFERENCES Users(user_id),
    full_name VARCHAR(255),
    phone_number VARCHAR(20),
    address VARCHAR(255),
    date_of_birth DATE,
    gender VARCHAR(10) CHECK (gender IN ('Male', 'Female', 'Other')),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE Services (
    service_id INT PRIMARY KEY IDENTITY(1,1),
    service_name VARCHAR(255),
    duration INT,
    price DECIMAL(10, 2),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);


CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT FOREIGN KEY REFERENCES Users(user_id),
    service_id INT FOREIGN KEY REFERENCES Services(service_id),
    appointment_time DATETIME,
    status VARCHAR(20) CHECK (status IN ('Pending', 'Confirmed', 'Cancelled', 'Completed')),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE History (
    history_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT FOREIGN KEY REFERENCES Users(user_id),
    service_id INT FOREIGN KEY REFERENCES Services(service_id),
    appointment_time DATETIME,
    created_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE Notifications (
    notification_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT FOREIGN KEY REFERENCES Users(user_id),
    message TEXT,
    is_read BIT,
    created_at DATETIME DEFAULT GETDATE()
);

ALTER TABLE Profiles
ADD CONSTRAINT FK_Profiles_Users FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE;

ALTER TABLE Appointments
ADD CONSTRAINT FK_Appointments_Users FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE;

ALTER TABLE Appointments
ADD CONSTRAINT FK_Appointments_Services FOREIGN KEY (service_id) REFERENCES Services(service_id) ON DELETE CASCADE;

ALTER TABLE History
ADD CONSTRAINT FK_History_Users FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE;

ALTER TABLE History
ADD CONSTRAINT FK_History_Services FOREIGN KEY (service_id) REFERENCES Services(service_id) ON DELETE CASCADE;

ALTER TABLE Notifications
ADD CONSTRAINT FK_Notifications_Users FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE;

