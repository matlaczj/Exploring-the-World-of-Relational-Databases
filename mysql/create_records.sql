INSERT INTO konto
    (login, email, haslo, dane_bankowe, srodki)
VALUES
    ('gamerX', 'gamerX@gmail.com', 'P@ssw0rd', '12345678901234567890123456', 200),
    ('adventureSeeker', 'adventurer@example.com', 'Adventure123', '23456789012345678901234567', 150),
    ('techMaster', 'techguru@gmail.com', 'Techie@123', '34567890123456789012345678', 180),
    ('musicLover', 'musicfan@example.com', 'Melody123', '45678901234567890123456789', 220),
    ('bookworm', 'booklover@gmail.com', 'ReadBooks1', '56789012345678901234567890', 250),
    ('fitnessFanatic', 'gymlover@example.com', 'FitLife2022', '67890123456789012345678901', 190),
    ('foodie', 'foodlover@gmail.com', 'YummyFood123', '78901234567890123456789012', 230),
    ('traveler', 'wanderlust@example.com', 'ExploreWorld1', '89012345678901234567890123', 270),
    ('artEnthusiast', 'artlover@gmail.com', 'Artistic@123', '90123456789012345678901234', 210),
    ('natureLover', 'natureenthusiast@example.com', 'Nature2022', '12345678901234567890123456', 240),
    ('gameMaster', 'mastergamer@gmail.com', 'GameOn123', '11112222333344445555666677', 180),
    ('puzzleSolver', 'puzzlelover@example.com', 'Puzzler2022', '22223333444455556666777788', 210),
    ('racingChampion', 'speedracer@gmail.com', 'NeedSpeed!', '33334444555566667777888899', 240),
    ('strategyGuru', 'strategist@example.com', 'ChessMaster1', '44445555666677778888999900', 260),
    ('triviaExpert', 'quizlover@gmail.com', 'QuizTime123', '55556666777788889999000011', 200),
    ('wordsmith', 'wordlover@example.com', 'WordGame2022', '66667777888899990000111122', 230),
    ('shooterPro', 'shootingstar@gmail.com', 'Headshot123', '77778888999900001111222233', 250),
    ('rolePlayer', 'rpgfanatic@example.com', 'RPGMaster!', '88889999000011112222333344', 220),
    ('cardPlayer', 'cardgamelover@gmail.com', 'CardKing123', '99990000111122223333444455', 260),
    ('arcadeFan', 'arcadegamer@example.com', 'HighScore1', '00001111222233334444555566', 180);

INSERT INTO wiadomosc
    (nadawca, odbiorca, tresc, data, status)
VALUES
    ('gamerX', 'adventureSeeker', 'Hey there! Ready for a gaming adventure?', '2023-10-27 15:30:00', 1),
    ('adventureSeeker', 'techMaster', 'Sure am! What game are we playing today?', '2023-10-28 16:45:00', 1),
    ('techMaster', 'gamerX', 'How about trying out the latest tech game?', '2023-10-29 17:50:00', 0),
    ('musicLover', 'bookworm', 'Have you read any good books lately?', '2023-10-30 18:25:00', 1),
    ('bookworm', 'fitnessFanatic', 'Need book recommendations while working out?', '2023-10-31 19:15:00', 0),
    ('fitnessFanatic', 'foodie', 'Any healthy recipes for my fitness journey?', '2023-11-01 20:00:00', 1),
    ('foodie', 'traveler', 'Found a great recipe from my travels!', '2023-11-02 21:30:00', 0),
    ('traveler', 'artEnthusiast', 'Visited a museum with amazing artworks!', '2023-11-03 22:15:00', 1),
    ('artEnthusiast', 'natureLover', 'Nature-inspired art can be so captivating.', '2023-11-04 23:00:00', 0),
    ('natureLover', 'gamerX', 'Ever tried gaming in the midst of nature?', '2023-11-05 23:45:00', 1),
    ('gameMaster', 'puzzleSolver', 'Any favorite puzzle games?', '2023-11-06 10:30:00', 1),
    ('puzzleSolver', 'racingChampion', 'Got any racing tips?', '2023-11-07 11:45:00', 1),
    ('racingChampion', 'strategyGuru', 'Lets plan a strategy for the next race.', '2023-11-08 12:50:00', 0),
    ('strategyGuru', 'triviaExpert', 'Want to join a trivia competition?', '2023-11-09 13:25:00', 1),
    ('triviaExpert', 'wordsmith', 'Whats your favorite word game?', '2023-11-10 14:15:00', 0),
    ('wordsmith', 'shooterPro', 'Discussing the latest shooting techniques.', '2023-11-11 15:00:00', 1),
    ('shooterPro', 'rolePlayer', 'Role-playing games discussion?', '2023-11-12 16:30:00', 0),
    ('rolePlayer', 'cardPlayer', 'Fancy a card game duel?', '2023-11-13 17:15:00', 1),
    ('cardPlayer', 'arcadeFan', 'High scores in arcade games?', '2023-11-14 18:15:00', 0),
    ('arcadeFan', 'gameMaster', 'Favorite arcade game?', '2023-11-15 19:00:00', 1);

