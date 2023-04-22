-------- INSERT INTO tables --------
INSERT INTO Napoj VALUES
(1, 'Fanta', 'Sladky napoj co osvezi', decode('48656C6C6F2C20776F726C6421', 'hex'), 'Toto je popis obrazku'),
(2, 'Cola', 'Kolovy napoj', decode('48656C6C6F2C20776F726C6421', 'hex'), 'Toto je popis obrazku'),
(3, 'Dobra voda', 'Voda z Dobrych hor', decode('48656C6C6F2C20776F726C6421', 'hex'), 'Toto je popis obrazku'),
(4, 'Pepsi', 'Kolovy napoj', decode('48656C6C6F2C20776F726C6421', 'hex'), 'Toto je popis obrazku');
CALL insert_dummy_data_into_napoj(32000);

INSERT INTO Kategorie VALUES
(1, 'Vino'),
(2, 'Limonady a energy'),
(3, 'Lihoviny'),
(4, 'Vody a mineralky'),
(5, 'Kava'),
(6, 'Dzusy a ovocne napoje'),
(7, 'Pivo'),
(8, 'Caj');
INSERT INTO Kategorie VALUES
(9, 'Bila', 1),
(10, 'Cervena', 1),
(11, 'Sumiva', 1),
(12, 'Kolove napoje', 2),
(13, 'Toniky', 2),
(14, 'Ledove caje', 2),
(15, 'Ledove kavy', 2),
(16, 'Vodka', 3),
(17, 'Whisky', 3),
(18, 'Gin', 3),
(19, 'Ochucene', 4),
(20, 'Neochucene', 4),
(21, 'Zrnkova', 5),
(22, 'Mleta', 5);

CALL assign_random_category_to_each_row_in_napoj();

INSERT INTO Dodavatel VALUES
('jan.novotny@gmail.com', '123456789', 'CZ123456789', 'abcdefg'),
('obchod@dobravoda.cz', '987654321', 'CZ987654321', 'ab4d1fg'),
('ivan.dlouhy@seznam.cz', '157214332', 'CZ157234232', 'hge32ha'),
('vladimir.novak@gmail.com', '232121432', 'CZ321254652', 'hgt3hb2'),
('business@voda.cz', '783564887', 'CZ234534212', 'jhu9uww'),
('tym@napoje.cz', '453423332', 'CZ763829332', 'unls242'),
('dodavatel@sladkenapoje.cz', '890900023', 'CZ000783722', 'jhg32gs');

INSERT INTO Telefon VALUES
('jan.novotny@gmail.com', 123456789),
('jan.novotny@gmail.com', 321321321),
('business@voda.cz', 222111333),
('business@voda.cz', 232434565),
('tym@napoje.cz', 777333777),
('dodavatel@sladkenapoje.cz', 123123123);

INSERT INTO PravnickaOsoba VALUES
('obchod@dobravoda.cz', 'Dobra Voda s.r.o.'),
('business@voda.cz', 'Voda s.r.o.'),
('tym@napoje.cz', 'Napoje s.r.o.'),
('dodavatel@sladkenapoje.cz', 'Sladke napoje s.r.o.');

INSERT INTO FyzickaOsoba VALUES
('jan.novotny@gmail.com', 'Jan', 'Novotny'),
('ivan.dlouhy@seznam.cz', 'Ivan', 'Dlouhy'),
('vladimir.novak@gmail.com', 'Vladimir', 'Novak');

INSERT INTO Dodavani VALUES
('business@voda.cz', 1),
('business@voda.cz', 5),
('tym@napoje.cz', 2),
('tym@napoje.cz', 1),
('obchod@dobravoda.cz', 1),
('obchod@dobravoda.cz', 3),
('obchod@dobravoda.cz', 4),
('obchod@dobravoda.cz', 5),
('obchod@dobravoda.cz', 6),
('obchod@dobravoda.cz', 7),
('dodavatel@sladkenapoje.cz', 1),
('dodavatel@sladkenapoje.cz', 2),
('dodavatel@sladkenapoje.cz', 3),
('dodavatel@sladkenapoje.cz', 4),
('dodavatel@sladkenapoje.cz', 10),
('dodavatel@sladkenapoje.cz', 11),
('ivan.dlouhy@seznam.cz', 2),
('ivan.dlouhy@seznam.cz', 3),
('ivan.dlouhy@seznam.cz', 7),
('ivan.dlouhy@seznam.cz', 8),
('ivan.dlouhy@seznam.cz', 9),
('ivan.dlouhy@seznam.cz', 10),
('jan.novotny@gmail.com', 1),
('jan.novotny@gmail.com', 2),
('jan.novotny@gmail.com', 5),
('jan.novotny@gmail.com', 6),
('jan.novotny@gmail.com', 7),
('jan.novotny@gmail.com', 15),
('jan.novotny@gmail.com', 16),
('jan.novotny@gmail.com', 17),
('jan.novotny@gmail.com', 18);

