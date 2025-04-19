create table if not exists prod.currency_exchange (
    id serial,
    from_curr_id int not null,
    to_curr_id int not null,
    exchange_rate float not null,
    update_dt timestamp,
    create_dt timestamp not null default now(),

    constraint pk__currency_exchange primary key (id),
    constraint fk__currency_exchange__from_curr_id foreign key (
        from_curr_id
    ) references prod.currency (id),
    constraint fk__currency_exchange__to_curr_id foreign key (
        to_curr_id
    ) references prod.currency (id),
    constraint uq__currency_exchange__to_from unique (from_curr_id, to_curr_id),
    constraint ck__currency_exchange__positive_exchange_rate check (
        exchange_rate > 0
    )
)