INSERT INTO doladowanie
    (kwota, data, login)
VALUES
    (50, '2023-10-27 10:00:00', 'gamerX'),
    (70, '2023-10-28 11:30:00', 'adventureSeeker'),
    (90, '2023-10-29 13:45:00', 'techMaster'),
    (60, '2023-10-30 14:20:00', 'musicLover'),
    (80, '2023-10-31 15:10:00', 'bookworm'),
    (65, '2023-11-01 16:45:00', 'fitnessFanatic'),
    (75, '2023-11-02 18:30:00', 'foodie'),
    (85, '2023-11-03 20:15:00', 'traveler'),
    (55, '2023-11-04 22:00:00', 'artEnthusiast'),
    (95, '2023-11-05 23:45:00', 'natureLover'),
    (45, '2023-11-06 09:00:00', 'gameMaster'),
    (62, '2023-11-07 10:30:00', 'puzzleSolver'),
    (78, '2023-11-08 11:45:00', 'racingChampion'),
    (55, '2023-11-09 12:20:00', 'strategyGuru'),
    (67, '2023-11-10 13:10:00', 'triviaExpert'),
    (72, '2023-11-11 14:35:00', 'wordsmith'),
    (86, '2023-11-12 15:20:00', 'shooterPro'),
    (91, '2023-11-13 16:15:00', 'rolePlayer'),
    (60, '2023-11-14 17:10:00', 'cardPlayer'),
    (95, '2023-11-15 18:05:00', 'arcadeFan');

INSERT INTO srodowisko
    (nazwa_gry, ilosc_botow)
VALUES
    ('GameWorld 1', 50),
    ('AdventureQuest', 30),
    ('TechUniverse', 20),
    ('MusicMasters', 40),
    ('BookLand', 60),
    ('FitnessFrenzy', 45),
    ('FoodFantasia', 55),
    ('TravelTales', 35),
    ('ArtisticRealm', 25),
    ('NatureNirvana', 70),
    ('MazeRunner', 25),
    ('QuestWorld', 18),
    ('TechHaven', 30),
    ('MelodyMasters', 22),
    ('BookwormsLand', 35),
    ('GymGalaxy', 28),
    ('FoodFiesta', 40),
    ('WanderWorld', 20),
    ('ArtistsRealm', 15),
    ('NatureWonders', 50);

INSERT INTO bot
    (ranga, param, cechy, nazwa_gry, mecz)
VALUES
    (10, 'param1', 'cechy1', 'GameWorld 1', NULL),
    (15, 'param2', 'cechy2', 'AdventureQuest', NULL),
    (20, 'param3', 'cechy3', 'TechUniverse', NULL),
    (25, 'param4', 'cechy4', 'MusicMasters', NULL),
    (30, 'param5', 'cechy5', 'BookLand', NULL),
    (35, 'param6', 'cechy6', 'FitnessFrenzy', NULL),
    (40, 'param7', 'cechy7', 'FoodFantasia', NULL),
    (45, 'param8', 'cechy8', 'TravelTales', NULL),
    (50, 'param9', 'cechy9', 'ArtisticRealm', NULL),
    (55, 'param10', 'cechy10', 'NatureNirvana', NULL),
    (8, 'param11', 'cechy11', 'MazeRunner', NULL),
    (14, 'param12', 'cechy12', 'QuestWorld', NULL),
    (18, 'param13', 'cechy13', 'TechHaven', NULL),
    (22, 'param14', 'cechy14', 'MelodyMasters', NULL),
    (26, 'param15', 'cechy15', 'BookwormsLand', NULL),
    (30, 'param16', 'cechy16', 'GymGalaxy', NULL),
    (34, 'param17', 'cechy17', 'FoodFiesta', NULL),
    (38, 'param18', 'cechy18', 'WanderWorld', NULL),
    (42, 'param19', 'cechy19', 'ArtistsRealm', NULL),
    (46, 'param20', 'cechy20', 'NatureWonders', NULL);

