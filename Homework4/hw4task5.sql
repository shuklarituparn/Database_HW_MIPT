CREATE OR REPLACE VIEW v_used_size_per_user AS
WITH table_sizes AS (
    SELECT
        pg_tables.schemaname AS schema_name,
        pg_tables.tablename AS table_name,
        pg_tables.tableowner AS table_owner,
        pg_relation_size(quote_ident(pg_tables.schemaname) || '.' || quote_ident(pg_tables.tablename)) AS table_size_bytes
    FROM
        pg_tables
),
schema_user_sizes AS (
    SELECT
        schema_name,
        table_owner,
        pg_size_pretty(SUM(table_size_bytes)) AS used_per_schema_user_total_size
    FROM
        table_sizes
    GROUP BY
        schema_name, table_owner
),
user_total_sizes AS (
    SELECT
        table_owner,
        pg_size_pretty(SUM(table_size_bytes)) AS used_user_total_size
    FROM
        table_sizes
    GROUP BY
        table_owner
)
SELECT
    ts.table_owner,
    ts.schema_name,
    ts.table_name,
    pg_size_pretty(ts.table_size_bytes) AS table_size,
    sus.used_per_schema_user_total_size,
    uts.used_user_total_size
FROM
    table_sizes ts
JOIN
    schema_user_sizes sus ON ts.schema_name = sus.schema_name AND ts.table_owner = sus.table_owner
JOIN
    user_total_sizes uts ON ts.table_owner = uts.table_owner
ORDER BY
    ts.table_owner,
    ts.schema_name,
    ts.table_name;
