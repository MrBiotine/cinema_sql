--SQL QUERIES CINEMA EXERCISE--

--a. Film information (id_film): title, release year, duration (in HH:MM format) and director

SELECT m.id_movie, m.title, DATE_FORMAT(m.release_date,'%Y') AS "Année de sortie", SEC_TO_TIME(m.duration*60) AS "Durée en h,min,s", s.lastname AS "nom du réalisateur"    
FROM movie m                                                                                                                               
INNER JOIN director d                                                                                                                      
ON d.id_director = m.director_id                                                                                                           
INNER JOIN staff s                                                                                                                          
ON s.id_staff = d.staff_id /*LIMIT => Limit line display to required number*/

--b. List of films whose duration exceeds 2h15, sorted by length (from longest to shortest)

SELECT m.title, SEC_TO_TIME(m.duration*60) Durée
FROM movie m                                                
WHERE m.duration > 135
ORDER BY m.duration DESC                                                                                      

--c. List of films by director (specifying year of release) 

SELECT m.title, DATE_FORMAT(m.release_date,'%Y') parution, s.firstname, s.lastname
FROM movie m
INNER JOIN director d
ON m.director_id = d.id_director
INNER JOIN staff s
ON d.id_director = s.id_staff
AND d.id_director= 1

--d. Number of films by genre (in descending order)

SELECT g.label, COUNT(c.movie_id) Film_number
FROM genre g                                                 
INNER JOIN movie_genre_link c
ON g.id_genre = c.genre_id
GROUP BY g.label                                                                                 
ORDER BY Film_number DESC                                                                                                   

--e. Number of films by director (in descending order)

SELECT s.firstname,s.lastname,  COUNT(m.id_movie) Film_number
FROM director d
INNER JOIN movie m
ON m.director_id = d.id_director
INNER JOIN staff s
ON d.staff_id = s.id_staff
GROUP BY d.id_director
ORDER BY Film_number DESC

--f. Film casting by id (id_film): first and last names of actors + gender

SELECT c.movie_id, s.firstname, s.lastname, s.gender
FROM casting c
INNER JOIN actor a
ON a.id_actor = c.actor_id
INNER JOIN staff s
ON s.id_staff = a.staff_id
AND c.movie_id = 1

--g. Films shot by a particular actor (id_acteur) with their role and year of release (from most recent to oldest film)

SELECT c.actor_id, r.name, m.title, m.release_date parution
FROM casting c
INNER JOIN role r
ON r.id_role = c.role_id
INNER JOIN movie m
ON m.id_movie = c.movie_id
AND c.actor_id = 2
ORDER BY parution DESC

--h. Staff members who are both actors and directors

SELECT s.firstname, s.lastname
FROM staff s
INNER JOIN actor a
ON a.staff_id = s.id_staff
INNER JOIN director d
ON d.staff_id = s.id_staff

--i. List of films less than 5 years old (sorted from most recent to oldest)

SELECT m.title, DATE_FORMAT(m.release_date,'%Y') parution
FROM movie m
HAVING parution > 2018
ORDER BY parution DESC

--j. Number of male and female actors

SELECT COUNT(a.id_actor) actor_number, s.gender
FROM staff s
INNER JOIN actor a
ON a.staff_id = s.id_staff
GROUP BY s.gender

--k. List of actors over 50 years of age (both past and present)

/*DATE FORMAT Allows you to change the format of a date*/
/*FROM_DAYS(TO_DAYS(1))-TO_DAYS(2)) Compares two periods (the current date (1) and the actor's date of birth (2)).*/
/*NOW() returns today's date and time.*/
/*Choice of formatting for year display, numeric (with 4 digits)*/

SELECT s.firstname, s.lastname, (                               
DATE_FORMAT                                             
(FROM_DAYS(TO_DAYS(NOW())-TO_DAYS(s.birthdate)),   
'%Y')+0)                                                
AS Age 
FROM staff s
INNER JOIN actor a
ON s.id_staff = a.staff_id
AND (DATE_FORMAT(FROM_DAYS(TO_DAYS(NOW())-TO_DAYS(s.birthdate)), '%Y')+0) > 50

--l. Actors having played in 3 or more films

SELECT s.firstname, s.lastname, COUNT(c.movie_id) Number_films
FROM staff s
INNER JOIN actor a
ON a.staff_id = s.id_staff
INNER JOIN casting c
ON c.actor_id = a.id_actor
GROUP BY c.actor_id
HAVING Number_films > 3                                 /*HAVING Allows you to filter a function*/

