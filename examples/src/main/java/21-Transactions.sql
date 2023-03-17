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


CREATE TABLE author_address (
  id INT(11) NOT NULL AUTO_INCREMENT,
  authorid INT(11) NOT NULL,
  email VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY email (email),
  FOREIGN KEY (`authorid`) REFERENCES author (id)
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
  FOREIGN KEY (bookid) REFERENCES book (id),
  FOREIGN KEY (authorid) REFERENCES author (id)
) ;

START TRANSACTION; /*BEGIN*/
INSERT INTO author VALUES(NULL,"Иван","Иванов","Иванович","1980-7-1");
SELECT @author1ID:= LAST_INSERT_ID();
INSERT INTO author VALUES(NULL,"Иван","Смирнов","Николаевич","1968-12-23");
SELECT @author2ID:= LAST_INSERT_ID();
INSERT INTO book VALUES(NULL,"С++",2010,250);
SELECT @bookID := LAST_INSERT_ID();
INSERT INTO author_book VALUES(NULL,@author1ID,@bookID);
INSERT INTO author_book VALUES(NULL,@author2ID,@bookID);
COMMIT;
SELECT firstname, lastname, patronymic, title, year, pages FROM author JOIN author_book ON authorid=author.id JOIN book ON bookid = book.id;

START TRANSACTION;
INSERT INTO author VALUES(NULL,"Сидор","Сидорович","Сидоров","1960-7-1");
SELECT @author1ID:= LAST_INSERT_ID();
INSERT INTO author VALUES(NULL,"Николай","Федоров","Николаевич","1988-12-23");
SELECT @author2ID:= LAST_INSERT_ID();
INSERT INTO book VALUES(NULL,"Java",2010,250);
SELECT @bookID := LAST_INSERT_ID();
INSERT INTO author_book VALUES(NULL,@author1ID,@bookID);
INSERT INTO author_book VALUES(NULL,@author2ID,@bookID);
ROLLBACK;
SELECT firstname, lastname, patronymic, title, year, pages FROM author JOIN author_book ON authorid=author.id JOIN book ON bookid = book.id;
