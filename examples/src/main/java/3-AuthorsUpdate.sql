UPDATE author SET lastname = "�������"; 
SELECT * FROM author;

UPDATE author SET lastname = "������" WHERE firstname = "����"; 
SELECT * FROM author;

UPDATE author SET lastname = "������" WHERE firstname = "����" OR firstname = "����"; 
SELECT * FROM author;

UPDATE author SET lastname = "��������" WHERE firstname = "����" OR firstname = "����" COLLATE utf8_bin; 
SELECT * FROM author;
