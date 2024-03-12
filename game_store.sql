-- Drop the table if it exists
DROP TABLE IF EXISTS game CASCADE;

-- Create Games Table
CREATE TABLE game (
    game_id INT PRIMARY KEY,
    game_title VARCHAR(255) 
        UNIQUE 
        NOT NULL CHECK (game_title ~ '^[A-Za-z0-9 _\-:''\\]+$'),
    quantity INT NOT NULL CHECK(quantity > 0 AND quantity < 51),
    price DECIMAL(5, 2) NOT NULL CHECK(price > 10 AND price < 60)
);

\COPY game FROM '/home/neka/projects/gamestore/data/game.csv' WITH CSV HEADER;
SELECT * FROM game;


DROP TABLE IF EXISTS action_figure;

CREATE TABLE action_figure (
    action_figure_id INT PRIMARY KEY,
    action_figure_title VARCHAR UNIQUE NOT NULL CHECK (action_figure_title ~ '^[A-Za-z0-9 _-]+$'),
    quantity INT NOT NULL CHECK(quantity > 0 AND quantity < 31),
    price DECIMAL(5,2) NOT NULL CHECK(price > 10 AND price < 100.01)
);

\COPY action_figure FROM '/home/neka/projects/gamestore/data/action_figure.csv' WITH CSV HEADER;

SELECT * FROM action_figure;


DROP TABLE IF EXISTS poster;

CREATE TABLE poster (
    poster_id INT PRIMARY KEY,
    poster_title VARCHAR
        UNIQUE
        CHECK (poster_title ~ '^[A-Za-z0-9 _-]+$'),
    quantity INT CHECK (quantity > 0 AND quantity <= 30),
    price DECIMAL(4, 2) NOT NULL CHECK (price >= 6 AND price <= 20.00)
);

\COPY poster FROM '/home/neka/projects/gamestore/data/poster.csv' WITH CSV HEADER;
SELECT * FROM poster;


DROP TABLE IF EXISTS employee CASCADE;

CREATE TABLE employee (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) 
        NOT NULL 
        CHECK (employee_name ~ '^[A-Z][A-Za-z ]+$'),
    position VARCHAR(100) 
        NOT NULL 
        CHECK ( position IN ('Sales Associate', 'Store Manager', 'Inventory Clerk', 'Customer Service Representative', 'IT Specialist', 'Marketing Coordinator', 'Assistant Manager', 'Finance Analyst', 'Security Officer', 'HR Coordinator')),
    salary DECIMAL(7, 2) CHECK (salary > 31000 AND salary <= 65000)
);
--DID CALCULATIONS BY MULTIPLYING DOLLARS PER HR BY 40/HRS PER WEEK

\COPY employee FROM '/home/neka/projects/gamestore/data/employee.csv' WITH CSV HEADER;

SELECT * FROM employee;


DROP TABLE IF EXISTS genre CASCADE;

CREATE TABLE genre (
    genre_id BIGINT PRIMARY KEY,
    genre_name VARCHAR(50) NOT NULL
);

\COPY genre FROM '/home/neka/projects/gamestore/data/genre.csv' WITH CSV HEADER;

SELECT * FROM genre;


DROP TABLE IF EXISTS gaming_engine;

CREATE TABLE gaming_engine(
    gaming_engine_id BIGINT PRIMARY KEY,
    engine VARCHAR(50) UNIQUE
);

\COPY gaming_engine FROM '/home/neka/projects/gamestore/data/gaming_engine.csv' WITH CSV HEADER;

SELECT * FROM gaming_engine;


DROP TABLE IF EXISTS social_security;

CREATE TABLE social_security (
    social_security_id BIGINT PRIMARY KEY,
    employee_id INT,
    security_number VARCHAR(11) UNIQUE NOT NULL CHECK (security_number ~ '^\d{3}-\d{2}-\d{4}$'),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);

\COPY social_security FROM '/home/neka/projects/gamestore/data/social_security.csv' WITH CSV HEADER;

SELECT * FROM social_security;


DROP TABLE IF EXISTS shifts;

CREATE TABLE shifts (
    shifts_id BIGINT PRIMARY KEY,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    employee BIGINT
);

\COPY shifts FROM '/home/neka/projects/gamestore/data/shifts.csv' WITH CSV HEADER;

SELECT * FROM shifts;

DROP TABLE IF EXISTS genre_game;

CREATE TABLE genre_game (
    genre_game_id BIGINT,
    game_id BIGINT,
    genre_id BIGINT,
    PRIMARY KEY (game_id, genre_id),
    FOREIGN KEY (game_id) REFERENCES game (game_id),
    FOREIGN KEY (genre_id) REFERENCES genre (genre_id)
);

\COPY genre_game FROM '/home/neka/projects/gamestore/data/genre_game.csv' WITH CSV HEADER;

SELECT * FROM genre_game;



-- in psql shell
-- run the following command starting at the backslash and i in your DB
--\i /home/neka/projects/gamestore/game_store.sql

-- in terminal can run
-- psql store_db < store.sql to run the same thing as above

--regex
-- a simple and commonly used regex pattern for email validation that covers many practical cases is:

-- ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$

-- This pattern checks for a string that:
-- Begins with one or more characters that can be alphanumeric (a-zA-Z0-9), dots (.), underscores (_), percent signs (%), plus signs (+), or hyphens (-).
-- Contains an at-symbol (@).
-- Follows with one or more characters that can be alphanumeric or dots/hyphens.
-- Ends with a dot (.) followed by two or more alphabetic characters, to represent the domain.


--gamestore iv stage problem set
-- Add genres into our games where many games can have many genres through a connecting table genre_game.
-- Add gaming_engine where many games can belong to one engine.
-- Add social_security where every employee should have a single ssn entry.
-- Add shift for employees tracking timestamps for start and end times where an employee can have many shifts.