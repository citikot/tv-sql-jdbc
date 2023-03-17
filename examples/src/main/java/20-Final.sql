DROP DATABASE IF EXISTS bookstore;
CREATE DATABASE bookstore;
USE bookstore;

CREATE TABLE author (
  id INT(11) NOT NULL AUTO_INCREMENT,
  firstname VARCHAR(50) NOT NULL,
  lastname VARCHAR(50) NOT NULL,
  patronymic VARCHAR(50) DEFAULT NULL,
  birthdate DATE NOT NULL,
  PRIMARY KEY (id),
  KEY firstname (firstname),
  KEY lastname (lastname),
  KEY patronymic (patronymic),
  KEY birthdate (birthdate)
);


CREATE TABLE author_address (
  id INT(11) NOT NULL AUTO_INCREMENT,
  authorid INT(11) NOT NULL,
  email VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY email (email),
  FOREIGN KEY (`authorid`) REFERENCES author (id) ON DELETE CASCADE
) ;


CREATE TABLE book (
  id INT(11) NOT NULL AUTO_INCREMENT,
  title VARCHAR(50) NOT NULL,
  year INT(11) NOT NULL,
  pages INT(11) NOT NULL,
  PRIMARY KEY (id),
  KEY year (year),
  KEY pages (pages)
) ;

CREATE TABLE author_book (
  id INT(11) NOT NULL AUTO_INCREMENT,
  authorid INT(11) NOT NULL,
  bookid INT(11) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY author_book (authorid,bookid),
  KEY bookid (bookid),
  FOREIGN KEY (bookid) REFERENCES book (id) ON DELETE CASCADE,
  FOREIGN KEY (authorid) REFERENCES author (id) ON DELETE CASCADE
) ;

