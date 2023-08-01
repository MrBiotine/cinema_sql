--SQL QUERIES CINEMA EXERCISE--

--a. Film information (id_film): title, release year, duration (in HH:MM format) and director

SELECT m.id_movie, m.title, DATE_FORMAT(m.release_date,'%Y') AS "Année de sortie", SEC_TO_TIME(m.duration*60) AS "Durée en h,min,s", s.lastname AS "nom du réalisateur"    
FROM movie m                                                                                                                               
INNER JOIN director d                                                                                                                      
ON d.id_director = m.director_id                                                                                                           
INNER JOIN staff s                                                                                                                          
ON s.id_staff = d.staff_id                                                                                        --LIMIT permet d'afficher la première référence

--b. Liste des films dont la durée excède 2h15 classés par durée (du + long au + court)

SELECT f.titre, SEC_TO_TIME(f.duree*60) AS Durée                                                --SELECT Permet de retourner des enregistrements dans un tableau de résultat. Cette commande peut sélectionner une ou plusieurs colonnes d’une table.
FROM film f                                                                                     
WHERE f.duree > 135
ORDER BY Durée DESC                                                                             --ORDER BY Pour afficher par ordre décroissant        

--c. Liste des films d’un réalisateur (en précisant l’année de sortie) 

SELECT f.titre, f.annee_sortie, p.nom, p.prenom
FROM film f
INNER JOIN realisateur r
ON f.id_realisateur = r.id_realisateur
INNER JOIN personne p
ON r.id_realisateur = p.id_personne
AND r.id_realisateur = 1

--d. Nombre de films par genre (classés dans l’ordre décroissant)

SELECT g.type, COUNT(c.id_film) AS Nombre_film                                                  --La fonction COUNT() permet de compter le nombre de films, il est d'usage de compter les id plutôt que les noms
FROM genre_film g
INNER JOIN classer c
ON g.genre_film = c.genre_film
GROUP BY g.type                                                                                 --Lorsqu'il y a une fonction dans la commande SELECT et deux tables il faut faire une jointure avec INNER JOIN 
ORDER BY Nombre_film DESC                                                                       --et il faut également utiliser un GROUP BY, il est d'usage de grouper les id plutôt que les noms                                

--e. Nombre de films par réalisateur (classés dans l’ordre décroissant)

SELECT p.nom, p.prenom, COUNT(f.id_film) AS Nombre_film
FROM realisateur r
INNER JOIN film f
ON f.id_realisateur = r.id_realisateur
INNER JOIN personne p
ON r.id_personne = p.id_personne
GROUP BY r.id_realisateur
ORDER BY Nombre_film DESC

--f. Casting d’un film en particulier (id_film) : nom, prénom des acteurs + sexe

SELECT c.id_film, p.nom, p.prenom, p.sexe
FROM casting c
INNER JOIN acteur a
ON a.id_acteur = c.id_acteur
INNER JOIN personne p
ON p.id_personne = a.id_personne
AND c.id_film = 1

--g. Films tournés par un acteur en particulier (id_acteur) avec leur rôle et l’année de sortie (du film le plus récent au plus ancien)

SELECT c.id_acteur, r.nom, r.prenom, r.pseudo, f.titre, f.annee_sortie
FROM casting c
INNER JOIN role_acteur r
ON r.role_acteur = c.role_acteur
INNER JOIN film f
ON f.id_film = c.id_film
AND c.id_acteur = 2
ORDER BY f.annee_sortie DESC

--h. Liste des personnes qui sont à la fois acteurs et réalisateurs

SELECT p.prenom, p.nom
FROM personne p
INNER JOIN acteur a
ON a.id_personne = p.id_personne
INNER JOIN realisateur r
ON r.id_personne = p.id_personne

--i. Liste des films qui ont moins de 5 ans (classés du plus récent au plus ancien)

SELECT f.titre, f.annee_sortie
FROM film f
WHERE f.annee_sortie > 2018
ORDER BY f.annee_sortie DESC

--j. Nombre d’hommes et de femmes parmi les acteurs

SELECT COUNT(a.id_acteur) AS Nombre_Acteur, p.sexe
FROM personne p
INNER JOIN acteur a
ON a.id_personne = p.id_personne
GROUP BY p.sexe

--k. Liste des acteurs ayant plus de 50 ans (âge révolu et non révolu)

SELECT p.prenom, p.nom, (                               --DATE FORMAT Permet de modifier le format d'une date
DATE_FORMAT                                             --(FROM_DAYS(TO_DAYS(1))-TO_DAYS(2)) Permet de comparer deux périodes (La date du jour(1) et la date de Naissance de l'acteur (2))
(FROM_DAYS(TO_DAYS(NOW())-TO_DAYS(p.date_naissance)),   --NOW() permet de retourner la date et l’heure du jour (1).
'%Y')+0)                                                --%Y : Choix de formatage pour afficher l'année, numérique (avec 4 digits) 
AS Age 
FROM personne p
INNER JOIN acteur a
ON p.id_personne = a.id_personne
AND (DATE_FORMAT(FROM_DAYS(TO_DAYS(NOW())-TO_DAYS(p.date_naissance)), '%Y')+0) > 50

--l. Acteurs ayant joué dans 3 films ou plus

SELECT p.prenom, p.nom, COUNT(c.id_film) AS Nombre_Film
FROM personne p
INNER JOIN acteur a
ON a.id_personne = p.id_personne
INNER JOIN casting c
ON c.id_acteur = a.id_acteur
GROUP BY c.id_acteur
HAVING Nombre_Film > 3                                  --HAVING Permet de filtrer une fonction

--INFORMATIONS--(--Pour Peupler la Base de données--)

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