create type prod.music_genre as enum (
    'rock',
    'pop',
    'jazz',
    'hip_hop',
    'electronic',
    'classical',
    'blues',
    'reggae',
    'country',
    'metal',
    'folk',
    'punk',
    'soul',
    'funk',
    'rnb',
    'techno',
    'house',
    'indie',
    'alternative',
    'unspecified'
);


create table if not exists prod.record (
    id serial,
    artist text not null,
    album text not null,
    genre prod.music_genre not null,
    buy_year int not null,
    buy_month int,
    buy_price_id int not null,
    discogs_id int,
    create_dt timestamp default now(),

    constraint pk__record primary key (id),
    constraint fk__record__buy_price foreign key (
        buy_price_id
    ) references prod.buy_price
    -- constraint fk__record__discogs foreign key 
    -- (discogs_id) references prod.discogs
);
