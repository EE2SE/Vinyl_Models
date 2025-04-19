import pytest
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, scoped_session
from dotenv import load_dotenv
import os

load_dotenv()


@pytest.fixture(scope="session")
def db_engine():
    engine = create_engine(os.getenv("TEST_DB_URL"))
    return engine


@pytest.fixture(scope="function")
def db_session(db_engine):
    TestingSessionLocal = scoped_session(sessionmaker(bind=db_engine))
    session = TestingSessionLocal()
    try:
        yield session
    finally:
        session.rollback()
        session.close()
