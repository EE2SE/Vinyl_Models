drop table if exists prod.record cascade;

create table if not exists prod.record (
    id serial,
    artist text not null,
    album text not null,
    genre prod.music_genre not null,
    buy_year int not null,
    buy_month int,
    buy_price_id int not null,
    discogs_id int,
    create_dt timestamp not null default now(),

    constraint pk__record primary key (id),
    constraint fk__record__buy_price foreign key (buy_price_id) references prod.buy_price
    -- constraint fk__record__discogs foreign key (discogs_id) references prod.discogs
);

-- reapply constraints
alter table prod.availibility
add constraint fk__availibility__record foreign key (record_id) references prod.record(id);

alter table prod.track
add constraint fk__track__record foreign key (record_id) references prod.record(id);

alter table prod.price_history
add constraint fk__price_history__record_id foreign key (record_id) references prod.record(id);

