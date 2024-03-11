-- Drop the table if it exists
DROP TABLE IF EXISTS games;
DROP TABLE IF EXISTS action_figure;
DROP TABLE IF EXISTS poster;
DROP TABLE IF EXISTS employee;

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

\COPY games FROM '/home/neka/projects/gamestore/data/game.csv' WITH CSV HEADER;
\COPY action_figure FROM '/home/neka/projects/gamestore/data/action_figure.csv' WITH CSV HEADER;
\COPY poster FROM '/home/neka/projects/gamestore/data/poster.csv' WITH CSV HEADER;
\COPY employee FROM '/home/neka/projects/gamestore/data/employee.csv' WITH CSV HEADER;

-- run the following command starting at the backslash and i in your DB
--\i /home/neka/projects/gamestore/game_store.sql