INSERT INTO mecz
    (wygrany_1, wygrany_2, wynik, status, nazwa_gry)
VALUES
    (1, 2, 3, 1, 'GameWorld 1'),
    (3, 4, 2, 0, 'AdventureQuest'),
    (5, 2, 1, 1, 'TechUniverse'),
    (4, 1, 4, 0, 'MusicMasters'),
    (2, 3, 2, 1, 'BookLand'),
    (6, 7, 3, 1, 'FitnessFrenzy'),
    (8, 9, 1, 0, 'FoodFantasia'),
    (9, 5, 2, 1, 'TravelTales'),
    (7, 1, 3, 1, 'ArtisticRealm'),
    (9, 5, 4, 0, 'NatureNirvana'),
    (1, 2, 3, 1, 'MazeRunner'),
    (3, 4, 2, 0, 'QuestWorld'),
    (5, 2, 1, 1, 'TechHaven'),
    (4, 1, 4, 0, 'MelodyMasters'),
    (2, 3, 2, 1, 'BookwormsLand'),
    (6, 7, 3, 1, 'GymGalaxy'),
    (8, 9, 1, 0, 'FoodFiesta'),
    (9, 5, 2, 1, 'WanderWorld'),
    (7, 1, 3, 1, 'ArtistsRealm'),
    (9, 5, 4, 0, 'NatureWonders');

UPDATE bot
SET mecz = 
    CASE
        WHEN id = 0 THEN 0
        WHEN id = 1 THEN 1
        WHEN id = 2 THEN 2
        WHEN id = 3 THEN 3
        WHEN id = 4 THEN 4
        WHEN id = 5 THEN 5
        WHEN id = 6 THEN 6
        WHEN id = 7 THEN 7
        WHEN id = 8 THEN 8
        WHEN id = 9 THEN 9
        WHEN id = 10 THEN 10
        WHEN id = 11 THEN 11
        WHEN id = 12 THEN 12
        WHEN id = 13 THEN 13
        WHEN id = 14 THEN 14
        WHEN id = 15 THEN 15
        WHEN id = 16 THEN 16
        WHEN id = 17 THEN 17
        WHEN id = 18 THEN 18
        WHEN id = 19 THEN 19
        ELSE NULL END;

INSERT INTO wynajem
    (status, kwota, czas_trwania, data, login, bot)
VALUES
    (1, 50, 120, '2023-10-27 10:00:00', 'gamerX', 1),
    (1, 70, 180, '2023-10-28 12:30:00', 'adventureSeeker', 2),
    (0, 90, 150, '2023-10-29 14:45:00', 'techMaster', 3),
    (1, 60, 90, '2023-10-30 16:20:00', 'musicLover', 4),
    (0, 80, 200, '2023-10-31 18:10:00', 'bookworm', 5),
    (1, 65, 110, '2023-11-01 19:45:00', 'fitnessFanatic', 6),
    (1, 75, 160, '2023-11-02 21:30:00', 'foodie', 7),
    (0, 85, 130, '2023-11-03 23:15:00', 'traveler', 8),
    (1, 55, 170, '2023-11-04 01:00:00', 'artEnthusiast', 9),
    (0, 95, 140, '2023-11-05 03:45:00', 'natureLover', 20),
    (1, 50, 120, '2023-11-06 10:00:00', 'gameMaster', 11),
    (1, 70, 180, '2023-11-07 12:30:00', 'puzzleSolver', 12),
    (0, 90, 150, '2023-11-08 14:45:00', 'racingChampion', 13),
    (1, 60, 90, '2023-11-09 16:20:00', 'strategyGuru', 14),
    (0, 80, 200, '2023-11-10 18:10:00', 'triviaExpert', 15),
    (1, 65, 110, '2023-11-11 19:45:00', 'wordsmith', 16),
    (1, 75, 160, '2023-11-12 21:30:00', 'shooterPro', 17),
    (0, 85, 130, '2023-11-13 23:15:00', 'rolePlayer', 18),
    (1, 55, 170, '2023-11-14 01:00:00', 'cardPlayer', 19),
    (0, 95, 140, '2023-11-15 03:45:00', 'arcadeFan', 10);

