## **CP2 - Relační model**

**Nápoj** (<u>kód</u>, název, popis, fotka, fotkaPopis)

**Kategorie** (<u>kód</u>, název, kódNadkategorie)<br>
FK: Kategorie.kódNadkategorie ⊆ Kategorie.kód
poznámka: když kódNadkategorie bude null, tak je daná kategorie hlavní a nemá žádnou nadkategorii

**Rozřazení** (<u>kódNápoj, kódKategorie</u>)<br>
FK: Rozřazení.kódNápoj ⊆ Nápoj.kód
FK: Rozřazení.kódKategorie ⊆ Kategorie.kód

**Dodavatel** (<u>email</u>, <u>IČO</u>, <u>DIČ</u>, <u>idSchránky</u>)

**Telefon** (<u>email, telefon</u>)<br>
FK: Telefon.email ⊆ Dodavatel.email

**PrávnickáOsoba** (<u>email</u>, název)<br>
FK: PrávnickáOsoba.email ⊆ Dodavatel.email

**FyzickáOsoba** (<u>email</u>, jméno, přijmení)<br>
FK: FyzickáOsoba.email ⊆ Dodavatel.email

**Dodávání** (<u>email, kód</u>)<br>
FK: Dodávání.email ⊆ Dodavatel.email
FK: Dodávání.kód ⊆ Nápoj.kód

**Sklad** (<u>název</u>, město)

**Skladování** (<u>kód, název</u>, počet)<br>
FK: Skladování.kód ⊆ Nápoj.kód
FK: Skladování.název ⊆ Sklad.název

**Zaměstnanec** (název, jméno, <u>přijmení, rodnéČíslo, město, ulice, čísloPopisné</u>)<br>
FK: Zaměstnanec.název ⊆ Sklad.název