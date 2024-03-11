-- Drop the table if it exists
DROP TABLE IF EXISTS game_store;

-- Create Games Table
CREATE TABLE games (
    game_id INT PRIMARY KEY,
    game_title VARCHAR(100) UNIQUE,
    quantity INT,
    price DECIMAL(5, 2)
);

CREATE TABLE action_figure (
    figure_id INT PRIMARY KEY,
    action_figure_title VARCHAR(100) UNIQUE,
    quantity INT,
    price DECIMAL(4, 2)
);

CREATE TABLE poster (
    poster_id INT PRIMARY KEY,
    poster_title VARCHAR(100) UNIQUE,
    quantity INT,
    price DECIMAL(4, 2)
);

CREATE TABLE employee (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    position VARCHAR(100),
    salary DECIMAL(8, 2)
);

