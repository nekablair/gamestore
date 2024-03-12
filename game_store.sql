-- Drop the table if it exists
DROP TABLE IF EXISTS games;
DROP TABLE IF EXISTS action_figure;
DROP TABLE IF EXISTS poster;
DROP TABLE IF EXISTS employee;

-- Create Games Table
CREATE TABLE games (
    game_id INT PRIMARY KEY,
    game_title VARCHAR(100) 
        UNIQUE 
        NOT NULL CHECK (game_title ~ '^[A-Za-z0-9 _\-:''\\]+$'),
    quantity INT NOT NULL CHECK(quantity > 0 AND quantity < 51),
    price DECIMAL(5, 2) NOT NULL CHECK(price > 10 AND price < 60)
);

CREATE TABLE action_figure (
    figure_id INT PRIMARY KEY,
    action_figure_title VARCHAR(100) 
        UNIQUE 
        NOT NULL CHECK (game_title ~ '^[A-Za-z0-9 _\-:''\\]+$'),
    quantity INT
        NOT NULL CHECK (quantity <= 30),
    price DECIMAL(4, 2)
        NOT NULL CHECK (price >= 10 AND price <= 100)
);

CREATE TABLE poster (
    poster_id INT PRIMARY KEY,
    poster_title VARCHAR(100) 
        UNIQUE
        CHECK (poster_title ~ '^[A-Z][A-Za-z ]+$'),
    quantity INT CHECK (quantity > 0 AND quantity <= 30),
    price DECIMAL(4, 2) NOT NULL CHECK (price >= 6 AND price <= 20)
);

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

\COPY games FROM '/home/neka/projects/gamestore/data/game.csv' WITH CSV HEADER;
\COPY action_figure FROM '/home/neka/projects/gamestore/data/action_figure.csv' WITH CSV HEADER;
\COPY poster FROM '/home/neka/projects/gamestore/data/poster.csv' WITH CSV HEADER;
\COPY employee FROM '/home/neka/projects/gamestore/data/employee.csv' WITH CSV HEADER;

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