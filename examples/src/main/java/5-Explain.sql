/* EXPLAIN */
SELECT * FROM author WHERE ID = 2;
SELECT * FROM author WHERE firstname = "Иванов";
SELECT * FROM author WHERE birthdate="1978-12-23";
SELECT * FROM author WHERE patronymic IS NULL;

SELECT * FROM author WHERE firstname = "Иванов" AND lastname = "Иван";
SELECT * FROM author WHERE patronymic IS NULL AND firstname = "Иванов";

SELECT lastname FROM author WHERE lastname LIKE "Иван%";

SELECT lastname FROM author WHERE lastname LIKE "%ов";

