CREATE OR REPLACE VIEW v_first_level_partition_info AS
SELECT
    ns.nspname AS parent_schema,
    parent.relname AS parent_table,
    child_ns.nspname AS child_schema,
    child.relname AS child_table
FROM
    pg_inherits
JOIN pg_class parent ON pg_inherits.inhparent = parent.oid
JOIN pg_class child ON pg_inherits.inhrelid = child.oid
JOIN pg_namespace ns ON ns.oid = parent.relnamespace
JOIN pg_namespace child_ns ON child_ns.oid = child.relnamespace;
