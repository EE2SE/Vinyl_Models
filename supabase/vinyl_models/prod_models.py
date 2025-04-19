from sqlalchemy import Column, Integer, String, TIMESTAMP, ForeignKey, Float
from sqlalchemy import Enum as PgEnum
from sqlalchemy.orm import relationship, Mapped, DeclarativeBase, mapped_column, declared_attr
import re
import enum
from typing import Optional

def camel_to_snake(name: str) -> str:
    return re.sub(r'(?<!^)(?=[A-Z])', '_', name).lower()

class MusicGenre(enum.Enum):
    ROCK = 'rock'
    POP = 'pop'
    JAZZ = 'jazz'
    HIP_HOP = 'hip_hop'
    ELECTRONIC = 'electronic'
    CLASSICAL = 'classical'
    BLUES = 'blues'
    REGGAE = 'reggae'
    COUNTRY = 'country'
    METAL = 'metal'
    FOLK = 'folk'
    PUNK = 'punk'
    SOUL = 'soul'
    FUNK = 'funk'
    RNB = 'rnb'
    TECHNO = 'techno'
    HOUSE = 'house'
    INDIE = 'indie'
    ALTERNATIVE = 'alternative'
    UNSPECIFIED = 'unspecified'

class Base(DeclarativeBase):
    @declared_attr.directive
    def __tablename__(cls) -> str:
        return camel_to_snake(cls.__name__)

    id: Mapped[int] = mapped_column(primary_key=True)

class Currency(Base):
    symbol: Mapped[str] = mapped_column(String)
    name: Mapped[str] = mapped_column(String)
    create_dt: Mapped[TIMESTAMP] = mapped_column(TIMESTAMP)

class CurrencyExchange(Base):
    from_curr_id: Mapped[int] = mapped_column(ForeignKey('currency.id'))
    to_curr_id: Mapped[int] = mapped_column(ForeignKey('currency.id'))
    exchange_rate: Mapped[float] = mapped_column(Float)
    update_dt: Mapped[Optional[TIMESTAMP]] = mapped_column(TIMESTAMP)
    create_dt: Mapped[TIMESTAMP] = mapped_column(TIMESTAMP)

    from_currency: Mapped['Currency'] = relationship('Currency', foreign_keys=[from_curr_id])
    to_currency: Mapped['Currency'] = relationship('Currency', foreign_keys=[to_curr_id])


class Price(Base):
    amount: Mapped[int] = mapped_column(Integer)
    currency_id: Mapped[int] = mapped_column(ForeignKey('currency.id'))
    create_dt: Mapped[Optional[TIMESTAMP]] = mapped_column(TIMESTAMP)

    currency: Mapped['Currency'] = relationship('Currency')

class Record(Base):
    artist: Mapped[str] = mapped_column(String, nullable=False)
    album: Mapped[str] = mapped_column(String, nullable=False)
    genre: Mapped[MusicGenre] = mapped_column(PgEnum(MusicGenre, name="music_genre", schema="prod"), nullable=False)
    buy_year: Mapped[int] = mapped_column(Integer, nullable=False)
    buy_month: Mapped[Optional[int]] = mapped_column(Integer)
    buy_price_id: Mapped[int] = mapped_column(ForeignKey('prod.buy_price.id'), nullable=False)
    discogs_id: Mapped[Optional[int]] = mapped_column(Integer)
    create_dt: Mapped[TIMESTAMP] = mapped_column(TIMESTAMP, nullable=False)

    # Relationships to be defined based on your model structure
    buy_price: Mapped['Price'] = relationship('Price')
    # discogs: Mapped['Discogs'] = relationship('Discogs')  # Uncomment when Discogs model is defined

    # Backrefs from other tables like Availability, Track, and PriceHistory
    availibility: Mapped[list['Availibility']] = relationship('Availibility', back_populates='record')
    tracks: Mapped[list['Track']] = relationship('Track', back_populates='record')
    price_history: Mapped[list['PriceHistory']] = relationship('PriceHistory', back_populates='record')

class Track(Base):
    record_id: Mapped[int] = mapped_column(ForeignKey('prod.record.id'), nullable=False)
    number: Mapped[int] = mapped_column(Integer, nullable=False)
    name: Mapped[str] = mapped_column(String, nullable=False)
    spotify_uri: Mapped[Optional[str]] = mapped_column(String, unique=True)
    create_dt: Mapped[Optional[TIMESTAMP]] = mapped_column(TIMESTAMP)

    record: Mapped['Record'] = relationship('Record', back_populates='tracks')

class Availibility(Base):
    record_id: Mapped[int] = mapped_column(ForeignKey('prod.record.id'), nullable=False)
    amount: Mapped[int] = mapped_column(Integer, nullable=False)
    update_dt: Mapped[Optional[TIMESTAMP]] = mapped_column(TIMESTAMP)
    create_dt: Mapped[TIMESTAMP] = mapped_column(TIMESTAMP, nullable=False)

    record: Mapped['Record'] = relationship('Record', back_populates='availibility')

class PriceHistory(Base):
    record_id: Mapped[int] = mapped_column(ForeignKey('prod.record.id'), nullable=False)
    price_id: Mapped[int] = mapped_column(ForeignKey('prod.price.id'), nullable=False)
    price_dt: Mapped[TIMESTAMP] = mapped_column(TIMESTAMP, nullable=False)
    source: Mapped[str] = mapped_column(String, nullable=False)
    create_dt: Mapped[TIMESTAMP] = mapped_column(TIMESTAMP, nullable=False)

    record: Mapped['Record'] = relationship('Record', back_populates='price_history')
    price: Mapped['Price'] = relationship('Price')
