DROP DATABASE IF EXISTS bookstore;
CREATE DATABASE bookstore;
USE bookstore;

CREATE TABLE author (
  id INT(11) NOT NULL AUTO_INCREMENT,
  firstname VARCHAR(50) NOT NULL,
  lastname VARCHAR(50) NOT NULL,
  patronymic VARCHAR(50) DEFAULT NULL,
  birthdate DATE NOT NULL,
  UNIQUE KEY/*INDEX*/ firstname (firstname),
  KEY/*INDEX*/ lastname (lastname),
  KEY/*INDEX*/ patronymic (patronymic),
  KEY/*INDEX*/ birthdate (birthdate),
  PRIMARY KEY (id)
);

INSERT INTO author VALUES(NULL,"Иван","Иванов","Иванович","1980-7-1");
INSERT INTO author VALUES(NULL,"Иван","Смирнов","Николаевич","1968-12-23");

