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


CREATE TABLE author_address (
  id INT(11) NOT NULL AUTO_INCREMENT,
  authorid INT(11) NOT NULL,
  email VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY email (email),
  FOREIGN KEY (`authorid`) REFERENCES author (id) ON DELETE CASCADE
) ;

INSERT INTO author_address VALUES(NULL, 1, "ivanov@mail.ru");
INSERT INTO author_address VALUES(NULL, 1, "ivanov@gmail.com");
INSERT INTO author_address VALUES(NULL, 1, "ivanov@yandex.ru");
INSERT INTO author_address VALUES(NULL, 3, "petrov@mail.ru");
INSERT INTO author_address VALUES(NULL, 3, "petrov@yandex.ru");


CREATE TABLE book (
  id INT(11) NOT NULL AUTO_INCREMENT,
  title VARCHAR(50) NOT NULL,
  year INT NOT NULL,
  pages INT NOT NULL,
  PRIMARY KEY (id),
  KEY year (year),
  KEY pages (pages)
) ;

INSERT INTO book VALUES(NULL,"С++",2010,250);
INSERT INTO book VALUES(NULL,"Java",2005,100);
INSERT INTO book VALUES(NULL,"MySQL",2013,154);

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

INSERT INTO author_book VALUES (NULL, 1,1);
INSERT INTO author_book VALUES (NULL, 1,2);
INSERT INTO author_book VALUES (NULL, 2,1);
INSERT INTO author_book VALUES (NULL, 3,1);
INSERT INTO author_book VALUES (NULL, 3,3);

/* WRONG REQUESTS, CAN'T BE EXECUTED*/
INSERT INTO author_book VALUES (NULL, 3,1);
INSERT INTO author_book VALUES (NULL, 3,12);
INSERT INTO author_book VALUES (NULL, 8,1);

SELECT firstname, lastname, patronymic, title, year, pages FROM author JOIN author_book ON authorid=author.id JOIN book ON bookid = book.id;
SELECT firstname, lastname, patronymic, title, year, pages FROM author LEFT JOIN author_book ON authorid=author.id LEFT JOIN book ON bookid = book.id;

SELECT firstname, COUNT(firstname) FROM author JOIN author_address ON authorid = author.id GROUP BY firstname;
SELECT firstname, COUNT(firstname) FROM author JOIN author_address ON authorid = author.id GROUP BY firstname HAVING COUNT(*) > 2;

SELECT firstname, lastname FROM author WHERE id IN (SELECT authorid FROM author_book WHERE bookid = 1);

SELECT firstname, lastname FROM author WHERE id IN (SELECT authorid FROM author_book WHERE bookid IN (SELECT id FROM book WHERE title ="С++"));

SELECT firstname, lastname FROM author WHERE id NOT IN (SELECT authorid FROM author_book WHERE bookid IN (SELECT id FROM book WHERE title ="С++"));

SELECT * FROM author WHERE EXISTS (SELECT * FROM author_address WHERE ID = 10);
SELECT * FROM author WHERE NOT EXISTS (SELECT * FROM author_address WHERE ID = 10);

SELECT @name := firstname FROM author WHERE ID = 1

