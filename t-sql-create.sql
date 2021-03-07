-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-01-20 15:55:23.636

-- tables
-- Table: Adres
CREATE TABLE Adres (
    id_adres int  NOT NULL,
    miasto varchar(800)  NOT NULL,
    ulica varchar(800)  NOT NULL,
    numer_budynku int  NOT NULL,
    numer_mieszkania int  NULL,
    CONSTRAINT Adres_pk PRIMARY KEY  (id_adres)
);

-- Table: Dostawca
CREATE TABLE Dostawca (
    id_dostawcy int  NOT NULL,
    nazwa varchar(800)  NOT NULL,
    CONSTRAINT Dostawca_pk PRIMARY KEY  (id_dostawcy)
);

-- Table: Klient
CREATE TABLE Klient (
    id_adres int  NOT NULL,
    id_klient int  NOT NULL,
    imie varchar(800)  NOT NULL,
    nazwisko varchar(800)  NOT NULL,
    adres_email varchar(800)  NOT NULL,
    CONSTRAINT Klient_pk PRIMARY KEY  (id_klient)
);

-- Table: Pracownik
CREATE TABLE Pracownik (
    id_pracownik int  NOT NULL,
    pensja int  NOT NULL,
    data_zatrudnienia date  NOT NULL,
    CONSTRAINT Pracownik_pk PRIMARY KEY  (id_pracownik)
);

-- Table: Produkt
CREATE TABLE Produkt (
    id_produkt int  NOT NULL,
    nazwa varchar(800)  NOT NULL,
    cena int  NOT NULL,
    id_typ_produktu int  NOT NULL,
    CONSTRAINT Produkt_pk PRIMARY KEY  (id_produkt)
);

-- Table: ProduktDostawca
CREATE TABLE ProduktDostawca (
    cena_hurtowa int  NOT NULL,
    id_produkt int  NOT NULL,
    id_dostawcy int  NOT NULL,
    CONSTRAINT ProduktDostawca_pk PRIMARY KEY  (id_produkt,id_dostawcy)
);

-- Table: Skladnik_zamowienia
CREATE TABLE Skladnik_zamowienia (
    id_produkt int  NOT NULL,
    id_zamowienia int  NOT NULL,
    ilosc int  NOT NULL,
    CONSTRAINT Skladnik_zamowienia_pk PRIMARY KEY  (id_produkt,id_zamowienia)
);

-- Table: Typ_produktu
CREATE TABLE Typ_produktu (
    id_typ_produktu int  NOT NULL,
    nazwa varchar(800)  NOT NULL,
    CONSTRAINT Typ_produktu_pk PRIMARY KEY  (id_typ_produktu)
);

-- Table: Zamowienie
CREATE TABLE Zamowienie (
    id_zamowienia int  NOT NULL,
    status varchar(800)  NOT NULL,
    data_zamowienia date  NOT NULL,
    id_klient int  NOT NULL,
    id_pracownik int  NOT NULL,
    CONSTRAINT Zamowienie_pk PRIMARY KEY  (id_zamowienia)
);

-- foreign keys
-- Reference: Klient_Adres (table: Klient)
ALTER TABLE Klient ADD CONSTRAINT Klient_Adres
    FOREIGN KEY (id_adres)
    REFERENCES Adres (id_adres);

-- Reference: Pracownik_Klient (table: Pracownik)
ALTER TABLE Pracownik ADD CONSTRAINT Pracownik_Klient
    FOREIGN KEY (id_pracownik)
    REFERENCES Klient (id_klient);

-- Reference: ProduktDostawca_Dostawca (table: ProduktDostawca)
ALTER TABLE ProduktDostawca ADD CONSTRAINT ProduktDostawca_Dostawca
    FOREIGN KEY (id_dostawcy)
    REFERENCES Dostawca (id_dostawcy);

-- Reference: ProduktDostawca_Produkt (table: ProduktDostawca)
ALTER TABLE ProduktDostawca ADD CONSTRAINT ProduktDostawca_Produkt
    FOREIGN KEY (id_produkt)
    REFERENCES Produkt (id_produkt);

-- Reference: Produkt_Typ_produktu (table: Produkt)
ALTER TABLE Produkt ADD CONSTRAINT Produkt_Typ_produktu
    FOREIGN KEY (id_typ_produktu)
    REFERENCES Typ_produktu (id_typ_produktu);

-- Reference: Zamowienie_Klient (table: Zamowienie)
ALTER TABLE Zamowienie ADD CONSTRAINT Zamowienie_Klient
    FOREIGN KEY (id_klient)
    REFERENCES Klient (id_klient);

-- Reference: Zamowienie_Pracownik (table: Zamowienie)
ALTER TABLE Zamowienie ADD CONSTRAINT Zamowienie_Pracownik
    FOREIGN KEY (id_pracownik)
    REFERENCES Pracownik (id_pracownik);

-- Reference: skladnik_zamowienia_Produkt (table: Skladnik_zamowienia)
ALTER TABLE Skladnik_zamowienia ADD CONSTRAINT skladnik_zamowienia_Produkt
    FOREIGN KEY (id_produkt)
    REFERENCES Produkt (id_produkt);

-- Reference: skladnik_zamowienia_Zamowienie (table: Skladnik_zamowienia)
ALTER TABLE Skladnik_zamowienia ADD CONSTRAINT skladnik_zamowienia_Zamowienie
    FOREIGN KEY (id_zamowienia)
    REFERENCES Zamowienie (id_zamowienia);

-- End of file.

