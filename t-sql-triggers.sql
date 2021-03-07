/*

1.

Wyzwalacz "witamy w firmie" - wyzwalacz po dodaniu nowego pracownika, stworzy nowe zamówienie
skierowane do nowoprzyjêtego pracownika. Produktem wysy³anym do pracownika bêdzie produkt, 
którego cena jest najwy¿sza spoœród produktów, których cena jest ni¿sza od œredniej ceny
produktu w sklepie (jeœli jest wiêcej ni¿ jeden taki produkt, to wybieramy pierwszy). 
Na koniec wyœwietli wszystkie dane tego zamówienia
oraz nazwê i cenê produktu podarowanego nowemu pracownikowi. 
Zak³adamy, ¿e w jednym momencie mo¿e zostaæ dodanych wielu pracowników.
Pracownik obs³uguje sam siebie w ramach æwiczenia.

2.

Do wykonania tego wyzwalacza, musimy dodaæ kolumnê do tabeli pracownik o nazwie
"iloœæ obs³u¿onych zamówieñ". 

Wyzwalacz ma za zadanie zupdatowaæ tê kolumnê w tabeli pracownik
dla pracownika, którego status zamówienia zosta³ zmieniony na "WYS£ANE". Zak³adamy mo¿liwoœæ
zmienienia statusu wielu zamówieñ w jednej transkacji. Zamówienia mog¹ mieæ przypisane
ró¿nych klientów.
*/

--1

CREATE TRIGGER witamy
ON Pracownik
FOR INSERT
AS
BEGIN
	DECLARE insertedCursor CURSOR FOR (SELECT id_pracownik FROM Inserted);
	DECLARE @idPracownik int, @nextIdZamowienia INT, @idProdukt INT;
	OPEN insertedCursor
	FETCH NEXT FROM insertedCursor INTO @idPracownik;
	WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @idProdukt = (SELECT TOP 1 id_produkt
					  FROM Produkt
				          WHERE cena = (SELECT MAX(cena) 
		 					FROM (SELECT * 
							      FROM Produkt 
							      WHERE cena < (SELECT AVG(cena) 
									    FROM Produkt)) AS "ProduktyZCenANizszaOdSredniej" ))
			
			SET @nextIdZamowienia = (SELECT MAX(id_zamowienia)+1 FROM Zamowienie);
			
			INSERT INTO Zamowienie VALUES(@nextIdZamowienia, 'W realizacji', getDate(), @idPracownik, @idPracownik);
			INSERT INTO Skladnik_zamowienia VALUES (@idProdukt, @nextIdZamowienia, 1);
			
			SELECT z.id_zamowienia, z.status, z.data_zamowienia, z.id_klient, z.id_pracownik, p.nazwa, p.cena
			FROM Zamowienie z
			INNER JOIN skladnik_zamowienia sz on z.id_zamowienia = sz.id_zamowienia
			INNER JOIN produkt p on p.id_produkt = sz.id_produkt
			WHERE z.id_zamowienia = @nextIdZamowienia;
			
			FETCH NEXT FROM insertedCursor INTO @idPracownik;
		END
	CLOSE insertedCursor;
	DEALLOCATE insertedCursor;
END

--test
INSERT INTO klient VALUES (1, 200, 'Rafal', 'Cichy', 'email'); 
INSERT INTO pracownik VALUES(200, 1000, getDate(), 0);

--2

ALTER TABLE Pracownik ADD iloscObsluzonychZamowien INT;

CREATE TRIGGER aktualizacjaIlosciOZ
ON Zamowienie
FOR UPDATE
AS
BEGIN
	DECLARE insertedCursor CURSOR FOR (SELECT id_pracownik FROM Inserted WHERE status = 'WYS£ANE');
	DECLARE @idPracownik int;
	OPEN insertedCursor
	FETCH NEXT FROM insertedCursor INTO @idPracownik;
	PRINT(@idPracownik);
	WHILE @@FETCH_STATUS = 0
		BEGIN
			UPDATE Pracownik SET iloscObsluzonychZamowien = ISNULL(iloscObsluzonychZamowien, 0)+1 WHERE id_pracownik = @idPracownik;
			FETCH NEXT FROM insertedCursor INTO @idPracownik;
		END
	CLOSE insertedCursor;
	DEALLOCATE insertedCursor;
END

--test
UPDATE Zamowienie SET status = 'WYS£ANE' WHERE id_pracownik = 4;

