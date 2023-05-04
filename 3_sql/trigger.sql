DROP TABLE IF EXISTS notifikace;
DROP FUNCTION IF EXISTS nedostatek_zasob CASCADE;
DROP TRIGGER IF EXISTS kontrola_zasob ON skladovani;

-------- TRIGGERS --------
-- vytvori tabulku "notifikace", ktera bude obsahovat textove notifikace o poctu napoju na skladu
CREATE TABLE IF NOT EXISTS Notifikace (
    datum TIMESTAMP DEFAULT now(),
    text VARCHAR(500),
    PRIMARY KEY (datum, text)
);

-- vytvori funkci "nedostatek_zasob", ktera vytvori zpravu v tabulce "notifikace" pokud pocet kusu napoje klesl pod stanovenou hranici
CREATE FUNCTION nedostatek_zasob() RETURNS TRIGGER AS $$
DECLARE
  pocet_kusu INTEGER;
  nazev_napoje VARCHAR(300);
BEGIN
  -- zjisti pocet kusu napoje na skladu
  pocet_kusu := (SELECT pocetKusu FROM Skladovani WHERE nazev = NEW.nazev AND kod = NEW.kod);

  -- pokud pocet kusu napoje klesl pod urcitou hranici, vytvori se notifikace
  IF pocet_kusu < 5 THEN
    -- zjisti nazev napoje
    nazev_napoje := (SELECT nazev FROM Napoj WHERE kod = NEW.kod);
    -- zapise zpravu do tabulky notifikace
    INSERT INTO Notifikace (text) VALUES ('Nedostatek zasob napoje "' || nazev_napoje || '" na sklade ' || NEW.nazev || '. Zbyvajici pocet kusu: ' || pocet_kusu);
  END IF;

  RETURN NEW;
END; $$ LANGUAGE plpgsql;

-- vytvori trigger "kontorola_zasob" spusteny vzdy po aktualizaci tabulky skladovani
CREATE TRIGGER kontrola_zasob
  AFTER UPDATE ON Skladovani
  FOR EACH ROW
  EXECUTE FUNCTION nedostatek_zasob();

-- ukazka zavolani triggeru
DELETE FROM skladovani WHERE (kod = 1) AND (nazev = 'BRN1');
INSERT INTO skladovani VALUES (1, 'BRN1', 120);
UPDATE skladovani SET pocetkusu = 3 WHERE kod = 1 AND nazev = 'BRN1'; -- spusti se trigger "kontrola_zasob"