INFORMATION--(--To populate the database--)

INSERT INTO movie (id_movie, title, release_date, duration, synopsis, notation, poster, director_id) VALUES
(1, 'Star Wars Vol1', '1999-10-13', 136, 'Dans une galaxie une entre les Chevaliers Jedi et les Seigneurs noirs des Sith, personnes sensibles à la Force.', 6.2, 'film1.jpg', 1),
(2, 'Indiana Jones Vol1', '1981-09-22', 116, 'Pérou, 1936. Le professeur Henry Walton Jones Jr (dit « Indiana », ou « Indy »), un éminent archéologue américain et expert en occultisme, est sur le point de mettre la main sur une idole Chachapoyan.', 7.7, 'film2.jpg', 2),
(3, 'Batman Vol1', '1989-09-13', 126, 'Enfant, le milliardaire Bruce Wayne voit ses parents assassinés par un voleur des rues, qui en voulait au collier de perles de sa mère.', 7.1, 'film3.jpg', 3),
(4, 'X-Men Vol1', '2000-10-30', 104, '1944, dans un camp de concentration. Séparé par la force de ses parents, le jeune Erik Magnus Lehnsherr se découvre ses pouvoirs sous le coup de la colère : il peut contrôler les métaux.', 6.5, 'film4.jpg', 4),
(5, 'Grand Torino', '2008-06-15', 116, 'Walt Kowalski, vétéran de la guerre de Corée, raciste et irascible, vient de perdre sa femme. Une nuit, il surprend Thao, un de ses jeunes voisins Hmong, en train de voler sa Ford Gran Torino de 1972.', 7.7, 'film5.jpg', 5),
(6, 'Mad Max', '1979-08-21', 85, 'Un criminel, Montazano, membre du gang de motards « Aigles de la route » , fuit en tuant un agent de la police routière.', 6.8, 'film6.jpg', 6),
(7, 'Légende dautomne', '1994-02-03', 133, 'Dans le Montana dans les années 1960, un vieil indien raconte les secrets de la famille Ludlow.', 8.3, 'film7.jpg', 7),
(8, 'Braveheart', '1995-01-20', 178, 'Au XIIIe siècle, le roi Edouard Ier sempare du trône dEcosse et instaure un régime répressif.', 8, 'film8.jpg', 8),
(9, 'Star Wars Vol4', '1977-12-12', 121, 'Dans une galaxie une guerre entre les Chevaliers Jedi et les Seigneurs noirs des Sith, personnes sensibles à la Force.', 7.7, 'film9.jpg', 1),
(10, 'La liste de Schindler', '1933-06-12', 195, 'En 1939, les Allemands installés en Pologne, regroupent les juifs dans des ghettos dans le but de les utiliser comme des esclaves. ', 8.1, 'film10.jpg', 2),
(11, 'Dumbo', '2019-03-27', 72,'dans le Missouri. Holt Farrier, ancien cavalier de cirque, mancho, revient au cirque Medici Brothers, dirigé par Max Medici, après la Première Guerre mondiale. ', 5.8, 'film11.jpg', 3),
(12, 'Bullet Train', '2022-02-15', 126, 'Coccinelle est un assassin malchanceux et particulièrement déterminé à accomplir sa nouvelle mission paisiblement après que la plupart des ses missions aient déraillé.', 6.5, 'film12.jpg', 9),
(13, 'Once Upon a time...', '2019-03-23', 181,'En 1969, la star de télévision Rick Dalton et le cascadeur Cliff Booth, sa doublure de longue date, poursuivent leurs carrières au sein d’une industrie qui a changé. ', 7.2, 'film13.jpg', 10),
(14, 'Inglourious Basterds', '2009-12-12', 153, 'Dans la France occupée de 1940, Shosanna Dreyfus assiste à la mort de sa famille tombée entre les mains du colonel nazi Hans Landa.', 7.4, 'film14.jpg', 10);


----------------------------------------------------------------------------------

