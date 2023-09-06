INSERT INTO measurement_group 
(group_name, group_desc)
VALUES
('In-Process Testing', 'Measurements collected during the manufacturing process that may not have specifications.'),
('Final Specifications', 'Measurements by which the part is qualified.');

INSERT INTO measurement
(measurement_name, measurement_desc, measurement_unit, control, group_id)
VALUES
('Concentration', NULL, 'mM', 'two', 2),
('TOC', NULL, 'ppm', 'upper', 1),
('Volume', NULL, 'L', 'lower', 1),
('Absorbance', NULL, 'AU', 'two', 2),
('Yield', NULL, '%', 'lower', 1),
('Purity', NULL, '%', 'lower', 1),
('Purity', NULL, '%', 'lower', 2),
('Conductivity', NULL, 'mS', 'two', 2);

INSERT INTO part 
(part_name, part_desc)
VALUES
('Buffer A', NULL),
('Buffer B', NULL),
('Buffer X', NULL),
('Compound A', NULL),
('Compound B', NULL),
('Compound C', NULL),
('Compound D', NULL);


INSERT INTO specification
(part_id, measurement_id, lower_limit, upper_limit)
VALUES
(1, 1, 12.5, 15),
(1, 2, NULL, 750),
(1, 3, 8.0, NULL),
(1, 8, 3025, 4125),
(2, 1, 8, 11),
(2, 2, NULL, 690),
(2, 3, 8.0, NULL),
(2, 8, 1000, 1250),
(3, 1, 5, 8.5),
(3, 2, NULL, 1000),
(3, 3, 5.0, NULL),
(3, 8, NULL, 850),
(3, 4, 0.100, 0.150),
(4, 5, 70, NULL),
(4, 6, 80, NULL),
(4, 7, 90, NULL),
(5, 5, 60, NULL),
(5, 6, 75, NULL),
(5, 7, 95, NULL),
(6, 5, 55, NULL),
(6, 6, 75, NULL),
(6, 7, 90, NULL),
(7, 5, 40, NULL),
(7, 6, 88, NULL),
(7, 7, 98, NULL);


    WITH spec AS (
        SELECT 
            part.part_id
            , lot.lot_id
            , spec.measurement_id
            , part.part_name
            , spec.upper_specification
            , spec.
        FROM 
            part
        INNER JOIN 
            lot 
            ON lot.part_id = part.part_id
        INNER JOIN 
            specification AS spec
            ON spec.part_id = part.part_id
    )
    SELECT 
        part.part_name 
        , grp.group_name
        , msm.measurement_name
        , val.value 
        , msm.sidedness
        , spc.upper_specification
        , spc.lower_specification
    FROM
        measurement_group AS grp 
    INNER JOIN 
        measurement AS msm
        ON grp.group_id = msm.group_id
    INNER JOIN 
        measurement_value AS val 
        ON val.measurement_id = msm.measurement_id
        AND val.part_id = spec.part_id
        AND val.lot_id = spec.lot_id