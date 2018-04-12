/* Select all columns and rows from the movies table*/
SELECT * FROM movies;

-- Select only the title and id of the first 10 rows
SELECT title id FROM movies LIMIT 10;

-- Find the movie with the id of 485
SELECT title FROM movies WHERE id = 485;

-- Find the id (only that column) of the movie Made in America (1993)
SELECT id FROM movies WHERE title LIKE '%made in america%';

-- Find the first 10 sorted alphabetically
SELECT * FROM movies ORDER BY title ASC LIMIT 10;

-- Find all movies from 2002
SELECT * FROM movies WHERE title LIKE '%2002%';

-- Find out what year the Godfather came out
SELECT SUBSTRING(title, -5, 4) FROM movies WHERE title LIKE '%godfather, the%';

-- Without using joins find all the comedies
SELECT * FROM movies WHERE genres LIKE 'comedy';

-- Find all comedies in the year 2000
SELECT * FROM movies WHERE genres LIKE 'comedy' AND title LIKE '%2002%';

-- Find any movies that are about death and are a comedy
SELECT * FROM movies WHERE genres LIKE 'comedy' AND title LIKE '%death%';

-- Find any movies from either 2001 or 2002 with a title containing super
SELECT * FROM movies WHERE ((SUBSTRING(title, -5, 4) = 2001) OR (SUBSTRING(title, -5, 4) = 2002)) AND title LIKE '%super%';

-- Create a new table called actors (We are going to pretend the actor can only play in one movie). The table should include name, character name, foreign key to movies and date of birth at least plus an id field.
CREATE TABLE actors (
    id int,
    name varchar(255),
    char_name varchar(255),
    date_of_birth varchar(15),
    movie_id int
);
-- Pick 3 movies and create insert statements for 10 actors each. You should use the multi value insert statements
INSERT INTO actors (name, char_name, date_of_birth, movie_id) 
VALUES	("k", "dog", "2/21/2021", "1"),
		("K", "K-DOG", "5/4/3027", "1"),
		("K-dog", "Batman", "2/12/5483", "1"),
		("k-DOG", "Also Batman", "2/12/1234", "1"),
		("k-dog", "Batman 2", "8/37/3746", "1"),
		("Kev D", "BATman", "3/54/1234", "1"),
		("K-d", "William Thurston Howwel III", "9/9/9846", "1"),
		("Kevin0", "Thor", "4/32/7645", "3"),
		("Kevin1", "Thor", "9/99/9999", "3"),
		("Kevin2", "Thor", "4/34/3467", "3"),
		("Kevin3", "Thor", "3/32/4323", "3"),
		("Kevin4", "Thor", "0/09/0947", "3"),
		("Kevin5", "Henry VIII", "3/34/5423", "3"),
		("Kevin6", "Reginald Beauregaard Cantilever Esquire", "1/12/1212", "20"),
		("Kevin7", "Sweet SweetBack", "0/00/0001", "20"),
		("Kevin8", "Captain Jean Luc Picard", "2/23/4164", "20"),
		("Kevin9", "Rodney Dangerfield", "3/33/3321", "20"),
		("Kevin10", "Godzilla", "1/2/5235", "20");
		
-- Create a new column in the movie table to hold the MPAA rating. UPDATE 5 different movies to their correct rating 
UPDATE movies SET MPAA_rating = "G" WHERE id = 2;

-- Find all the ratings for the movie Godfather, show just the title and the rating
SELECT 
 movies.title,
 ratings.rating
FROM
 movies
LEFT JOIN ratings on movies.id = ratings.movie_id
WHERE movies.title LIKE "%Godfather, The%";
 
-- Order the previous objective by newest to oldest
SELECT
 movies.title,
 ratings.rating,
 ratings.timestamp
FROM
 movies
LEFT JOIN ratings ON movies.id = ratings.movie_id
WHERE movies.title LIKE "%Godfather, The%"
ORDER BY ratings.timestamp DESC;
 
-- Find the comedies from 2005 and get the title and imdbid from the links table
SELECT
 movies.genres,
 movies.title,
 links.imdb_id
FROM
 movies
INNER JOIN links ON movies.id = links.movie_id
WHERE movies.genres LIKE "%Comedy%" AND SUBSTRING(movies.title, -5, 4) = "2005";

-- Find all movies that have no ratings
SELECT
 movies.title,
 ratings.rating
FROM 
 movies
LEFT JOIN ratings ON movies.id = ratings.movie_id
WHERE ratings.rating IS NULL;

-- Get the average rating for a movie
SELECT 
  movies.title,
  AVG(ratings.rating) as averageRating
FROM
 movies
LEFT JOIN ratings on movies.id = ratings.movie_id
WHERE movies.title LIKE "%Godfather, The%"
GROUP BY movies.title;


-- Get the total ratings for a movie
SELECT 
 movies.title,
 COUNT(ratings.rating) AS ratingCount
FROM
 movies
LEFT JOIN ratings ON movies.id = ratings.movie_id
WHERE movies.title LIKE "%Godfather, The%"
GROUP BY movies.title;
 
-- Get the total movies for a genre
SELECT
 genres,
 COUNT(genres) AS genreCount
FROM
 movies
WHERE genres LIKE "drama"
GROUP BY genres;
 
-- Get the average rating for a user
SELECT
 ratings.user_id,
 AVG(ratings.rating) AS ratingsAvg
FROM 
 ratings
WHERE ratings.user_id = 30
GROUP BY ratings.user_id;

-- Find the user with the most ratings
SELECT
 ratings.user_id,
 COUNT(ratings.rating) AS ratingCount
FROM
 ratings
GROUP BY ratings.user_id 
ORDER BY COUNT(ratings.rating) DESC limit 1;

-- Find the user with the highest average rating
SELECT
 ratings.user_id,
 AVG(ratings.rating) as avgRating
FROM
 ratings
GROUP BY ratings.user_id
ORDER BY AVG(ratings.rating) DESC LIMIT 1;

-- Find the user with the highest average rating with more than 50 reviews
SELECT
 ratings.user_id,
 AVG(ratings.rating) as avgRating,
 COUNT(ratings.rating) as ratingsCount
FROM
 ratings
GROUP BY ratings.user_id
HAVING COUNT(ratings.rating) > 50
ORDER BY AVG(ratings.rating) DESC LIMIT 1;

-- Find the movies with an average rating over 4
SELECT
 movies.title,
 AVG(ratings.rating) AS ratingAvg
FROM
 movies
LEFT JOIN ratings ON movies.id = ratings.movie_id
GROUP BY movies.title
HAVING AVG(ratings.rating) > 4;