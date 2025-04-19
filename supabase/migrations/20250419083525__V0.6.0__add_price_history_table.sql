create table if not exists prod.price_history (
    id serial,
    record_id int not null,
    price_id int not null,
    price_dt timestamp not null,
    source text not null,
    create_dt timestamp not null default now(),

    constraint pk__price_history primary key (id),
    constraint fk__price_history__record_id foreign key (
        record_id
    ) references prod.record (id),
    constraint fk__price_history__price_id foreign key (
        price_id
    ) references prod.price (id)
);
