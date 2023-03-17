UPDATE author SET lastname = "Сидоров"; 
SELECT * FROM author;

UPDATE author SET lastname = "Петров" WHERE firstname = "Петр"; 
SELECT * FROM author;

UPDATE author SET lastname = "Петров" WHERE firstname = "Петр" OR firstname = "Иван"; 
SELECT * FROM author;

UPDATE author SET lastname = "Михайлов" WHERE firstname = "Петр" OR firstname = "Иван" COLLATE utf8_bin; 
SELECT * FROM author;
