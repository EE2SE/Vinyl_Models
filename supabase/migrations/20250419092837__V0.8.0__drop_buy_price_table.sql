drop table if exists prod.buy_price cascade;

alter table prod.record
add constraint fk__record__buy_price foreign key (
    buy_price_id
) references prod.price;
