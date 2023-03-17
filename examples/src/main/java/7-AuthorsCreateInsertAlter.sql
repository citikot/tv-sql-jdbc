DROP DATABASE IF EXISTS bookstore;
CREATE DATABASE bookstore;
USE bookstore;

CREATE TABLE author (
  id INT(11) NOT NULL AUTO_INCREMENT,
  firstname VARCHAR(50) NOT NULL,
  lastname VARCHAR(50) NOT NULL,
  patronymic VARCHAR(50) DEFAULT NULL,
  birthdate DATE NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO author VALUES(NULL,"Иван","Иванов","Иванович","1980-7-1");
INSERT INTO author VALUES(NULL,"Иван","Смирнов","Николаевич","1968-12-23");
INSERT INTO author VALUES(NULL,"Петр","Петров","Петрович","1978-12-23");
INSERT INTO author VALUES(NULL,"Сидор","Иваненко","Сидорович","1990-7-1");
INSERT INTO author VALUES(NULL,"Вася","Пупкин",NULL,"2000-1-1");

ALTER TABLE author ADD INDEX(patronymic);
ALTER TABLE author ADD INDEX(birthdate);
ALTER TABLE author ADD INDEX(firstname),ADD INDEX(lastname);

