CREATE DATABASE IF NOT EXISTS `dashboard_sql`;
USE `dashboard_sql`;


-- CreateTable
CREATE TABLE IF NOT EXISTS `users` (
    id CHAR(36) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password TEXT NOT NULL
);

-- INSERT INTO `users` VALUES
-- ('410544b2-4001-4271-9855-fec4b6a6442a', 'User', 'user@nextmail.com', '$2b$10$rusWBzY36QUB9t./zVqp5.s8KgbnHrpP0XbCRhCAR1X7RDGKgJqGW')


-- CreateTable
CREATE TABLE IF NOT EXISTS `customers`(
    id CHAR(36) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    image_url VARCHAR(255) NOT NULL
);

-- INSERT INTO `customers` VALUES
-- ('3958dc9e-712f-4377-85e9-fec4b6a6442a', 'Delba de Oliveira', 'delba@oliveira.com', '/customers/delba-de-oliveira.png'),
-- ('3958dc9e-742f-4377-85e9-fec4b6a6442a', 'Lee Robinson', 'lee@robinson.com', '/customers/lee-robinson.png'),
-- ('3958dc9e-737f-4377-85e9-fec4b6a6442a', 'Hector Simpson', 'hector@simpson.com', '/customers/hector-simpson.png'),
-- ('50ca3e18-62cd-11ee-8c99-0242ac120002', 'Steven Tey', 'steven@tey.com', '/customers/steven-tey.png'),
-- ('3958dc9e-787f-4377-85e9-fec4b6a6442a', 'Steph Dietz', 'steph@dietz.com', '/customers/steph-dietz.png'),
-- ('76d65c26-f784-44a2-ac19-586678f7c2f2', 'Michael Novotny', 'michael@novotny.com', '/customers/michael-novotny.png'),
-- ('d6e15727-9fe1-4961-8c5b-ea44a9bd81aa', 'Evil Rabbit', 'evil@rabbit.com', '/customers/evil-rabbit.png'),
-- ('126eed9c-c90c-4ef6-a4a8-fcf7408d3c66', 'Emil Kowalski', 'emil@kowalski.com', '/customers/emil-kowalski.png'),
-- ('CC27C14A-0ACF-4F4A-A6C9-D45682C144B9', 'Amy Burns', 'amy@burns.com', '/customers/amy-burns.png'),
-- ('13D07535-C59E-4157-A011-F8D2EF4E0CBB', 'Balazs Orban', 'balazs@orban.com', '/customers/balazs-orban.png')


-- CreateTable
CREATE TABLE IF NOT EXISTS `invoices`(
    id CHAR(36) PRIMARY KEY,
    customer_id CHAR(36) NOT NULL,
    amount INTEGER NOT NULL,
    status VARCHAR(255) NOT NULL,
    date DATETIME NOT NULL
);

-- INSERT INTO `invoices` VALUES
-- ('bdd4a0df-6c9d-46a7-93bc-115faf04383f', '3958dc9e-712f-4377-85e9-fec4b6a6442a', 15795, 'pending', '2022-12-06'),
-- ('ae970b7c-6737-497c-bedc-ce01437e5a51', '3958dc9e-742f-4377-85e9-fec4b6a6442a', 20348, 'pending', '2022-11-14'),
-- ('81ab95f2-5670-4a47-b7ba-af111b780a59', '3958dc9e-787f-4377-85e9-fec4b6a6442a', 3040, 'paid', '2022-10-29'),
-- ('17029e84-241b-462c-b64b-bebc892c3f39', '50ca3e18-62cd-11ee-8c99-0242ac120002', 44800, 'paid', '2023-09-10'),
-- ('d0717539-5741-420c-bc49-5fd9b668cd86', '76d65c26-f784-44a2-ac19-586678f7c2f2', 34577, 'pending', '2023-08-05'),
-- ('294d8aff-06ec-43ed-a51c-32cb26d7251e', '126eed9c-c90c-4ef6-a4a8-fcf7408d3c66', 54246, 'pending', '2023-07-16'),
-- ('fa63e3fe-44e1-4adc-96ec-f5f71af67a0b', 'd6e15727-9fe1-4961-8c5b-ea44a9bd81aa', 667, 'pending', '2023-06-27'),
-- ('ebd4be0a-a8cf-4819-9225-32521ec7d0cc', '50ca3e18-62cd-11ee-8c99-0242ac120002', 32545, 'paid', '2023-06-09'),
-- ('9300db92-5afa-41f9-bb74-51a0679df0c5', '3958dc9e-787f-4377-85e9-fec4b6a6442a', 1250, 'paid', '2023-06-17'),
-- ('2b2bb76f-a95f-4ff4-951d-307ed2f10406', '76d65c26-f784-44a2-ac19-586678f7c2f2', 8546, 'paid', '2023-06-07'),
-- ('581214fe-ee36-47e0-bbf1-507a7ceb094b', '3958dc9e-742f-4377-85e9-fec4b6a6442a', 500, 'paid', '2023-08-19'),
-- ('0c42b52b-f129-4744-8b94-a6a5a713846d', '76d65c26-f784-44a2-ac19-586678f7c2f2', 8945, 'paid', '2023-06-03'),
-- ('fa9aaea7-a90e-4d97-925f-1ead8ef9eb51', '3958dc9e-737f-4377-85e9-fec4b6a6442a', 8945, 'paid', '2023-06-18'),
-- ('1923f51b-5841-4184-91bc-2eb1f275dcde', '3958dc9e-712f-4377-85e9-fec4b6a6442a', 8945, 'paid', '2023-10-04'),
-- ('fcaad949-cc62-4a9a-b698-d3a0b51ba130', '3958dc9e-737f-4377-85e9-fec4b6a6442a', 1000, 'paid', '2022-06-05')


-- CreateTable
CREATE TABLE IF NOT EXISTS `revenue`(
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    month VARCHAR(4) NOT NULL UNIQUE,
    revenue INTEGER NOT NULL
);

-- INSERT INTO `revenue` VALUES
-- (1, 'Jan', 2000 ),
-- (2, 'Feb', 1800 ),
-- (3, 'Mar', 2200 ),
-- (4, 'Apr', 2500 ),
-- (5, 'May', 2300 ),
-- (6, 'Jun', 3200 ),
-- (7, 'Jul', 3500 ),
-- (8, 'Aug', 3700 ),
-- (9, 'Sep', 2500 ),
-- (10, 'Oct', 2800 ),
-- (11, 'Nov', 3000 ),
-- (12, 'Dec', 4800 )