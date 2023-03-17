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
  KEY/*INDEX*/ firstname (firstname),
  KEY/*INDEX*/ lastname (lastname),
  KEY/*INDEX*/ patronymic (patronymic),
  KEY/*INDEX*/ birthdate (birthdate)
);


INSERT INTO author VALUES(NULL,"Иван","Иванов","Иванович","1980-7-1");
INSERT INTO author VALUES(NULL,"Иван","Смирнов","Николаевич","1968-12-23");
INSERT INTO author VALUES(NULL,"Петр","Петров","Петрович","1978-12-23");
INSERT INTO author VALUES(NULL,"Сидор","Иваненко","Сидорович","1990-7-1");
INSERT INTO author VALUES(NULL,"Вася","Пупкин",NULL,"2000-1-1");

SELECT * FROM author;

CREATE TABLE author_address (
  id INT(11) NOT NULL AUTO_INCREMENT,
  authorid INT(11) NOT NULL,
  email VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY email (email),
  FOREIGN KEY (authorid) REFERENCES author (id) ON DELETE CASCADE
) ;

INSERT INTO author_address VALUES(NULL, 1, "ivanov@mail.ru");
INSERT INTO author_address VALUES(NULL, 1, "ivanov@gmail.com");
INSERT INTO author_address VALUES(NULL, 1, "ivanov@yandex.ru");
INSERT INTO author_address VALUES(NULL, 3, "petrov@mail.ru");
INSERT INTO author_address VALUES(NULL, 3, "petrov@yandex.ru");

/* WRONG REQUESTS, CAN'T BE EXECUTED*/
INSERT INTO author_address VALUES(NULL, 3, "petrov@mail.ru"); 
INSERT INTO author_address VALUES(NULL, 10, "sidorov@mail.ru");

SELECT * FROM author_address;

SELECT firstname, lastname, patronymic, email FROM author INNER JOIN author_address ON authorid=author.id;
SELECT firstname, lastname, patronymic, email FROM author JOIN author_address ON authorid=author.id;

SELECT firstname, lastname, patronymic, email FROM author, author_address WHERE authorid=author.id;

SELECT firstname, lastname, patronymic,email FROM author LEFT OUTER JOIN author_address ON authorid=author.id;
SELECT firstname, lastname, patronymic,email FROM author LEFT JOIN author_address ON authorid=author.id;

SELECT firstname, lastname, patronymic,email FROM author RIGHT OUTER JOIN author_address ON authorid=author.id;
SELECT firstname, lastname, patronymic,email FROM author RIGHT JOIN author_address ON authorid=author.id;

SELECT firstname AS PERSON_NAME, lastname AS FAMILY_NAME , patronymic, email AS MAIL_ADDRESS FROM author JOIN author_address ON authorid=author.id;

DELETE FROM author WHERE lastname = 'Иванов';
SELECT * FROM author_address;




