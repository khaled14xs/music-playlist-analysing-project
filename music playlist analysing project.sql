/* 
What are the three most preferred genres?
*/

SELECT

  music_type,

  SUM(avg_total_sales) AS sum_avg_total_sales_by_genre,

  CASE

    WHEN SUM(avg_total_sales) >= 20 THEN 'Top'

    WHEN SUM(avg_total_sales) > 10 AND

      SUM(avg_total_sales) <= 20 THEN 'Medium'

    ELSE 'Low'

  END AS level_sales

FROM (SELECT DISTINCT

  Artist.Name AS artist_name,

  Genre.Name AS music_type,

  COUNT(Album.AlbumId) AS total_album,

  AVG(InvoiceLine.UnitPrice * InvoiceLine.Quantity) AS avg_total_sales

FROM Artist

JOIN Album

  ON Artist.ArtistId = Album.ArtistId

JOIN Track

  ON Album.AlbumId = Track.AlbumId

JOIN Genre

  ON Track.GenreId = Genre.GenreId

JOIN InvoiceLine

  ON Track.TrackId = InvoiceLine.TrackId

JOIN Invoice

  ON InvoiceLine.InvoiceId = Invoice.InvoiceId

GROUP BY Artist.Name) sub

GROUP BY music_type

ORDER BY sum_avg_total_sales_by_genre DESC


/*
Which country was the best buyer in 2009? 
*/

SELECT

  Customer.Country,

  SUM(InvoiceLine.UnitPrice * InvoiceLine.Quantity) AS Total_sales

FROM Artist

JOIN Album

  ON Artist.ArtistId = Album.ArtistId

JOIN Track

  ON Album.AlbumId = Track.AlbumId

JOIN Genre

  ON Track.GenreId = Genre.GenreId

JOIN InvoiceLine

  ON Track.TrackId = InvoiceLine.TrackId

JOIN Invoice

  ON InvoiceLine.InvoiceId = Invoice.InvoiceId

JOIN Customer

  ON Invoice.CustomerId = Customer.CustomerId

WHERE Invoice.InvoiceDate BETWEEN '2009-01-01' AND '2009-12-26'

GROUP BY 1

ORDER BY 2 DESC

 /* 
 Which was the most popular album ever sold on the playlist?
 */

 SELECT Genre.Name AS Music_Genre, 
Artist.Name AS Artist_Name, 
Album.Title AS Album_Title, 
SUM (InvoiceLine.InvoiceId) AS Total_Buy

FROM Artist

JOIN Album

  ON Artist.ArtistId = Album.ArtistId

JOIN Track

  ON Album.AlbumId = Track.AlbumId

JOIN Genre

  ON Track.GenreId = Genre.GenreId

JOIN InvoiceLine

  ON Track.TrackId = InvoiceLine.TrackId

JOIN Invoice

  ON InvoiceLine.InvoiceId = Invoice.InvoiceId

JOIN Customer

   ON Invoice.CustomerId = Customer.CustomerId

 GROUP BY Music_Genre, Artist_Name, Album_Title

 ORDER BY Total_Buy DESC
 LIMIT 15

/*
Who was the employee with the most buys and their favorite genre? 
*/ 
SELECT DISTINCT

  Employee.FirstName,

  Employee.LastName,

  Genre.Name AS Music_Type,

  SUM(InvoiceLine.UnitPrice * InvoiceLine.Quantity) AS Total_buy

FROM Artist

JOIN Album

  ON Artist.ArtistId = Album.ArtistId

JOIN Track

  ON Album.AlbumId = Track.AlbumId

JOIN Genre

  ON Track.GenreId = Genre.GenreId

JOIN InvoiceLine

  ON Track.TrackId = InvoiceLine.TrackId

JOIN Invoice

  ON InvoiceLine.InvoiceId = Invoice.InvoiceId

JOIN Customer

  ON Invoice.CustomerId = Customer.CustomerId

JOIN Employee

  ON Customer.SupportRepId = EmployeeId

GROUP BY 1,

         2,

         3

ORDER BY 4 DESC



