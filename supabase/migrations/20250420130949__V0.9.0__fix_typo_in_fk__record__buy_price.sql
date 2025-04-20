-- Drop the check constraint for 'amount'
alter table prod.record
drop constraint if exists fk__record__buy_price;

alter table prod.record
add constraint fk__record__buy_price foreign key (
    buy_price_id
) references prod.price (id);
