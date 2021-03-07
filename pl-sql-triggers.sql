/*

1. 

Wyzwalacz zagwarantuje, ¿e w tabeli Adres, wszystkie miasta bêd¹ napisane
 tylko du¿ymi literami, co pozwoli wywo³ywaæ procedurê "showClients" bezproblemowo.
(bez tego, mog³yby byæ adresy z miastem 'Warszawa' lub 'WARSZAWA', jesli wywo³amy procedurê
na 'Warszawa' to nie weŸmie rekordów z miastem 'WARSZAWA')

2.

Wyzwalacz gwarantujê, ¿e po ka¿dej operacji DML, aktualna bêdzie nowa tabela 
"TypProduktuIlosc", w której zestawiony jest typ produktu z iloœci¹ produktów typu.

*/

--1
CREATE TRIGGER guaranteeUPPER
BEFORE UPDATE OF miasto OR INSERT
ON Adres
FOR EACH ROW
DECLARE
BEGIN
    :new.miasto := UPPER(:new.miasto);
END;

--test
UPDATE Adres SET miasto = 'Kielce' WHERE id_adres = 1;
SELECT * FROM adres;

--2
CREATE TABLE TypProduktuIlosc (Typ VARCHAR2(255) NOT NULL UNIQUE, Ilosc INT NOT NULL);

CREATE OR REPLACE TRIGGER refreshTypyProduktuilosc
AFTER UPDATE OR INSERT OR DELETE ON Produkt
DECLARE
BEGIN
DELETE FROM TypProduktuIlosc;
INSERT INTO TypProduktuIlosc (Typ, Ilosc) (SELECT tp.nazwa, COUNT(tp.nazwa) FROM Typ_produktu tp INNER JOIN Produkt p ON tp.id_typ_produktu = p.id_typ_produktu GROUP BY tp.nazwa);
END;

--test
SELECT* FROM TypProduktuIlosc
INSERT INTO Produkt VALUES (10, 'Samsung Galaxy Note S9', 2000, 2);
SELECT* FROM TypProduktuIlosc
