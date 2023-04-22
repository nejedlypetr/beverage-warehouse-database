-------- CREATE tables --------
CREATE TABLE IF NOT EXISTS Napoj (
    kod INT PRIMARY KEY,
    nazev VARCHAR(50) NOT NULL,
    popis VARCHAR(300) NOT NULL,
    fotka BYTEA,
    fotkaPopis VARCHAR(50)
    CONSTRAINT fotka_fotkaPopis_check CHECK (
        ((fotka IS NULL) and (fotkaPopis IS NULL))
        OR
        ((fotka IS NOT NULL) and (fotkaPopis IS NOT NULL))
    )
);

CREATE TABLE IF NOT EXISTS Kategorie (
    kod INT PRIMARY KEY,
    nazev VARCHAR(50) NOT NULL,
    kodNadkategorie INT,
    CONSTRAINT kodNadkategorie_fk FOREIGN KEY (kodNadkategorie) REFERENCES Kategorie(kod) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Rozrazeni (
    kodNapoj INT NOT NULL,
    kodKategorie INT NOT NULL,
    PRIMARY KEY (kodNapoj, kodKategorie),
    CONSTRAINT kodNapoj_fk FOREIGN KEY (kodNapoj) REFERENCES Napoj(kod) ON DELETE CASCADE,
    CONSTRAINT kodKategorie_fk FOREIGN KEY (kodKategorie) REFERENCES Kategorie(kod) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Dodavatel (
  email VARCHAR(255) PRIMARY KEY CHECK (email LIKE '_%@_%._%'),
  ico CHAR(9) UNIQUE NOT NULL CHECK (ico ~ '\d{9}'),
  dic CHAR(11) UNIQUE NOT NULL CHECK (dic ~ '^[A-Z]{2}\d{9}$'),
  idDatovaSchranka CHAR(7) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS Telefon (
  email VARCHAR(255) NOT NULL,
  telefon INT NOT NULL,
  PRIMARY KEY (email, telefon),
  CONSTRAINT email_fk FOREIGN KEY (email) REFERENCES Dodavatel(email) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS PravnickaOsoba (
  email VARCHAR(255) PRIMARY KEY,
  nazev VARCHAR(150) NOT NULL,
  CONSTRAINT email_fk FOREIGN KEY (email) REFERENCES Dodavatel(email) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS FyzickaOsoba (
  email VARCHAR(255) PRIMARY KEY,
  jmeno VARCHAR(150) NOT NULL,
  prijmeni VARCHAR(150) NOT NULL,
  CONSTRAINT email_fk FOREIGN KEY (email) REFERENCES Dodavatel(email) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Dodavani (
  email VARCHAR(255) NOT NULL,
  kod INT NOT NULL,
  PRIMARY KEY (email, kod),
  CONSTRAINT email_fk FOREIGN KEY (email) REFERENCES Dodavatel(email) ON DELETE RESTRICT,
  CONSTRAINT kod_fk FOREIGN KEY (kod) REFERENCES Napoj(kod) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Sklad (
    nazev VARCHAR(50) PRIMARY KEY,
    mesto VARCHAR(150) NOT NULL
);

CREATE TABLE IF NOT EXISTS Skladovani (
  kod INT NOT NULL,
  nazev VARCHAR(50) NOT NULL,
  pocetKusu INT NOT NULL CHECK (pocetKusu >= 0),
  PRIMARY KEY (kod, nazev),
  CONSTRAINT kod_fk FOREIGN KEY (kod) REFERENCES Napoj(kod) ON DELETE RESTRICT,
  CONSTRAINT nazev_fk FOREIGN KEY (nazev) REFERENCES Sklad(nazev) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Zamestnanec (
  id INT PRIMARY KEY,
  nazev VARCHAR(50) NOT NULL,
  jmeno VARCHAR(50) NOT NULL,
  prijmeni VARCHAR(100) NOT NULL,
  rodneCislo VARCHAR(11) NOT NULL CHECK (rodneCislo LIKE '______/____'),
  mesto VARCHAR(150) NOT NULL,
  ulice VARCHAR(50) NOT NULL,
  cisloPopisne INT NOT NULL,
  CONSTRAINT nazev_fk FOREIGN KEY (nazev) REFERENCES Sklad(nazev) ON DELETE RESTRICT,
  UNIQUE (prijmeni, rodneCislo, mesto, ulice, cisloPopisne)
);


-------- CREATE procedures --------
CREATE PROCEDURE insert_dummy_data_into_napoj(count int)
as $$
declare
    startIndex int;
    endIndex int;
begin
    startIndex := ((SELECT max(kod) FROM Napoj) + 1);
    if (startIndex is null) then
        startIndex := 1;
    end if;
    endIndex := (startIndex + count - 1);

   for i in startIndex..endIndex loop
    INSERT INTO Napoj VALUES (i, concat('Napoj ', i), 'Lorem ipsum');
   end loop;

end; $$
language plpgsql;

CREATE PROCEDURE assign_random_category_to_each_row_in_napoj()
as $$
declare
    totalCategories int;
    totalDrinks int;
    randomNumber int;
begin
    totalCategories := ((SELECT count(*) FROM Kategorie));
    totalDrinks := (SELECT count(*) FROM Napoj);

   for i in 1..totalDrinks loop
       randomNumber := (SELECT floor(random() * totalCategories) + 1);
       INSERT INTO Rozrazeni VALUES (i, randomNumber);
   end loop;

end; $$
language plpgsql;