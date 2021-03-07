/*
1.

Procedura ma za zadanie wynagrodzić klienta, który złożył najwięcej zamowień.
Zamówienie ma za zadanie obsłużyć pracownik, który obsłużył dotychczas najmniej zamówień.
Do klienta zostanie wysłany przedmiot, który jest najtańszy z tych przedmiotów,
których cena przekracza wartość podaną w argumencie procedury. 
Procedura ustawi status zamowienia na "W realizacji",
a następnie wypisze:
imię i nazwisko klienta i pracownika
nazwe produktu i jego cenę
(W przypadku, w którym, byłoby więcej klientów, którzy złożyli najwięcej zamówień
i więcej pracowników, którzy obsłużyli najmniej zamówień, to po prostu bierzemy 
pierwszą osobę, która spełnia te kryteria)


2.

Procedura ma za zadanie wstawić nowego pracownika. Do procedury przekazujemy:
dane adresowe: miasto, ulica, nr budynku, nr mieszkania;
dane osobowe: imię, nazwisko, adres email;
pensja zostaję ustawiona defaultowo na 3500, a data zatrudniona na dzisiejszą.
Procedura przed dodaniem ma sprawdzić czy pracownik może już został dodany,
ma też sprawdzić, czy na przykład podany adres pracownika już istnieje w bazie 
(może jego rodzina tu pracuje lub była klientem sklepu?)
Jeśli rekordy istnieją, to oczywiście odpowiednio nie dopisujemy tego samego
adresu bądź pracownika. W celu uznania, że dany pracownik już jest w bazie, to 
musi być rekord z takim samym: adresem, imieniem, nazwiskiem i adresem email.
Procedura ma poinformować wykonawcę co udało się zrobić.

3.

Procedura ma za zadanie wyświetlić imiona i nazwiska klientów z podanego w parametrze miasta
oraz podać ile jest takich klientów. Procedura przyjmuje nazwę miasta w parametrze.

*/

1--

SET SERVEROUTPUT ON
CREATE OR REPLACE Procedure nagrodaDlaNajlepszegoKlienta
(cenaProduktu INT)
IS
idKlient INT; idPracownik INT; idProdukt INT; idNowegoZamowienia INT; 
produkt_ Produkt%rowtype; 
klient_ klient%rowtype; 
pracownik_ klient%rowtype;
BEGIN 

    SELECT id_klient
    INTO idKlient
    FROM   (SELECT id_klient
            FROM Zamowienie
            GROUP BY id_klient
            HAVING COUNT(*) = (SELECT MAX(COUNT(id_klient)) FROM Zamowienie GROUP BY id_klient))
    WHERE ROWNUM = 1;

    SELECT id_pracownik
    INTO idPracownik
    FROM   (SELECT id_pracownik
            FROM Zamowienie
            GROUP BY id_pracownik
            HAVING COUNT(*) = (SELECT MIN(COUNT(id_pracownik)) FROM Zamowienie GROUP BY id_pracownik))
    WHERE ROWNUM = 1;

    SELECT id_produkt
    INTO idProdukt
    FROM Produkt
    WHERE cena = (SELECT MIN(cena) FROM Produkt WHERE cena > cenaProduktu) AND ROWNUM = 1;
    
    SELECT MAX(id_zamowienia)+1 INTO idNowegoZamowienia FROM Zamowienie;
    
    INSERT INTO Zamowienie VALUES (idNowegoZamowienia, 'W REALIZACJI', Sysdate, idKlient, idPracownik);
    
    SELECT * INTO pracownik_ FROM Klient WHERE id_klient = idPracownik;
    SELECT * INTO klient_ FROM klient WHERE id_klient=idKlient;
    SELECT * INTO produkt_ FROM Produkt WHERE id_produkt=idProdukt;    
    dbms_output.put_line('Pracownik: ' || pracownik_.imie || ' ' || pracownik_.nazwisko);
    dbms_output.put_line('Klient: ' || klient_.imie || ' ' || klient_.nazwisko);
    dbms_output.put_line('Produkt: ' || produkt_.nazwa || ' ' || produkt_.cena || ' zl');
