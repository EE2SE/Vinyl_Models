import vinyl_models.prod_models as vmd


def test_fetch_record(db_session):
    # Query a Record from the database
    record = db_session.query(vmd.Record).where(vmd.Record.id == 1).first()
    assert record is not None, "No Record found in the database"

    # Validate some fields of the Record model
    assert isinstance(record.artist, str) and record.artist == "Radiohead"
    assert isinstance(record.album, str) and record.album == "OK Computer"
    assert record.genre in vmd.MusicGenre
    assert isinstance(record.buy_year, int) and record.buy_year == 2020

    # Validate relationship to buy_price
    assert isinstance(record.buy_price.amount, int) and record.buy_price.amount == 20.00

    # Optionally validate related tracks if any
    assert len(record.tracks) == 2
    assert record.tracks[0].name == "Airbag"
