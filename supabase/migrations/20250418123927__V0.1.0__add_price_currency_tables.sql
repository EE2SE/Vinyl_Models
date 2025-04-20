create table if not exists prod.currency (
    id serial,
    symbol text not null,
    name text not null,
    create_dt timestamp default now(),

    constraint pk__currency primary key (id),
    constraint uq__currency__symbol__name unique (symbol, name)
);

create table if not exists prod.price (
    id serial,
    amount int,
    currency_id integer,
    create_dt timestamp default now(),

    constraint pk__price primary key (id),
    constraint fk__price__currency foreign key (
        currency_id
    ) references prod.currency (id),
    constraint ck__price_non_neg_amount check (amount >= 0)
);
