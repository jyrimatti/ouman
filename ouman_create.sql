create table outsideTemp        (instant INTEGER PRIMARY KEY, measurement INTEGER NOT NULL);
create table supplyTemperature  (instant INTEGER PRIMARY KEY, measurement INTEGER NOT NULL);
create table indoorTemperature  (instant INTEGER PRIMARY KEY, measurement INTEGER NOT NULL);
create table co2                (instant INTEGER PRIMARY KEY, measurement INTEGER NOT NULL);
create table ah                 (instant INTEGER PRIMARY KEY, measurement REAL NOT NULL);
create table supplyFan          (instant INTEGER PRIMARY KEY, measurement REAL NOT NULL);
create table exhaustFan         (instant INTEGER PRIMARY KEY, measurement REAL NOT NULL);
