-- Gebruik de depotproject_backend database
USE depotproject_backend;

-- Database creëren voor het project
CREATE DATABASE depotproject_backend;

-- ===================================================================
-- 1. Oplevering van de gebruikers (users) tabel
-- ===================================================================

-- Aanmaken van de users tabel
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phoneNumber VARCHAR(15),
    location VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Wijzigingen voor gebruikersaccount
ALTER TABLE users
ADD COLUMN profilePicture VARCHAR(255) DEFAULT NULL,
ADD COLUMN notifications BOOLEAN DEFAULT TRUE;

ALTER TABLE users 
ADD COLUMN gender VARCHAR(10) DEFAULT NULL,
ADD COLUMN bio TEXT DEFAULT NULL,
ADD COLUMN dob DATE DEFAULT NULL;

-- Wijzigingen voor wachtwoord herstel
ALTER TABLE users 
ADD COLUMN resetPasswordToken VARCHAR(255),
ADD COLUMN resetPasswordExpires DATETIME;

-- Toevoegen van timestamp voor het laatst gewijzigde wachtwoord
ALTER TABLE users ADD lastPasswordReset TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- ===================================================================
-- 2. Feedback Formulier
-- ===================================================================

-- Tabel voor het feedbackformulier
CREATE TABLE feedback (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    comments TEXT NOT NULL,
    rating INT NOT NULL,
    category VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ===================================================================
-- 3. Battery Dashboard
-- ===================================================================

-- Tabel voor batterij
CREATE TABLE Battery (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    capacity VARCHAR(255),
    installation_date DATE,
    user_id VARCHAR(255)
);

-- ===================================================================
-- 4. Multi-Factor Authenticatie (MFA)
-- ===================================================================

-- Eerste set van MFA kolommen toevoegen
ALTER TABLE users
ADD COLUMN mfa_secret VARCHAR(40) DEFAULT NULL,
ADD COLUMN mfa_enabled BOOLEAN DEFAULT 0,
ADD COLUMN mfa_method VARCHAR(30) DEFAULT NULL;

-- Tweede set van MFA kolommen toevoegen
ALTER TABLE users
ADD COLUMN mfa_code VARCHAR(6) DEFAULT NULL,
ADD COLUMN mfa_expiry BIGINT DEFAULT NULL;

-- ===================================================================
-- 5. Simulatie Dashboard
-- ===================================================================

-- Tabel voor simulaties
CREATE TABLE simulations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    residents INT,
    panels INT,
    panel_power DECIMAL(10, 2),
    panel_efficiency DECIMAL(10, 2),
    battery_capacity DECIMAL(10, 2),
    charge_rate DECIMAL(10, 2),
    battery_efficiency DECIMAL(10, 2),
    energy_usage_method VARCHAR(50),
    custom_kwh_usage FLOAT,
    pricing_option VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
); 

-- ===================================================================
-- 6. Simulatie Tabel (Alternatieve versie)
-- ===================================================================

-- Alternatieve versie van de simulatie tabel
CREATE TABLE simulatie (
    id INT AUTO_INCREMENT PRIMARY KEY,          -- Unique identifier for each simulation
    user_id INT NULL,                           -- Optional: ID of the user (foreign key if users table exists)
    energy_usage FLOAT NOT NULL,                -- Energy usage per day in kWh
    house_size VARCHAR(50) NOT NULL,            -- Size of the house (e.g., "<50m²", "50-100m²")
    insulation_level VARCHAR(20) NOT NULL,      -- Insulation level (e.g., "Good", "Average", "Poor")
    battery_capacity FLOAT NOT NULL,            -- Battery capacity in kWh
    battery_efficiency FLOAT DEFAULT 90,        -- Battery efficiency in percentage (default: 90%)
    charge_rate FLOAT NOT NULL,                 -- Charging rate in kW
    energy_cost FLOAT NOT NULL,                 -- Cost of energy per kWh (€)
    return_rate FLOAT NOT NULL,                 -- Return rate per kWh (€)
    use_dynamic_prices BOOLEAN DEFAULT FALSE,   -- Whether dynamic energy pricing is enabled
    simulation_result JSON NULL,                -- Results of the simulation (stored as JSON for flexibility)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Timestamp of when the simulation was created
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP -- Last updated timestamp
);

-- ===================================================================
-- 7. Verwijzing van simulatie naar gebruikers
-- ===================================================================

-- Voeg de foreign key relatie toe voor simulatie
ALTER TABLE simulatie
ADD CONSTRAINT fk_user
FOREIGN KEY (user_id) REFERENCES users(id)
ON DELETE CASCADE;

-- ===================================================================
-- 8. Indexen voor prestatieverbetering
-- ===================================================================

-- Maak indexen voor simulaties om prestaties te verbeteren
CREATE INDEX idx_user_id ON simulatie(user_id);
CREATE INDEX idx_created_at ON simulatie(created_at);

-- ===================================================================