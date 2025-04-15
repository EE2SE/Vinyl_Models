CREATE SCHEMA IF NOT EXISTS prod;

GRANT USAGE ON SCHEMA prod TO jakub_admin;

GRANT CREATE ON SCHEMA prod TO jakub_admin;

ALTER ROLE prod_user SET search_path TO prod;