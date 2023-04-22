-------- DROP tables --------
DROP TABLE IF EXISTS Napoj CASCADE;
DROP TABLE IF EXISTS Kategorie CASCADE;
DROP TABLE IF EXISTS Rozrazeni;
DROP TABLE IF EXISTS Dodavatel CASCADE;
DROP TABLE IF EXISTS Telefon;
DROP TABLE IF EXISTS PravnickaOsoba;
DROP TABLE IF EXISTS FyzickaOsoba;
DROP TABLE IF EXISTS Dodavani;
DROP TABLE IF EXISTS Sklad CASCADE;
DROP TABLE IF EXISTS Skladovani;
DROP TABLE IF EXISTS Zamestnanec;


-------- DROP procedures --------
DROP PROCEDURE IF EXISTS insert_dummy_data_into_napoj;
DROP PROCEDURE IF EXISTS assign_random_category_to_each_row_in_napoj();