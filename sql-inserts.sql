INSERT INTO Typ_produktu
VALUES(1, 'TELEFON');
INSERT INTO Typ_produktu
VALUES(2, 'TELEWIZOR');
INSERT INTO Typ_produktu
VALUES(3, 'SLUCHAWKI');

INSERT INTO Produkt
VALUES(1, 'SAMSUNG', 500, 1);
INSERT INTO Produkt
VALUES(2, 'HUAWEI', 1000, 1);
INSERT INTO Produkt
VALUES(3, 'LG', 1500, 1);
INSERT INTO Produkt
VALUES(4, 'SAMSUNG50UE', 5000, 2);
INSERT INTO Produkt
VALUES(5, 'LG55UE', 4000, 2);
INSERT INTO Produkt
VALUES(6, 'RAZER CHROMA', 500, 3);
INSERT INTO Produkt
VALUES(7, 'SGPC', 220, 3);

INSERT INTO Dostawca
VALUES(1, 'AWPOL');
INSERT INTO Dostawca
VALUES(2, 'KOLPORTER');
INSERT INTO Dostawca
VALUES(3, 'OLIWIA DOSTAWY');

INSERT INTO Adres
VALUES(1, 'KIELCE', 'JALOWCOWA', 21, 8);
INSERT INTO Adres
VALUES(2, 'WARSZAWA', 'NOWOGRODZKA', 17, 8);
INSERT INTO Adres
VALUES(3, 'WARSZAWA', 'KOSZYKOWA', 86, NULL);
INSERT INTO Adres
VALUES(4, 'KRAKÓW', 'KRAKOWSKA', 33, 1);
INSERT INTO Adres
VALUES(5, 'MYSZKÓW', 'MYSZKI', 17, NULL);
INSERT INTO Adres
VALUES(6, 'GDAŃSK', 'CHAJZERA', 12, 3);

INSERT INTO Klient
VALUES(1, 1, 'MODESTA', 'WÓJCIK', 'modzia@onet.eu');
INSERT INTO Klient
VALUES(2, 2, 'OLIWIA', 'CICHY', 'furude.rika@wp.pl');
INSERT INTO Klient
VALUES(3, 3, 'JANUSZ', 'MAJ', 'JM@gmail.com');
INSERT INTO Klient
VALUES(4, 4, 'JAKUB', 'KOCJAN', 'kacor@gmail.com');
INSERT INTO Klient
VALUES(5, 5, 'PAWEŁ', 'NARUSZEWICZ', 'patos@gmail.com');
INSERT INTO Klient
VALUES(2, 6, 'RAFAŁ', 'WÓJCIK', 'r.wojcik96@gmail.com');
INSERT INTO Klient
VALUES(6, 7, 'CRISTIANO', 'RONALDO', 'CR7@tlen.pl');
INSERT INTO Klient
VALUES(6, 8, 'ELON', 'MUSK', 'ELONmusk11222121@gmail.com');

INSERT INTO Pracownik
VALUES(7, 5000, '2010-07-28');
INSERT INTO Pracownik
VALUES(3, 1000, '2010-07-29');
INSERT INTO Pracownik
VALUES(4, 2000, '2013-03-29');
INSERT INTO Pracownik
VALUES(5, 1500, '2015-07-29');
INSERT INTO Pracownik
VALUES(6, 3500, '2010-06-29');
INSERT INTO Pracownik
VALUES(8, 1000, '2019-07-28');

INSERT INTO Zamowienie
VALUES(1, 'WYSLANE', '2020-04-11', 1, 7);
INSERT INTO Zamowienie
VALUES(2, 'ZREALIZOWANE', '2020-03-11', 2, 3);
INSERT INTO Zamowienie
VALUES(3, 'PRZETWARZANE', '2020-02-11', 3, 4);
INSERT INTO Zamowienie
VALUES(4, 'WYSLANE', '2020-05-11', 2, 5);
INSERT INTO Zamowienie
VALUES(5, 'ZREALIZOWANE', '2020-06-13', 4, 6);
INSERT INTO Zamowienie
VALUES(6, 'ZREALIZOWANE', '2020-06-14', 5, 7);

INSERT INTO Skladnik_zamowienia
VALUES(1, 1, 5);
INSERT INTO Skladnik_zamowienia
VALUES(2, 1, 2);
INSERT INTO Skladnik_zamowienia
VALUES(3, 2, 3);
INSERT INTO Skladnik_zamowienia
VALUES(4, 2, 100);
INSERT INTO Skladnik_zamowienia
VALUES(5, 3, 4);
INSERT INTO Skladnik_zamowienia
VALUES(2, 3, 5);
INSERT INTO Skladnik_zamowienia
VALUES(3, 4, 6);
INSERT INTO Skladnik_zamowienia
VALUES(4, 4, 1);
INSERT INTO Skladnik_zamowienia
VALUES(5, 5, 2);
INSERT INTO Skladnik_zamowienia
VALUES(6, 5, 3);
INSERT INTO Skladnik_zamowienia
VALUES(2, 5, 10);
INSERT INTO Skladnik_zamowienia
VALUES(1, 6, 2);

INSERT INTO ProduktDostawca
VALUES(400, 1, 1);
INSERT INTO ProduktDostawca
VALUES(900, 2, 1);
INSERT INTO ProduktDostawca
VALUES(1000, 3, 2);
INSERT INTO ProduktDostawca
VALUES(4500, 4, 3);
INSERT INTO ProduktDostawca
VALUES(3000, 5, 2);
INSERT INTO ProduktDostawca
VALUES(350, 6, 2);
INSERT INTO ProduktDostawca
VALUES(199, 7, 3);
INSERT INTO ProduktDostawca
VALUES(399, 1, 2);
INSERT INTO ProduktDostawca
VALUES(398, 1, 3);

