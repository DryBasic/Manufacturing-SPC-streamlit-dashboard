-- grouping measurements thematically for front end
CREATE TABLE measurement_group (
    group_id INTEGER PRIMARY KEY,
    group_name TEXT NOT NULL,
    group_desc TEXT
);

-- bank of all numeric measurements collected for part lots
CREATE TABLE measurement (
    measurement_id INTEGER PRIMARY KEY,
    measurement_name TEXT NOT NULL,
    measurement_desc TEXT,
    measurement_unit TEXT NOT NULL,
    control TEXT CHECK(control IN ('upper', 'lower', 'two')),
    group_id INTEGER REFERENCES measurement_group (group_id)
);

-- parts of which lots are manufactured and for which measurements are collected
CREATE TABLE part (
    part_id INTEGER PRIMARY KEY,
    part_name TEXT,
    part_desc TEXT,
);

-- manufactured instances of a part for whom measurements are collected
CREATE TABLE lot (
    lot_id INTEGER PRIMARY KEY,
    part_id INTEGER REFERENCES part (part_id),
    date_of_manufacture DATE NOT NULL,
    date_of_expiration DATE,
    comments TEXT
);

-- specifications for a given part
CREATE TABLE specification (
    part_id INTEGER REFERENCES part (part_id),
    measurement_id INTEGER REFERENCES measurement (measurement_id),
    lower_limit NUMERIC,
    upper_limit NUMERIC
);

-- the actual measurements collected for a given lot
CREATE TABLE measurement_value (
    part_id INTEGER REFERENCES part (part_id),
    lot_id INTEFER REFERENCES lot (lot_id),
    measurement_id INTEGER REFERENCES measurement (measurement_id),
    date_of_measurement DATE,
    value NUMERIC
);



