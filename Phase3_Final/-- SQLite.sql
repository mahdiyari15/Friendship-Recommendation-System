-- SQLite
-- ALTER table Cast_rating rename to Cast_rating
-- ALTER TABLE Director_rating DROP COLUMN director_id;

ALTER TABLE Director_rating ADD COLUMN director_id INTEGER;
UPDATE Director_rating
SET director_id = (
    SELECT director_id
    FROM Director
    WHERE trim(director_name) = trim(Director_rating.director_name)
);

-- ALTER TABLE Director_rating DROP COLUMN Cast;
-- ALTER TABLE user_Director_ratings RENAME   TO Director_rating;;
ALTER TABLE Director_count ADD COLUMN director_id INTEGER;
UPDATE Director_count
SET director_id = (
    SELECT directlor_id
    FROM Director
    WHERE trim(director_name) = trim(Director_count.director_name)
);

ALTER TABLE Director_count DROP COLUMN director_name;
ALTER TABLE Director_rating RENAME TO director_name ;
ALTER TABLE  Director_ratings RENAME TO Director_rating  ;
ALTER TABLE director_counts RENAME TO Director_count ; 
ALTER TABLE Director_rating  DROP COLUMN director_name;
ALTER TABLE Countries_counts RENAME TO Countries_count ; 
ALTER TABLE Country RENAME COLUMN  country_n_id to  country_id;
ALTER TABLE Countries_count ADD COLUMN country_id INTEGER;
UPDATE  Countries_count
SET country_id = (
    SELECT country_id
    FROM Country
    WHERE trim(country_name) = trim(Countries_count.country_name)
);
ALTER TABLE Countries_count DROP COLUMN country_name;
ALTER TABLE country_rating RENAME TO Countries_rating ;
ALTER TABLE Countries_rating ADD COLUMN country_id INTEGER;
UPDATE  Countries_rating
SET country_id = (
    SELECT country_id
    FROM Country
    WHERE trim(country_name) = trim(Countries_rating.country_name)
);
ALTER TABLE Countries_rating DROP COLUMN country_name; 
ALTER TABLE language_rating2 RENAME to Language_rating ;
ROLLBACK;
PRAGMA table_info(User);
PRAGMA foreign_keys = ON;

UPDATE Director_rating_old_old
SET user_id = (
        SELECT user_id
        FROM User
        WHERE TRIM(User.user_name) = TRIM(Director_rating_old_old.user_name)
);

ALTER TABLE Director_rating_old_old RENAME TO Director_rating_new;
							CREATE TABLE Director_rating_new (
							director_id INTEGER,
							user_id INTEGER,
							rating INTEGER,
							user_name TEXT,
							FOREIGN KEY (user_id) REFERENCES User(user_id),
							FOREIGN KEY (director_id) REFERENCES Director(director_id)
							);

INSERT INTO Director_rating_new ( director_id, user_id, rating,user_name)
							SELECT  director_id, user_id, rating,user_name
							FROM Director_rating_old_old;
                        

DROP TABLE Director_rating_old_old;
ALTER TABLE Director_rating_new RENAME TO Director_rating;
ALTER TABLE Director_rating DROP COLUMN user_name;
ALTER TABLE Director_count ADD COLUMN user_id INTEGER;
DROP TABLE Director_count_old
ROLLBACK;
BEGIN;
ALTER TABLE Cast_count ADD COLUMN cast_id INTEGER;

UPDATE Cast_count
SET cast_id = (
    SELECT cast_id
    FROM Cast
    WHERE trim(cast_name) = trim(Cast_count.cast_name)
);

ALTER TABLE Cast_count DROP COLUMN cast_name;
COMMIT;
ALTER TABLE Cast_count INSERT COLUMN cast_name;
ROLLBACK;

DROP TABLE Cast_rating_old;
DROP TABLE Cast_count_old;
DROP TABLE User_old;

ALTER TABLE decade_rating DROP COLUMN user_name