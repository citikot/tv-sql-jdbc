/* EXPLAIN */
SELECT * FROM author WHERE ID = 2;
SELECT * FROM author WHERE firstname = "������";
SELECT * FROM author WHERE birthdate="1978-12-23";
SELECT * FROM author WHERE patronymic IS NULL;

SELECT * FROM author WHERE firstname = "������" AND lastname = "����";
SELECT * FROM author WHERE patronymic IS NULL AND firstname = "������";

SELECT lastname FROM author WHERE lastname LIKE "����%";

SELECT lastname FROM author WHERE lastname LIKE "%��";

