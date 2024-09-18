#What are the average IMDb scores for each genre of Netflix Originals?
SELECT g.Genre, AVG(n.IMDBScore) AS Avg_Score
FROM netflix_originals n
INNER JOIN genre_details g ON n.GenreID = g.GenreID
GROUP BY  g.Genre;

#Which genres have an average IMDb score higher than 7.5?
SELECT g.Genre, AVG(n.IMDBScore) AS Higher_score
FROM netflix_originals n
INNER JOIN genre_details g ON n.GenreID = g.GenreID
GROUP BY g.Genre
HAVING Higher_score > 7.5;

#List Netflix Original titles in descending order of their IMDb scores.
SELECT Title, IMDBScore
FROM netflix_originals
ORDER BY IMDBScore DESC;

# Retrieve the top 10 longest Netflix Originals by runtime.
SELECT Title, runtime
FROM netflix_originals
order by Runtime DESC
LIMIT 10;

#Retrieve the titles of Netflix Originals along with their respective genres.
SELECT n.title, g.genre 
FROM netflix_originals n
INNER JOIN genre_details g ON n.GenreID = g.GenreID;

#Rank Netflix Originals based on their IMDb scores within each genre.
SELECT n.title, g.Genre, n.IMDBScore, RANK()
OVER (partition by g.genre ORDER BY n.IMDBScore) AS Rank_IMDB
FROM netflix_originals n
INNER JOIN genre_details g ON n.GenreID = g.GenreID;

#Which Netflix Originals have IMDb scores higher than the average IMDb score of all titles?
SELECT Title, IMDBScore
FROM netflix_originals 
WHERE IMDBScore >
(SELECT AVG(IMDBScore)
from netflix_originals);

#How many Netflix Originals are there in each genre?
SELECT g.Genre, COUNT(n.Title) AS Number_of_Titles
FROM Netflix_Originals n
JOIN Genre_Details g ON n.GenreID = g.GenreID
GROUP BY g.Genre;

#Which genres have more than 5 Netflix Originals with an IMDb score higher than 8?
SELECT g.Genre, COUNT(n.Title) AS High_Score_Titles
FROM Netflix_Originals n
JOIN Genre_Details g ON n.GenreID = g.GenreID
WHERE n.IMDBScore > 8
GROUP BY g.Genre
HAVING High_Score_Titles > 5;

#What are the top 3 genres with the highest average IMDb scores, and how many Netflix Originals do they have?
SELECT g.genre, AVG(n.IMDBScore) AS Avg_IMDB, COUNT(n.Title) AS No_of_Titles
FROM netflix_originals n
INNER JOIN genre_details g ON n.GenreID = g.GenreID
GROUP BY g.Genre
ORDER BY Avg_IMDB DESC
LIMIT 3;
