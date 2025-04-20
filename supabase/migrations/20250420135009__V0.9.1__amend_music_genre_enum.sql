CREATE TYPE prod.music_genre_cap AS ENUM (
    'ROCK',
    'POP',
    'JAZZ',
    'HIP_HOP',
    'ELECTRONIC',
    'CLASSICAL',
    'BLUES',
    'REGGAE',
    'COUNTRY',
    'METAL',
    'FOLK',
    'PUNK',
    'SOUL',
    'FUNK',
    'RNB',
    'TECHNO',
    'HOUSE',
    'INDIE',
    'ALTERNATIVE',
    'UNSPECIFIED'
);

-- 2. Alter any table that uses prod.music_genre (example shown for prod.record)
--    You need to update genre column and convert values accordingly

ALTER TABLE prod.record
ALTER COLUMN genre TYPE prod.music_genre_cap
USING UPPER(genre::text)::prod.music_genre_cap;

-- 3. Drop the old enum
DROP TYPE prod.music_genre;

-- 4. (Optional) Rename the new enum to the original name
ALTER TYPE prod.music_genre_cap RENAME TO music_genre;
