ALTER TABLE Language_rating DROP COLUMN cast_id;
ALTER TABLE Cast_rating ADD COLUMN cast_id INTEGER;
UPDATE Cast_rating
SET cast_id = (
    SELECT cast_id
    FROM Cast
    WHERE cast_name = Cast_rating.cast_name
);

ALTER TABLE Cast_rating DROP COLUMN cast_name;
ALTER TABLE lan