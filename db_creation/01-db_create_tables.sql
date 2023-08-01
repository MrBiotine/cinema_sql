
CREATE DATABASE IF NOT EXISTS `movie-pdo-01` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;
USE `movie-pdo-01`;

CREATE TABLE IF NOT EXISTS Staff(
   id_staff INT NOT NULL AUTO_INCREMENT,
   firstname VARCHAR(100),
   lastname VARCHAR(100),
   birthdate DATE,
   gender VARCHAR(50),
   is_alive TINYINT(1),
   PRIMARY KEY(id_staff) 
);

CREATE TABLE IF NOT EXISTS Actor(
   id_actor CHAR(50),
   staff_id INT NOT NULL,
   PRIMARY KEY(id_actor),
   UNIQUE(staff_id),
   FOREIGN KEY(staff_id) REFERENCES Staff(id_staff)
);

CREATE TABLE IF NOT EXISTS Director(
   id_director INT NOT NULL AUTO_INCREMENT,
   staff_id INT NOT NULL,
   PRIMARY KEY(id_director),
   UNIQUE(staff_id),
   FOREIGN KEY(staff_id) REFERENCES Staff(id_staff)
);

CREATE TABLE IF NOT EXISTS Role(
   id_role INT NOT NULL AUTO_INCREMENT,
   name VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_role)
);

CREATE TABLE IF NOT EXISTS Genre(
   id_genre INT NOT NULL AUTO_INCREMENT,
   label VARCHAR(30) NOT NULL,
   PRIMARY KEY(id_genre)
);

CREATE TABLE IF NOT EXISTS Movie(
   id_movie INT NOT NULL AUTO_INCREMENT,
   director_id INT NOT NULL,
   title VARCHAR(30) NOT NULL,
   duration INT NOT NULL,
   release_date DATE NOT NULL,
   notation DECIMAL(2,1),
   synopsie TEXT,
   poster VARCHAR(255),   
   PRIMARY KEY(id_movie),
   FOREIGN KEY(director_id) REFERENCES Director(id_director)
);

CREATE TABLE IF NOT EXISTS CASTING(
   movie_id INT NOT NULL,
   actor_id INT NOT NULL,
   role_id INT NOT NULL,
   PRIMARY KEY(movie_id, actor_id, role_id),
   FOREIGN KEY(movie_id) REFERENCES Movie(id_movie),
   FOREIGN KEY(actor_id) REFERENCES Actor(id_actor),
   FOREIGN KEY(role_id) REFERENCES Role(id_role)
);

CREATE TABLE IF NOT EXISTS Movie_Genre_Link(
   movie_id INT NOT NULL,
   genre_id INT NOT NULL,
   PRIMARY KEY(movie_id, genre_id),
   FOREIGN KEY(movie_id) REFERENCES Movie(id_movie),
   FOREIGN KEY(genre_id) REFERENCES Genre(id_genre)
);
