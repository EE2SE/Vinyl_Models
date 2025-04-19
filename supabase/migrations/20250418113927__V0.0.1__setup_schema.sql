-- create the schema outside the DO block
create schema if not exists prod;

do
$$
begin
   if exists (
      select from pg_catalog.pg_roles
      where rolname = 'jakub_admin'
   ) then
      raise notice 'role "jakub_admin" already exists. skipping.';
   else
      create role jakub_admin login password 'password';
   end if;

   grant all on schema prod to jakub_admin;
end
$$;