INSERT INTO Sklad VALUES
('PAR1', 'Pardubice'),
('PRA1', 'Praha'),
('PRA2', 'Praha'),
('BRN1', 'Brno');

INSERT INTO Skladovani VALUES
(1, 'PAR1', 10),
(1, 'PRA1', 20),
(1, 'PRA2', 30),
(1, 'BRN1', 50),
(2, 'PRA1', 30),
(2, 'PRA2', 40),
(3, 'PRA1', 10),
(4, 'PRA1', 14),
(4, 'BRN1', 2),
(5, 'BRN1', 10),
(6, 'PRA1', 14),
(7, 'BRN1', 12),
(8, 'PAR1', 175),
(9, 'BRN1', 121),
(10, 'PAR1', 6),
(10, 'PRA1', 12),
(10, 'PRA2', 1345),
(10, 'BRN1', 153),
(11, 'PAR1', 17),
(11, 'PRA1', 11),
(11, 'PRA2', 102),
(11, 'BRN1', 14);

INSERT INTO Zamestnanec VALUES
(1, 'PAR1', 'Sasa', 'Novakova', '930415/7166', 'Pardubice', 'U Smrku', 123),
(2, 'PAR1', 'Ivana', 'Lupinkova', '840603/7199', 'Hradec', 'Hlavni', 21),
(3, 'PRA1', 'Alzbeta', 'Presmyslova', '880904/7219', 'Praha', 'Albertova', 211),
(4, 'PRA2', 'Eva', 'Dolejsi', '770726/1151', 'Praha', 'Letnanska', 22),
(5, 'PAR1', 'Marie', 'Horejsi', '790226/7433', 'Praha', 'Vedlejsi', 1223),
(6, 'PRA1', 'Ivan', 'Dolnik', '890423/8406', 'Praha', 'Na Hromade', 2),
(7, 'PRA1', 'Jan', 'Morava', '890423/8406', 'Praha', 'Matejova', 3),
(8, 'PRA1', 'Jan', 'Parizan', '910225/7426', 'Brandys nad Labem', 'Lukasova', 13),
(9, 'PRA1', 'Lukas', 'Rychly', '800722/8436', 'Praha', 'Hradni', 2),
(10, 'PRA1', 'Tomas', 'Pomaly', '861109/8026', 'Mnisek pod Brdy', 'Konska', 1323),
(11, 'PRA2', 'Jakub', 'Nestihal', '850615/7446', 'Praha', 'Pstrosi', 2223),
(12, 'PRA2', 'Jakub', 'Nedobehl', '790715/8066', 'Praha', 'Pampeliskova', 1023),
(13, 'PRA2', 'Jaroslav', 'Vykoristil', '870708/7266', 'Praha', 'Golemova', 45),
(14, 'PRA2', 'Radek', 'Strelec', '880627/7076', 'Praha', 'Brandyska', 65),
(15, 'BRN1', 'Simon', 'Rak', '920416/8426', 'Brno', 'Flanelova', 76),
(16, 'BRN1', 'Vaclav', 'Mrak', '830928/8006', 'Ostrava', 'Tylova', 89),
(17, 'BRN1', 'Matej', 'Skocdopole', '890201/7046', 'Brno', 'Kulata', 90),
(18, 'BRN1', 'Frantisek', 'Josef', '810123/7256', 'Ostrava', 'U Ruzku', 1),
(19, 'BRN1', 'Anton', 'Novotny', '810123/3256', 'Ostrava', 'Na Ruzku', 100),
(20, 'BRN1', 'Zikmund', 'Novotny', '810123/7246', 'Ostrava', 'Na Ruzku', 100),
(21, 'BRN1', 'Jan', 'Novotny', '810123/7226', 'Ostrava', 'Na Ruzku', 100);