END;

--test
SET SERVEROUTPUT ON
BEGIN
   nagrodaDlaNajlepszegoKlienta(500);
END;

2--

CREATE OR REPLACE PROCEDURE dodajPracownika
(p_miasto adres.miasto%type, p_ulica adres.ulica%type, p_numerMieszkania adres.numer_mieszkania%type, p_numerBudynku adres.numer_budynku%type,
p_imie klient.imie%type, p_nazwisko klient.nazwisko%type, p_adresEmail klient.adres_email%type)
AS
p_pensja INT := 3500; p_dz Date := Sysdate; p_id INT; p_aid INT; checkAdres INT := 0; checkPracownik INT :=0;
BEGIN
    SELECT COUNT(*) INTO checkAdres FROM Adres WHERE miasto = p_miasto AND numer_budynku = p_numerBudynku AND numer_mieszkania = p_numerMieszkania AND ulica = p_ulica;
    
    IF checkAdres =0 THEN
        SELECT MAX(id_adres) + 1 INTO p_aid FROM Adres;
        INSERT INTO Adres VALUES(p_aid, p_miasto, p_ulica, p_numerBudynku, p_numerMieszkania);
        dbms_output.put_line('Dodano nowy adres');
    ELSE
        SELECT id_adres INTO p_aid FROM Adres WHERE miasto = p_miasto AND numer_budynku = p_numerBudynku AND numer_mieszkania = p_numerMieszkania AND ulica = p_ulica;
        dbms_output.put_line('Adres istnieje w bazie');
    END IF;
    
    SELECT COUNT(*) INTO checkPracownik FROM Klient WHERE imie = p_imie AND nazwisko = p_nazwisko AND adres_email = p_adresEmail AND id_adres = p_aid;
    
    IF checkPracownik = 0 THEN
        SELECT MAX(id_klient) + 1 INTO p_id FROM Klient;
        INSERT INTO Klient VALUES(p_aid, p_id, p_imie, p_nazwisko, p_adresEmail);
        INSERT INTO Pracownik VALUES(p_id, p_pensja, p_dz);
        dbms_output.put_line('Dopisano nowego pracownika');
    ELSE
        dbms_output.put_line('Pracownik już istnieje w bazie');
    END IF;
END;

--test
SET SERVEROUTPUT ON
BEGIN
    dodajPracownika('Warszawa', 'Koszykowa','27', NULL, 'Rafal', 'Wojcik', 'Email');
END;

3--

CREATE OR REPLACE PROCEDURE showClients
(nazwaMiasta Adres.miasto%type)
AS
CURSOR adresy_z_miasta IS SELECT id_adres FROM Adres WHERE miasto = nazwaMiasta;
adresID INT;
imie Klient.imie%type; nazwisko Klient.nazwisko%type; iloscKlientow INT;
BEGIN
    SELECT COUNT(*) INTO iloscKlientow FROM Klient k 
    INNER JOIN Adres a ON k.id_adres = a.id_adres
    WHERE miasto = nazwaMiasta;
    dbms_output.put_line('Ilosc klientow z podanego miasta: ' || iloscKlientow);
    OPEN adresy_z_miasta;
    LOOP
        FETCH adresy_z_miasta INTO adresID;
        EXIT WHEN adresy_z_miasta%NOTFOUND;
        DECLARE CURSOR klienci IS SELECT imie, nazwisko FROM Klient WHERE id_adres = adresID;
        BEGIN
            FOR klienci_rek IN klienci
            LOOP 
                dbms_output.put_line(klienci_rek.imie || ' ' || klienci_rek.nazwisko);
            END LOOP;
        END;
    END LOOP;
    CLOSE adresy_z_miasta;
END;

--test
SET SERVEROUTPUT ON
BEGIN
   showClients('WARSZAWA');
END;




