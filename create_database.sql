/**
 * Database created by CaptainCluster (Ville Saloranta)
 * License: GNU GPL v3.0
 */


--CREATION OF THE TABLES
CREATE TABLE Artist(
    artistID int UNIQUE NOT NULL,
    [name] varchar(30) UNIQUE NOT NULL,
    foundedYear int,
    totalAlbums int NOT NULL DEFAULT 0,
    totalMembers int NOT NULL CHECK (totalMembers > 0),

    PRIMARY KEY(ArtistID)
);

CREATE TABLE Member(
    FK_artistID int,
    [name] varchar(30) NOT NULL,
    instrument varchar(30) NOT NULL,

    FOREIGN KEY(FK_artistID) REFERENCES Artist(artistID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Album(
    albumID int NOT NULL UNIQUE,
    FK_artistID int,
    title varchar(50) NOT NULL,
    releaseYear int NOT NULL,

    PRIMARY KEY(albumID),
    FOREIGN KEY(FK_artistID) REFERENCES Artist(artistID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Song(
    songID int NOT NULL UNIQUE,
    FK_albumID int,
    title varchar(50) NOT NULL,
    songNumber int NOT NULL DEFAULT 0,
    lengthSeconds int NOT NULL,

    PRIMARY KEY(songID),
    FOREIGN KEY(FK_albumID) REFERENCES Album(albumID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE DefinedBy(
    FK_artistID int,
    FK_genreID int,

    FOREIGN KEY(FK_artistID) REFERENCES Artist(artistID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY(FK_genreID) REFERENCES Genre(genreID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Genre(
    genreID int NOT NULL UNIQUE,
    [name] varchar(30) NOT NULL,

    PRIMARY KEY(genreID)
);

CREATE TABLE Activity(
    activityID int UNIQUE NOT NULL,
    FK_artistID int,
    followers int NOT NULL,
    monthlyListens int NOT NULL,
    
    PRIMARY KEY(activityID),
    FOREIGN KEY(FK_artistID) REFERENCES Artist(artistID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

--DATA INSERTION

INSERT INTO Artist
    --artistID, [name], foundedYear, totalAlbums, totalMembers
    VALUES
        (10001, "Megadeth", 1983, 5, 4),
        (10002, "Metallica", 1981, 3, 4),
        (10003, "Pantera", 1981, 2, 2),
        (10004, "Judas Priest", 1969,2, 2),
        (10005, "Iron Maiden", 1975, 1, 2)
;

INSERT INTO Member
    --FK_artistID, [name], instrument
    VALUES
        (10001, "Dave Mustaine", "Vocals & Guitar"),
        (10001, "David Ellefson", "Bass"),
        (10001, "Nick Menza", "Drums"),
        (10001, "Chris Poland", "Guitar"),

        (10002, "James Hetfield", "Vocals & Guitar"),
        (10002, "Lars Ulrich", "Drums"),
        (10002, "Cliff Burton", "Bass"),
        (10002, "Kirk Hammett", "Guitar"),

        (10003, "Phil Anselmo", "Vocals"),
        (10003, "Dimebag Darrell", "Guitar"),
        (10003, "Vinnie Paul", "Drums"),

        (10004, "Rob Halford", "Vocals"),
        (10004, "Glenn Tipton", "Guitar"),

        (10005, "Bruce Dickinson", "Vocals"),
        (10005, "Clive Burr", "Drums")
;

INSERT INTO Album
    --albumID, FK_artistID, title, releaseYear
    VALUES
        (20001, 10001, "Rust in Peace", 1990),
        (20008, 10001, "Peace Sells... But Who's Buying?", 1986),
        (20009, 10001, "Countdown to Extinction", 1992),
        (20010, 10001, "Youthanasia", 1994),
        (20016, 10001, "Killing is My Business... And Business is Good!", 1985),

        (20002, 10002, "Ride the Lightning", 1984),
        (20006, 10002, "Master of Puppets", 1986),
        (20007, 10002, "Death Magnetic", 2008),

        (20003, 10003, "Cowboys From Hell", 1990),
        (20013, 10003, "Vulgar Display of Power", 1992),

        (20004, 10004, "Screaming for Vengeance", 1982),
        (20015, 10004, "Painkiller", 1990),

        (20005, 10005, "Powerslave", 1984)
;

INSERT INTO Song 
    --The song "lengths" (in seconds) have been randomly determined with random key presses
    --Some of the albums only have a portion of their songs here, emphasizing them being filler, with priority given to the actual project assignment

    --songID, FK_albumID, title, songNumber, lengthSeconds
    VALUES
        (30001, 20001, "Holy Wars... The Punishment Due", 1, 300),
        (30002, 20001, "Hangar 18", 2, 311),
        (30003, 20001, "Take No Prisoners", 3, 432),
        (30004, 20001, "Five Magics", 4, 326),
        (30005, 20001, "Poison Was the Cure", 5, 432),
        (30006, 20001, "Lucretia", 6, 343),
        (30007, 20001, "Tornado of Souls", 7, 32),
        (30008, 20001, "Dawn Patrol", 8, 532),
        (30009, 20001, "Rust in Peace... Polaris", 9, 542),

        (30010, 20010, "Reckoning Day", 1, 432),
        (30011, 20010, "Train of Consequences", 2, 432),
        (30012, 20010, "Addicted to Chaos", 3, 431),
        (30053, 20010, "A Tout le Monde", 4, 234),
        (30013, 20010, "Elysian Fields", 5, 234),
        (30054, 20010, "The Killing Road", 6, 253),
        (30055, 20010, "The Blood of Heroes", 7, 345),
        (30056, 20010, "Family Tree", 8, 362),
        (30057, 20010, "Youthanasia", 9, 264),
        (30058, 20010, "I Thought I knew It All", 10, 235),
        (30059, 20010, "Black Curtains", 11, 643),
        (30060, 20010, "Victory", 12, 364),

        (30014, 20009, "Skin O' My Teeth", 1, 254),
        (30015, 20009, "Symphony of Destruction", 2, 431),
        (30016, 20009, "Sweating Bullets", 5, 124),
        (30017, 20009, "Countdown to Extinction", 7, 431),

        (30018, 20008, "Wake Up Dead", 1, 234),
        (30019, 20008, "The Conjuring", 2, 251),
        (30020, 20008, "Devil's Island", 4, 742),
        (30021, 20008, "Peace Sells", 3, 232),

        (30065, 20016, "Killing is My Business... And Business is Good!", 2, 252),
        (30066, 20016, "Mechanix", 8, 361),

        (30061, 20002, "Fight Fire with Fire", 1, 431),
        (30022, 20002, "Ride the Lightning", 2, 398),
        (30062, 20002, "For Whom the Bell Tolls", 3, 245),
        (30063, 20002, "Fade to Black", 4, 264),

        (30031, 20006, "Battery", 1, 345),
        (30032, 20006, "Master of Puppets", 2, 352),
        (30033, 20006, "Leper Messiah", 6, 234),

        (30034, 20007, "All Nightmare Long", 5, 234),
        (30035, 20007, "Cyanide", 6, 425),
        (30036, 20007, "My Apocalypse", 10, 341),
        
        (30023, 20003, "Cemetery Gates", 5, 423),
        (30037, 20003, "Domination", 6, 245),
        (30026, 20003, "Cowboys From Hell", 1, 231),

        (30038, 20013, "Walk", 3, 232),
        (30039, 20013, "This Love", 5, 214),

        (30064, 20004, "The Hellion", 1, 53),
        (30024, 20004, "Electric Eye", 2, 233),
        (30067, 20004, "Riding on the Wind", 3, 632),
        (30069, 20004, "Bloodstone", 4, 368),
        (30068, 20004, "(Take These) Chains", 5, 731),
        (30070, 20004, "Pain and Pleasure", 6, 643),
        (30071, 20004, "Screaming for Vengeance", 7, 3567),
        (30072, 20004, "You've Got Another Thing Comin'", 8, 345),


        (30025, 20005, "Aces High", 1, 270),
        (30027, 20005, "2 Minutes to Midnight", 2, 245),
        (30048, 20005, "Losfer Words (Big 'Orra)", 3, 245),
        (30051, 20005, "Flash of the Blade", 4, 234),
        (30049, 20005, "The Duellists", 5, 232),
        (30050, 20005, "Back in the Village", 6, 234),
        (30028, 20005, "Powerslave", 7, 643),
        (30052, 20005, "Rime of the Ancient Mariner", 8, 932),

        (30029, 20015, "Painkiller", 1, 432),
        (30040, 20015, "Hell Patrol", 2, 353),
        (30041, 20015, "All Guns Blazing", 3, 243),
        (30042, 20015, "Leather Rebel", 4, 453),
        (30043, 20015, "Metal Meltdown", 5, 353),
        (30044, 20015, "Night Crawler", 6, 254),
        (30045, 20015, "Between the Hammer & the Anvil", 7, 345),
        (30030, 20015, "A Touch of Evil", 8, 341),
        (30046, 20015, "Battle Hymn", 9, 355),
        (30047, 20015, "One Shot at Glory", 10, 244)
;

INSERT INTO DefinedBy
    --FK_artistID, FK_genreID
    VALUES
        (10001, 40001),
        (10001, 40003),

        (10002, 40001),
        (10002, 40003),

        (10003, 40001),
        (10003, 40004),
        (10003, 40005),

        (10004, 40001),
        (10004, 40002),
        (10004, 40008),

        (10005, 40001),
        (10005, 40008)
;

INSERT INTO Genre
    --genreID, name
    VALUES
        (40001, "Heavy Metal"),
        (40002, "Hard Rock"),
        (40003, "Thrash Metal"),
        (40004, "Groove Metal"),
        (40005, "Glam Metal"),
        (40006, "Shock Rock"),
        (40007, "Death Metal"),
        (40008, "NWOBHM")
;

INSERT INTO Activity
    --activityID, FK_artistID, followers, monthlyListeners
    VALUES
        (50001, 10001, 5000000, 8500000),
        (50002, 10002, 14000000, 10000000),
        (50003, 10003, 4000000, 6000000),
        (50004, 10004, 4500000, 9500000),
        (50005, 10005, 8000000, 7500000)
;

--Indices
CREATE INDEX album_name ON Album(title);
CREATE INDEX member_instrument ON Member(instrument);