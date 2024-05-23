CREATE OR REPLACE FUNCTION serial_generator(start_val_inc INTEGER, last_val_ex INTEGER)
RETURNS TABLE (sequential_numbers INTEGER) AS $$
DECLARE
    _value INTEGER := start_val_inc;
BEGIN
    EXECUTE format('CREATE SEQUENCE serial START %s MINVALUE %s', start_val_inc, start_val_inc);

 WHILE _value < last_val_ex-1 LOOP
        _value := nextval('serial');
 sequential_numbers := _value;
        RETURN NEXT;
    END LOOP;
    EXECUTE format('DROP SEQUENCE serial');
    RETURN;
END;
$$ LANGUAGE plpgsql;
