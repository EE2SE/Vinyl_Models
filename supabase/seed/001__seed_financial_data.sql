insert into prod.currency (
    symbol, name
) values
('USD', 'US Dollar'),
('EUR', 'Euro');

insert into prod.currency_exchange (
    from_curr_id, to_curr_id, exchange_rate, update_dt
) values
(1, 2, 0.91, now()),
(2, 1, 1.10, now());

insert into prod.price (
    amount, currency_id
) values
(20.00, 1), -- $20.00
(18.00, 2); -- €18.00

insert into prod.record (
    artist, album, genre, buy_year,
    buy_month, buy_price_id
) values
('Radiohead', 'OK Computer', 'ROCK'::prod.music_genre, 2020, 6, 1),
('Daft Punk', 'Discovery', 'ELECTRONIC'::prod.music_genre, 2023, 3, 2);

insert into prod.track (
    record_id, number, name, spotify_uri
) values
(1, 1, 'Airbag', 'spotify:track:1'),
(1, 2, 'Paranoid Android', 'spotify:track:2'),
(2, 1, 'One More Time', 'spotify:track:3');

insert into prod.availibility (
    record_id, amount, update_dt
) values
(1, 5, now()),
(2, 3, now());

insert into prod.price_history (
    record_id, price_id, price_dt, source
) values
(1, 1, '2024-01-01', 'Discogs'),
(1, 2, '2025-01-01', 'Ebay'),
(2, 2, '2024-06-01', 'Discogs');
