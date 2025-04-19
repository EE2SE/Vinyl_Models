create table if not exists prod.track (
    id serial,
    record_id int not null,
    number int not null,
    name text not null,
    spotify_uri text,
    create_dt timestamp default now(),

    constraint pk__track primary key (id),
    constraint fk__track__record foreign key (record_id) references prod.record(id),
    constraint uq__track__spotify_uri unique (spotify_uri),
    constraint uq__track__number_on_album unique (number, record_id)
);