from sqlalchemy import Column, Integer, String, TIMESTAMP, ForeignKey, Float
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

class Currency(Base):
    __tablename__ = 'currency'

    id = Column(Integer, primary_key=True)
    symbol = Column(String)
    name = Column(String)
    create_dt = Column(TIMESTAMP)

class CurrencyExchange(Base):
    __tablename__ = 'currency_exchange'

    id = Column(Integer, primary_key=True)
    from_curr_id = Column(Integer, ForeignKey('currency.id'))
    to_curr_id = Column(Integer, ForeignKey('currency.id'))
    exchange_rate = Column(Float)
    update_dt = Column(TIMESTAMP)
    create_dt = Column(TIMESTAMP)

    from_currency = relationship('Currency', foreign_keys=[from_curr_id])
    to_currency = relationship('Currency', foreign_keys=[to_curr_id])

class Price(Base):
    __tablename__ = 'price'

    id = Column(Integer, primary_key=True)
    amount = Column(Integer)
    currency_id = Column(Integer, ForeignKey('currency.id'))
    create_dt = Column(TIMESTAMP)

    currency = relationship('Currency')