INSERT INTO recenzja
    (ocena, komentarz, data, login, bot)
VALUES
    (4, 'Enjoyed the game, but needs more challenges.', '2023-10-27 15:00:00', 'gamerX', 1),
    (5, 'Absolutely fantastic! Best gaming experience ever.', '2023-10-28 16:30:00', 'adventureSeeker', 2),
    (3, 'Good graphics, but the gameplay could be better.', '2023-10-29 17:45:00', 'techMaster', 3),
    (4, 'Fun game to play with friends.', '2023-10-30 18:20:00', 'musicLover', 4),
    (5, 'Incredible storyline and character development.', '2023-10-31 19:10:00', 'bookworm', 5),
    (3, 'Lacks originality, but still enjoyable.', '2023-11-01 20:30:00', 'fitnessFanatic', 6),
    (4, 'Great variety of food options and recipes.', '2023-11-02 21:45:00', 'foodie', 7),
    (5, 'Breathtaking locations and immersive experience.', '2023-11-03 22:15:00', 'traveler', 8),
    (4, 'Unique art styles and creative designs.', '2023-11-04 23:30:00', 'artEnthusiast', 9),
    (5, 'A relaxing game with beautiful nature scenes.', '2023-11-05 23:45:00', 'natureLover', 20),
    (4, 'Amazing puzzles! Challenging and fun.', '2023-11-06 10:30:00', 'gameMaster', 11),
    (5, 'Love the racing tracks and graphics!', '2023-11-07 11:45:00', 'puzzleSolver', 12),
    (3, 'TechHaven needs more gameplay variety.', '2023-11-08 12:50:00', 'racingChampion', 13),
    (4, 'Great strategy game with complex mechanics.', '2023-11-09 13:25:00', 'strategyGuru', 14),
    (5, 'Trivia questions are well-crafted and interesting.', '2023-11-10 14:15:00', 'triviaExpert', 15),
    (3, 'Word games are addictive but need more levels.', '2023-11-11 15:00:00', 'wordsmith', 16),
    (4, 'Fantastic shooting game with excellent controls.', '2023-11-12 16:30:00', 'shooterPro', 17),
    (5, 'Immersive role-playing experience!', '2023-11-13 17:45:00', 'rolePlayer', 18),
    (4, 'Card battles are strategic and enjoyable.', '2023-11-14 18:20:00', 'cardPlayer', 19),
    (5, 'ArcadeFan is a perfect collection of classic games.', '2023-11-15 19:10:00', 'arcadeFan', 10);

INSERT INTO przedmiot
    (nazwa_przedmiotu, jakosc, nazwa_os)
VALUES
    ('Sword of Valor', 90, 'First Victory'),
    ('Explorers Map', 85, 'Explorer'),
    ('Tech Gadgets Kit', 88, 'Tech Guru'),
    ('Melody Maker', 92, 'Music Maestro'),
    ('Bookworms Collection', 89, 'Bookworm'),
    ('Fitness Tracker', 87, 'Fitness Enthusiast'),
    ('Gourmet Cookbook', 91, 'Food Connoisseur'),
    ('Travel Journal', 86, 'Wanderlust'),
    ('Artistic Brush Set', 93, 'Art Aficionado'),
    ('Nature Explorer Kit', 94, 'Nature Lover');

INSERT INTO osiagniecie
    (przedmiot, czas_os, login, bot)
VALUES
    (10, '2023-10-27 12:00:00', 'gamerX', 1),
    (1, '2023-10-28 14:30:00', 'adventureSeeker', 2),
    (2, '2023-10-29 15:45:00', 'techMaster', 3),
    (3, '2023-10-30 10:20:00', 'musicLover', 4),
    (4, '2023-10-31 09:10:00', 'bookworm', 5),
    (5, '2023-11-01 17:30:00', 'fitnessFanatic', 6),
    (6, '2023-11-02 18:45:00', 'foodie', 7),
    (7, '2023-11-03 22:15:00', 'traveler', 8),
    (8, '2023-11-04 14:20:00', 'artEnthusiast', 9),
    (9, '2023-11-05 12:45:00', 'natureLover', 10);
