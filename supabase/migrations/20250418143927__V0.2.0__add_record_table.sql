create table if not exists prod.record (
    id serial,
    artist text not null,
    title text not null,
    release_year integer not null,
    purchase_date timestamp not null,
    purchase_price_id int,
    create_dt timestamp default now(),

    constraint pk__record primary key (id)
);
