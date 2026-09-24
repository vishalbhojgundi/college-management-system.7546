-- Run this against your existing college_management_system database.
-- Adds login support (admin / staff / parent) on top of your existing
-- course, student, weekly_test tables.

USE college_management_system;

CREATE TABLE IF NOT EXISTS users (
    user_id  INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50)  NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role     VARCHAR(20)  NOT NULL   -- 'ADMIN', 'STAFF', 'PARENT'
);

-- Sample accounts (plain text for now — see README for notes on hashing).
INSERT INTO users (username, password, role) VALUES
('admin',  'admin123',  'ADMIN'),
('staff1', 'staff123',  'STAFF'),
('parent1','parent123', 'PARENT');
