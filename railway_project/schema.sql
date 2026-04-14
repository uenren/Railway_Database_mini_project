-- ============================================================
--  RAILWAY SYSTEM DATABASE SCHEMA
-- ============================================================

CREATE TABLE IF NOT EXISTS zones (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    code TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    headquarters TEXT,
    abbreviation TEXT
);

CREATE TABLE IF NOT EXISTS stations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    code TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    state TEXT,
    zone_id INTEGER REFERENCES zones(id),
    category TEXT DEFAULT 'NSG-3'
);

CREATE TABLE IF NOT EXISTS trains (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    train_no INTEGER UNIQUE NOT NULL,
    name TEXT NOT NULL,
    zone_id INTEGER REFERENCES zones(id),
    train_type TEXT,
    total_coaches INTEGER DEFAULT 24,
    origin_code TEXT,
    destination_code TEXT
);

CREATE TABLE IF NOT EXISTS tracks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    station_from_id INTEGER REFERENCES stations(id),
    station_to_id INTEGER REFERENCES stations(id),
    distance_km REAL,
    line_type TEXT,
    electrified INTEGER DEFAULT 1,
    UNIQUE(station_from_id, station_to_id)
);

CREATE TABLE IF NOT EXISTS schedule (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    train_id INTEGER REFERENCES trains(id),
    station_id INTEGER REFERENCES stations(id),
    sequence_no INTEGER,
    arrival_time TEXT,
    departure_time TEXT,
    day_no INTEGER DEFAULT 1,
    halt_minutes INTEGER DEFAULT 0
);

CREATE TABLE IF NOT EXISTS bookings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    pnr TEXT UNIQUE NOT NULL,
    train_id INTEGER REFERENCES trains(id),
    journey_date TEXT NOT NULL,
    from_station_id INTEGER REFERENCES stations(id),
    to_station_id INTEGER REFERENCES stations(id),
    coach TEXT,
    seat_no INTEGER,
    passenger_name TEXT NOT NULL,
    booked_at TEXT DEFAULT CURRENT_TIMESTAMP
);