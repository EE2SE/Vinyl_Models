-- Grant read-only access to anon
GRANT USAGE ON SCHEMA prod TO anon;
GRANT SELECT ON ALL TABLES IN SCHEMA prod TO anon;

-- Automatically grant SELECT to anon for future tables
ALTER DEFAULT PRIVILEGES IN SCHEMA prod
GRANT SELECT ON TABLES TO anon;


-- Grant full access to service_role
GRANT USAGE ON SCHEMA prod TO service_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA prod TO service_role;

-- Automatically grant full access to service_role for future tables
ALTER DEFAULT PRIVILEGES IN SCHEMA prod
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO service_role;
