CREATE OR REPLACE FUNCTION count_non_volatile_days(full_nm TEXT) RETURNS INTEGER AS $$
DECLARE
    cnt INTEGER := 0;
    prev_dt VARCHAR(16):=NULL;
    highest_price NUMERIC := NULL;
    lowest_price NUMERIC := NULL;
    rec_row RECORD;
BEGIN
    IF NOT EXISTS (SELECT 1 FROM coins WHERE coins.full_nm = count_non_volatile_days.full_nm) THEN
        RAISE EXCEPTION 'Crypto currency with name "%s" is absent in database!', full_nm USING ERRCODE = '02000';
    END IF;

    FOR rec_row IN (SELECT dt, high_price, low_price FROM coins WHERE coins.full_nm = count_non_volatile_days.full_nm ORDER BY dt) LOOP
        IF prev_dt IS NULL THEN
            prev_dt := rec_row.dt;
            highest_price := rec_row.high_price;
            lowest_price := rec_row.low_price;
        ELSIF prev_dt <> rec_row.dt THEN
            IF highest_price = lowest_price THEN
                cnt := cnt + 1;
            END IF;
            prev_dt := rec_row.dt;
            highest_price := rec_row.high_price;
            lowest_price := rec_row.low_price;
        ELSE
            IF rec_row.high_price > highest_price THEN
                highest_price := rec_row.high_price;
            END IF;
            IF rec_row.low_price < lowest_price THEN
                lowest_price := rec_row.low_price;
            END IF;
        END IF;
    END LOOP;
    RETURN cnt;
END;
$$ LANGUAGE plpgsql;
