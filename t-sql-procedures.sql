/*
1.

Procedura wyœwietli wszystkie nazwy produktów dostarczanych przez dostawcê, którego nazwa
zostanie podana w parametrze procedury, wyœwietli te¿ ró¿nicê pomiêdzy cen¹ hurtow¹, 
a detaliczn¹ ("sklepow¹").

parametry: nazwaDostawcy;


2.

Procedura zmieni nazwê ulicy z podanego wraz z ni¹ (nazw¹) miasta na now¹, te¿
podan¹ w parametrze, we wszystkich rekordach tabeli Adres.

parametry: miasto, staraUlica, nowaUlica;
*/

--1

CREATE PROCEDURE produktyDostawcy
@nazwaDostawcy varchar(255)
AS
BEGIN
SELECT d.nazwa, p.nazwa, p.cena - pd.cena_hurtowa AS 'zysk brutto' FROM Produkt p
INNER JOIN ProduktDostawca pd on p.id_produkt = pd.id_produkt
INNER JOIN Dostawca d on d.id_dostawcy = pd.id_dostawcy
WHERE d.nazwa = @nazwaDostawcy;
END

--test
exec produktyDostawcy 'OLIWIA DOSTAWY'


--2

CREATE PROCEDURE nowaNazwaUlicy
@miasto varchar(255),
@staraUlica varchar(255),
@nowaUlica varchar(255)
AS
BEGIN
UPDATE Adres SET ulica = @nowaUlica WHERE ulica = @staraUlica AND miasto = @miasto;
END

--test
EXEC nowaNazwaUlicy 'Gdañsk', 'Chajzera', 'Chrobrego';
