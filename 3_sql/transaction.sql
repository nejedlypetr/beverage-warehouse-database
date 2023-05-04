DROP PROCEDURE IF EXISTS presun_napoj_mezi_sklady;

-------- TRANSACTION --------
-- procedura, ktera presune urcity pocet kusu napoje z jednoho skladu do druheho skladu
CREATE PROCEDURE presun_napoj_mezi_sklady (
    napoj_kod INTEGER,
    zdrojovy_sklad VARCHAR(50),
    cilovy_sklad VARCHAR(50),
    pocet INTEGER
) AS $$
DECLARE
    zdrojovy_sklad_pocet_kusu INTEGER;
    cilovy_sklad_pocet_kusu INTEGER;
BEGIN
    LOCK TABLE skladovani IN ACCESS EXCLUSIVE MODE;

    zdrojovy_sklad_pocet_kusu := (SELECT pocetkusu FROM skladovani WHERE (nazev = zdrojovy_sklad) AND (kod = napoj_kod));

    -- pokud neni dostatecny pocet kusu na zdrojovem sklade, transakce selze
    IF (zdrojovy_sklad_pocet_kusu IS NULL) OR zdrojovy_sklad_pocet_kusu < pocet THEN
        RAISE EXCEPTION 'Nedostatecny pocet kusu na zdrojovem sklade.';
    END IF;

    cilovy_sklad_pocet_kusu := (SELECT pocetkusu FROM skladovani WHERE (nazev = cilovy_sklad) AND (kod = napoj_kod));

    -- aktualizace poctu kusu na zdrojovem skladu
    UPDATE Skladovani SET pocetkusu = (pocetkusu - pocet)
    WHERE (kod = napoj_kod) AND nazev = (zdrojovy_sklad);

    -- aktualizace poctu kusu na cilovem skladu
    IF (cilovy_sklad_pocet_kusu IS NULL) THEN
        INSERT INTO Skladovani (kod, nazev, pocetKusu)
        VALUES (napoj_kod, cilovy_sklad, pocet);
    ELSE
        UPDATE Skladovani SET pocetKusu = (pocetKusu + pocet)
        WHERE (kod = napoj_kod) AND (nazev = cilovy_sklad);
    END IF;

    COMMIT;
END; $$ LANGUAGE plpgsql;

-- pokud by nebylo pouzito osetrene transakce, tak by mohl vzniknout napr. nasledujici koflikt:
-- 1) Procedura si nacte pocet kusu napoje na cilovem skladu (napr. 10 ks)
-- 2) Jiny uzivatel chce nastavit pocet kusu stejneho napoje na 0, a tak smaze radek o poctu kusu napoje na cilovem skladu
-- 3) Procedura si mysli, ze radek o poctu kusu daneho napoje exituje (protoze si ho v kroku 1 nacetla), tak se rozhodne updatovat pocet kusu napoje na cilovem skladu, ale protoze nenajde zadny zaznam, tak se nic neaktualizuje

-- spusti transakci, ktera je jiz osetrena uvnitr tela procedury
CALL presun_napoj_mezi_sklady(10, 'PRA2', 'PRA1', 20);
