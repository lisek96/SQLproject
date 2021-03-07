-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-01-20 15:55:23.636

-- foreign keys
ALTER TABLE Klient DROP CONSTRAINT Klient_Adres;

ALTER TABLE Pracownik DROP CONSTRAINT Pracownik_Klient;

ALTER TABLE ProduktDostawca DROP CONSTRAINT ProduktDostawca_Dostawca;

ALTER TABLE ProduktDostawca DROP CONSTRAINT ProduktDostawca_Produkt;

ALTER TABLE Produkt DROP CONSTRAINT Produkt_Typ_produktu;

ALTER TABLE Zamowienie DROP CONSTRAINT Zamowienie_Klient;

ALTER TABLE Zamowienie DROP CONSTRAINT Zamowienie_Pracownik;

ALTER TABLE Skladnik_zamowienia DROP CONSTRAINT skladnik_zamowienia_Produkt;

ALTER TABLE Skladnik_zamowienia DROP CONSTRAINT skladnik_zamowienia_Zamowienie;

-- tables
DROP TABLE Adres;

DROP TABLE Dostawca;

DROP TABLE Klient;

DROP TABLE Pracownik;

DROP TABLE Produkt;

DROP TABLE ProduktDostawca;

DROP TABLE Skladnik_zamowienia;

DROP TABLE Typ_produktu;

DROP TABLE Zamowienie;

-- End of file.

