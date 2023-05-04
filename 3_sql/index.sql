DROP INDEX IF EXISTS index_zamestnanec_prijmeni;
DROP INDEX IF EXISTS index_napoj_nazev;

-------- INDEXES --------
-- vytvori indexovani podle prijmeni zamestnance
-- index z logickeho hlediska dava smysl
-- protoze vyhledavani podle prijemni je nejcastejsi zpusob jak vyhledat urciteho zamestnance
-- avsak je otazkou jak casto by bylo potreba vyhledavat zamestnance ve skladovem systemu dle prijmeni
CREATE INDEX index_zamestnanec_prijmeni ON zamestnanec(prijmeni);
SELECT * FROM zamestnanec WHERE prijmeni = 'Novotny';

-- vytvori indexovani podle nazvu napoje
-- vyhledavani podle nazvu napoje se zda jako obvykly a rozumny zpusob vyhledani
-- a proto by mohl index urychlit vyhledani
CREATE INDEX index_napoj_nazev ON napoj(nazev);
SELECT * FROM napoj WHERE nazev = 'Fanta';