INSERT INTO staff (id_staff, lastname, firstname, gender, birthdate) VALUES
(1, 'Lucas', 'George', 'Masculin', '1944-05-14'),
(2, 'Spielberg', 'Steven', 'Masculin', '1946-12-18'),
(3, 'Burton', 'Tim', 'Masculin', '1958-08-25'),
(4, 'Singer', 'Bryan', 'Masculin', '1965-09-17'),
(5, 'McGregor', 'Ewan', 'Masculin', '1971-03-31' ),
(6, 'Neeson', 'Liam', 'Masculin', '1952-06-07'),
(7, 'Portmann', 'Nathalie', 'Feminin', '1981-06-09'),
(8, 'Ford', 'Harisson', 'Masculin', '1942-07-13'),
(9, 'Allen', 'Karen', 'Feminin', '1951-10-05'),
(10, 'Denholm', 'Eliott', 'Masculin', '1922-05-31'),
(11, 'Keaton', 'Mickael', 'Masculin', '1951-09-05'),
(12, 'Nicholson', 'Jack', 'Masculin', '1937-04-22'),
(13, 'Basinger', 'Kim', 'Feminin', '1953-12-08'),
(14, 'Stewart', 'Patrick', 'Masculin', '1940-07-13'),
(15, 'Jackman', 'Hugh', 'Masculin', '1968-10-12'),
(16, 'McKellen', 'Ian', 'Masculin', '1939-05-25'),
(17, 'Eastwood', 'Clint', 'Masculin', '1930-05-31'),
(18, 'Gibson', 'Mel', 'Masculin', '1956-01-03'),
(19, 'Miller', 'George', 'Masculin', '1945-03-03'),
(20, 'Zwick', 'Edward', 'Masculin', '1952-10-08'),
(21, 'Pitt', 'Brad', 'Masculin', '1963-12-18'),
(22, 'Hopkins', 'Anthony', 'Masculin', '1937-12-31'),
(23, 'Leitch', 'David', 'Masculin', '1975-11-16'),
(24, 'Tarantino', 'Quentin', 'Masculin','1963-03-27');

----------------------------------------------------------------------------------

INSERT INTO director (id_director, staff_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 17),
(6, 19),
(7, 20),
(8, 18),
(9, 23),
(10, 24);

INSERT INTO actor(id_actor, staff_id) VALUES
(1, 5),
(2, 6),
(3, 7),
(4, 8),
(5, 9),
(6, 10),
(7, 11),
(8, 12),
(9, 13),
(10, 14),
(11, 15),
(12, 16),
(13, 17),
(14, 18),
(15, 21),
(16, 22);


----------------------------------------------------------------------------------

INSERT INTO casting (actor_id, role, movie_id) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 2),
(5, 5, 2),
(6, 6, 2),
(7, 7, 3),
(8, 8, 3),
(9, 9, 3),
(10, 10, 4),
(11, 11, 4),
(12, 12, 4),
(13, 13, 5),
(14, 14, 6),
(15, 15, 7),
(16, 16, 7),
(14, 17, 8),
(4, 18, 9),
(2, 19, 10),
(7, 20, 11),
(15, 21, 12),
(15, 22, 13),
(15, 23, 14);

INSERT INTO Movie_Genre_Link (movie_id, genre_id) VALUES
(1, 1),
(2, 1),
(3, 3),
(4, 1),
(5, 2),
(6, 6),
(7, 2),
(8, 2),
(9, 1),
(10, 2),
(11, 1),
(12, 4),
(13, 4),
(14, 2);

----------------------------------------------------------------------------------

INSERT INTO genre(id_genre, label) VALUES
(1, 'Science-Fiction'),
(2, 'Drame'),
(3, 'Aventure'),
(4, 'Comédie'),
(5, 'Horreur'),
(6, 'Action');

INSERT INTO role (id_role, name) VALUES
(1, 'Obiwan Kenobi'),
(2, 'Qui Jon Jim'),
(3, 'Princess Amidala'),
(4, 'Dr Jones (indy)'),
(5, 'Marion Ravenwood'),
(6, 'Marcus Brody'),
(7, 'Bruce Wayne (Batman)'),
(8,  'Joker'),
(9, 'Vicki Vale'),
(10, 'Professeur Charles Xavier'),
(11, 'Logan'),
(12, 'Magnetto'),
(13, 'Walt Kowalski'),
(14, 'Mad Max'),
(15, 'Tristan Ludlow'),
(16, 'William Ludlow'),
(17, 'William Wallace'),
(18, 'Han Solo'),
(19, 'Oskar Schindler'),
(20, 'V.A. Vandevere'),
(21, 'Coccinelle'),
(22, 'Cliff Booth'),
(23, 'Aldo Raine');


----------------------------------------------------------------------------------