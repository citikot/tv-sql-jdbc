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
) ;

INSERT INTO author VALUES(NULL,"Иван","Иванов","Иванович","1980-7-1");
INSERT INTO author VALUES(NULL,"Иван","Смирнов","Николаевич","1968-12-23");
INSERT INTO author VALUES(NULL,"Петр","Петров","Петрович","1978-12-23");
INSERT INTO author VALUES(NULL,"Сидор","Иваненко","Сидорович","1990-7-1");
INSERT INTO author VALUES(NULL,"Вася","Пупкин",NULL,"2000-1-1");

INSERT INTO author(lastname, firstname,birthdate) VALUES("ИВАН","Иванов","1980-7-1");

ALTER TABLE author ADD COLUMN sex CHAR(1); 
SELECT * FROM author;

INSERT INTO author VALUES(NULL,"Анна","Семенова","Николаевна","2000-1-1","F"); 
INSERT INTO author VALUES(NULL,"Федор","Федоров",NULL,"2000-1-1","M"); 
SELECT * FROM author;

ALTER TABLE author DROP COLUMN sex ; 
SELECT * FROM author;
