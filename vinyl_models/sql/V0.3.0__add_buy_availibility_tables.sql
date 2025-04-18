create table if not exists prod.buy_price (
    id serial,
    record_id int not null,
    amount float not null,
    currency_id int not null,
    create_dt timestamp not null default now(),

    constraint pk__buy_price primary key (id),
    constraint uq__buy_price__record_id unique (record_id),
    constraint fk__buy_price__record foreign key (record_id) references prod.record(id),
    constraint fk__buy_price__currency foreign key (currency_id) references prod.currency(id),
    constraint ck__buy_price__non_neg_amount check (amount >= 0)
);

create table if not exists prod.availibility (
    id serial,
    record_id int not null,
    amount int not null,
    update_dt timestamp default null,
    create_dt timestamp not null default now(),

    constraint pk__availibility primary key (id),
    constraint uq__availibility__record_id unique (record_id),
    constraint fk__availibility__record foreign key (record_id) references prod.record(id),
);