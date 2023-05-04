DROP VIEW IF EXISTS dodavatele;
DROP VIEW IF EXISTS pocetZamestnancu;

-------- VIEWS --------
-- vytvori pohled "dodavatele", ktery vybere vsechny dodavatele (tj. pravnicke a fyzicke osoby)
CREATE VIEW dodavatele AS
SELECT d.email, p.nazev, f.jmeno, f.prijmeni FROM Dodavatel d
FULL JOIN PravnickaOsoba p on d.email = p.email
FULL JOIN FyzickaOsoba f on d.email = f.email
ORDER BY d.email;

-- vybere vse z pohledu "dodavatele"
SELECT * FROM dodavatele;

-- vytvori pohled "pocetZamestnancu", ktery spocita pocet zamestnancu pracujici v danem skladu
CREATE VIEW pocetZamestnancu AS
SELECT nazev, count(*) FROM Zamestnanec
GROUP BY nazev;

-- vybere vse z pohledu "pocetZamestnancu"
SELECT * FROM pocetZamestnancu;
