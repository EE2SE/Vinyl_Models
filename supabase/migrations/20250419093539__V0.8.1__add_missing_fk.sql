alter table prod.price_history
drop constraint if exists fk__price_history__record_id,
drop constraint if exists fk__price_history__price_id,
add constraint fk__price_history__record_id foreign key (record_id) references prod.record(id),
add constraint fk__price_history__price_id foreign key (price_id) references prod.price(id);

alter table prod.track
drop constraint if exists fk__track__record,
add constraint fk__track__record foreign key (record_id) references prod.record(id);