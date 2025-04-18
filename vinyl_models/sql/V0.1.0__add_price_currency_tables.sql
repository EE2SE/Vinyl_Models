create table if not exists prod.currency (
    id serial,
    symbol text not null,
    name text not null,
    create_dt timestamp default now(),

    constraint pk__currency primary key (id),
    constraint uq__currency__symbol__name unique (symbol, name),
);