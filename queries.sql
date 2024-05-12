/**
 * Queries made by CaptainCluster (Ville Saloranta)
 * License: GNU GPL v3.0
 */


--First query: List all albums of all artists in their chronological order
--(for each artist, rather than all albums)
--Plus the release year and the artists 

SELECT Artist.[name] as "Artist", Album.title as "Album Title", Album.releaseYear as "Release Year"
FROM Artist
INNER JOIN Album ON Artist.artistID=Album.FK_artistID

ORDER BY Artist.name, Album.releaseYear;

--Second query: Show all songs of all albums, their artist and their length

SELECT Song.[title] as "Song Title", Artist.[name] as "Artist", Song.lengthSeconds as "Length (seconds)"
FROM Song, Artist, Album

WHERE 
    Artist.artistID = Album.FK_artistID
AND
    Album.albumID = Song.FK_albumID

GROUP BY Song.title
ORDER BY Song.title;

--Third query: All band members by genre 
SELECT Member.[name] as "Member", Artist.name as "Artist", 
GROUP_CONCAT(
        Genre.name
    ) as "Genres"
FROM Member, Artist, Genre, DefinedBy

WHERE 
    Artist.artistID = Member.FK_artistID
AND
    Artist.artistID = DefinedBy.FK_artistID
AND
    DefinedBy.FK_genreID=Genre.genreID

--This if-condition is commented off, but it could demonstrate
--what a search for specific genre would show
--
--AND Genre.genreID = 40003
--

GROUP BY Member.name
ORDER BY Artist.name, Genre.name
;

--Fourth query: List all artists by the amount of followers
SELECT Activity.followers as "Followers", Artist.name as "Artist"
FROM Activity

INNER JOIN Artist ON Artist.artistID=Activity.FK_artistID

ORDER BY Activity.followers DESC;

--Fifth query: List all artists and releases, their songs and all their genres
--Differs from 2nd query by being less song-centric and focusing more on giving
--an overall picture.

SELECT 
    Song.title as "Song Title", 
    Album.title as "Album Title", 
    Artist.name as "Artist", 
    
    GROUP_CONCAT(
        Genre.name
    ) as "Genres"

FROM Song

INNER JOIN Album
ON Song.FK_albumID=Album.albumID

INNER JOIN Artist
ON Album.FK_artistID=Artist.artistID

INNER JOIN DefinedBy
ON DefinedBy.FK_artistID=Artist.artistID

INNER JOIN Genre
ON DefinedBy.FK_genreID=Genre.genreID

GROUP BY Song.title
ORDER BY Artist.name, Album.title, Song.songNumber
;

