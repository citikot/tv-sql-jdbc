SELECT COUNT(*) FROM author;

SELECT * FROM author;
SELECT firstname, lastname FROM author;
SELECT firstname, lastname FROM author WHERE firstname = "����";
SELECT firstname, lastname FROM author WHERE BINARY firstname = "����";
SELECT firstname, lastname FROM author WHERE patronymic IS NULL;
SELECT firstname, lastname FROM author WHERE patronymic IS NOT NULL;

/* wrong requests */
SELECT firstname, lastname FROM author WHERE patronymic = NULL;
SELECT firstname, lastname FROM author WHERE NULL = NULL; 


SELECT firstname, lastname FROM author WHERE lastname LIKE "����%";
SELECT firstname, lastname FROM author WHERE lastname LIKE "%��";
SELECT firstname, lastname FROM author WHERE lastname LIKE "����__";
SELECT firstname, patronymic , birthdate FROM author WHERE patronymic IS NULL AND lastname LIKE "����__";
SELECT firstname, patronymic, birthdate FROM author WHERE patronymic IS NULL OR lastname LIKE "����__";
SELECT * FROM author WHERE patronymic IS NULL OR (lastname LIKE "����%" AND birthdate > "1990-1-1");

SELECT DISTINCT firstname FROM author;
SELECT DISTINCT firstname, lastname FROM author;

SELECT * FROM author ORDER BY birthdate;
SELECT * FROM author ORDER BY birthdate DESC;
SELECT * FROM author WHERE lastname LIKE "%��" ORDER BY birthdate;
SELECT * FROM author ORDER BY firstname, lastname;
SELECT * FROM author ORDER BY BINARY firstname, lastname;

SELECT * FROM author ORDER BY BINARY firstname, lastname LIMIT 3;
SELECT * FROM author ORDER BY BINARY firstname, lastname LIMIT 2,3;

SELECT firstname, COUNT(firstname) FROM author GROUP BY firstname;
SELECT firstname, COUNT(firstname) FROM author GROUP BY firstname HAVING COUNT(*) > 1;
SELECT firstname, COUNT(firstname) FROM author GROUP BY firstname HAVING COUNT(*) > 2;

SELECT * FROM author WHERE id IN (1,2,4);

SELECT * FROM author WHERE lastname IN ("������","�������");

