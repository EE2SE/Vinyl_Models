alter table prod.currency
alter column create_dt set not null;

alter table prod.price
alter column create_dt set not null;

alter table prod.track
alter column create_dt set not null;
