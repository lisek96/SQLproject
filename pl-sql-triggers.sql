/*

1. 

Wyzwalacz zagwarantuje, �e w tabeli Adres, wszystkie miasta b�d� napisane
 tylko du�ymi literami, co pozwoli wywo�ywa� procedur� "showClients" bezproblemowo.
(bez tego, mog�yby by� adresy z miastem 'Warszawa' lub 'WARSZAWA', jesli wywo�amy procedur�
na 'Warszawa' to nie we�mie rekord�w z miastem 'WARSZAWA')

2.

Wyzwalacz gwarantuj�, �e po ka�dej operacji DML, aktualna b�dzie nowa tabela 
"TypProduktuIlosc", w kt�rej zestawiony jest typ produktu z ilo�ci� produkt�w typu.

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
