-------- SELECT FROM tables --------
-- vybere vsechny dodavatele (pravnicke a fyzicke osoby)
SELECT d.email, p.nazev, f.jmeno, f.prijmeni FROM Dodavatel d
FULL JOIN PravnickaOsoba p on d.email = p.email
FULL JOIN FyzickaOsoba f on d.email = f.email
ORDER BY p.nazev;

-- vybere vsechny pravnicke a fyzicke osoby, ktere dodavaji kolu
SELECT n.nazev, p.nazev, f.jmeno, f.prijmeni FROM Napoj n
INNER JOIN Dodavani d on (n.kod = d.kod)
FULL JOIN PravnickaOsoba p on (d.email = p.email)
FULL JOIN FyzickaOsoba f on (d.email = f.email)
WHERE (n.nazev = 'Cola');

-- vybere vsechny pravnicke osoby, ktere dodavaji kolu
SELECT n.nazev, p.nazev FROM Napoj n
INNER JOIN Dodavani d on (n.kod = d.kod)
INNER JOIN PravnickaOsoba p on (d.email = p.email)
WHERE (n.nazev = 'Cola');

-- vybere vsechny fyzicke osoby, ktere dodavaji kolu
SELECT n.nazev, f.jmeno, f.prijmeni FROM Napoj n
INNER JOIN Dodavani d on (n.kod = d.kod)
INNER JOIN FyzickaOsoba f on (d.email = f.email)
WHERE (n.nazev = 'Cola');

-- spocita pocet zamestnancu pracujici ve skladu
SELECT nazev, count(*) FROM Zamestnanec
GROUP BY nazev;

-- vybere sklady s peti a vice zamestnanci
SELECT nazev, count(*) FROM Zamestnanec
GROUP BY nazev
HAVING (COUNT(*) > 5);

-- spocita prumeny pocet zamestnancu pracujich ve jednom skladu
SELECT AVG(num_employees)
FROM (
  SELECT nazev, COUNT(*) AS num_employees
  FROM Zamestnanec
  GROUP BY nazev
) AS sklad_employee_count;

-- vybere deset zamestnancu (s offsetem 5) serazenych dle prijmeni a jmena
SELECT prijmeni, jmeno FROM Zamestnanec ORDER BY (prijmeni, jmeno) OFFSET 5 LIMIT 10;

-- vybere vsechny dodavatele, kteri dodavaji kolu a fantu zaroven
SELECT p.nazev, f.jmeno, f.prijmeni FROM Napoj n
INNER JOIN Dodavani d on (n.kod = d.kod)
FULL JOIN PravnickaOsoba p on (d.email = p.email)
FULL JOIN FyzickaOsoba f on (d.email = f.email)
WHERE (n.nazev = 'Cola')
INTERSECT
SELECT p.nazev, f.jmeno, f.prijmeni FROM Napoj n
INNER JOIN Dodavani d on (n.kod = d.kod)
FULL JOIN PravnickaOsoba p on (d.email = p.email)
FULL JOIN FyzickaOsoba f on (d.email = f.email)
WHERE (n.nazev = 'Fanta');

-- vybere vsechny dodavatele, kteri dodavaji kolu nebo fantu
SELECT p.nazev, f.jmeno, f.prijmeni FROM Napoj n
INNER JOIN Dodavani d on (n.kod = d.kod)
FULL JOIN PravnickaOsoba p on (d.email = p.email)
FULL JOIN FyzickaOsoba f on (d.email = f.email)
WHERE (n.nazev = 'Cola')
UNION
SELECT p.nazev, f.jmeno, f.prijmeni FROM Napoj n
INNER JOIN Dodavani d on (n.kod = d.kod)
FULL JOIN PravnickaOsoba p on (d.email = p.email)
FULL JOIN FyzickaOsoba f on (d.email = f.email)
WHERE (n.nazev = 'Fanta');

-- vybere vsechny zamestnance, kteri pracuji ve skladu, kde je zamestnano mene nez sest lidi
SELECT nazev, prijmeni, jmeno FROM Zamestnanec
WHERE nazev IN (
    SELECT nazev FROM Zamestnanec z
    GROUP BY nazev
    HAVING (count(*) < 6)
) ORDER BY nazev;