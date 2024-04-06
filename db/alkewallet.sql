CREATE DATABASE alke_wallet;
--
-- 
-- Se normalizo la tabla para que todos los datos esten en ingles sin caracteres especiales.
CREATE TABLE users (
    user_id INT PRIMARY KEY NOT NULL,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    balance DECIMAL(10, 2) DEFAULT 0.00
);
--
--
-- Se crearon 5 usuarios como ejemplo para insertar en la tabla.
INSERT INTO users (user_id, name, email, password, balance)
VALUES (
        1,
        'Juan Pérez',
        'juan@alkewallet.com',
        '12345678',
        1000.00
    ),
    (
        2,
        'María López',
        'maria@alkewallet.com',
        '12345678',
        1000.00
    ),
    (
        3,
        'Carlos García',
        'carlos@alkewallet.com',
        '12345678',
        1000.00
    ),
    (
        4,
        'Ana Rodríguez',
        'ana@alkewallet.com',
        '12345678',
        1000.00
    ),
    (
        5,
        'Luisa Martínez',
        'luisa@alkewallet.com',
        '12345678',
        1000.00
    );
--
--
-- Se normalizo la tabla para que todos los datos esten en ingles sin caracteres especiales.
CREATE TABLE currency (
    currency_id INT PRIMARY KEY NOT NULL,
    currency_name VARCHAR(255) NOT NULL,
    currency_symbol VARCHAR(10) NOT NULL
);
--
--
-- Se crearon 5 monedas como ejemplo para insertar en la tabla.
INSERT INTO currency (currency_id, currency_name, currency_symbol)
VALUES (1, 'Dólar estadounidense', 'USD'),
    (2, 'Euro', 'EUR'),
    (3, 'Libra esterlina', 'GBP'),
    (4, 'Yen japonés', 'JPY'),
    (5, 'Peso mexicano', 'MXN');
--
--
-- Se normalizo la tabla para que todos los datos esten en ingles sin caracteres especiales.
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY NOT NULL,
    sender_user_id INT NOT NULL,
    receiver_user_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    currency_id INT NOT NULL,
    FOREIGN KEY (sender_user_id) REFERENCES users(user_id),
    FOREIGN KEY (receiver_user_id) REFERENCES users(user_id),
    FOREIGN KEY (currency_id) REFERENCES currency(currency_id)
);
--
--
-- Se crearon 50 trasacciones como ejemplo para insertar en la tabla.
INSERT INTO transactions (
        transaction_id,
        sender_user_id,
        receiver_user_id,
        amount,
        currency_id
    )
VALUES (1, 3, 2, 50.00, 1),
    (2, 1, 5, 200.00, 2),
    (3, 2, 3, 100.50, 3),
    (4, 4, 5, 75.25, 4),
    (5, 1, 5, 150.75, 5),
    (6, 1, 3, 120.00, 1),
    (7, 2, 4, 90.50, 2),
    (8, 3, 5, 200.00, 3),
    (9, 4, 1, 50.25, 4),
    (10, 5, 2, 75.75, 5),
    (11, 1, 4, 100.00, 1),
    (12, 2, 5, 150.00, 2),
    (13, 3, 1, 60.50, 3),
    (14, 4, 2, 40.25, 4),
    (15, 5, 3, 85.75, 5),
    (16, 1, 5, 110.00, 1),
    (17, 2, 1, 95.50, 2),
    (18, 3, 2, 220.00, 3),
    (19, 4, 3, 30.25, 4),
    (20, 5, 4, 105.75, 5),
    (21, 1, 2, 115.00, 1),
    (22, 2, 3, 80.50, 2),
    (23, 3, 4, 190.00, 3),
    (24, 4, 5, 35.25, 4),
    (25, 5, 1, 90.75, 5),
    (26, 1, 3, 125.00, 1),
    (27, 2, 4, 85.50, 2),
    (28, 3, 5, 210.00, 3),
    (29, 4, 1, 55.25, 4),
    (30, 5, 2, 80.75, 5),
    (31, 1, 4, 105.00, 1),
    (32, 2, 5, 160.00, 2),
    (33, 3, 1, 65.50, 3),
    (34, 4, 2, 45.25, 4),
    (35, 5, 3, 90.75, 5),
    (36, 1, 5, 115.00, 1),
    (37, 2, 1, 100.50, 2),
    (38, 3, 2, 230.00, 3),
    (39, 4, 3, 25.25, 4),
    (40, 5, 4, 110.75, 5),
    (41, 1, 2, 120.00, 1),
    (42, 2, 3, 85.50, 2),
    (43, 3, 4, 200.00, 3),
    (44, 4, 5, 40.25, 4),
    (45, 5, 1, 95.75, 5),
    (46, 1, 3, 130.00, 1),
    (47, 2, 4, 80.50, 2),
    (48, 3, 5, 215.00, 3),
    (49, 4, 1, 60.25, 4),
    (50, 5, 2, 85.75, 5);
--
--
-- Consulta para obtener el nombre de la moneda elegida por un usuario específico. (Usuario 2)
SELECT u.name AS user,
    c.currency_name AS currency,
    c.currency_symbol AS symbol
FROM users u
    JOIN transactions t ON u.user_id = t.sender_user_id
    OR u.user_id = t.receiver_user_id
    JOIN currency c ON t.transaction_id = c.currency_id
WHERE u.user_id = 2;
--
--
-- Consulta para obtener todas las transacciones registradas.
SELECT *
FROM transactions;
--
--
-- Consulta para obtener todas las transacciones realizadas por un usuario específico. Busqueda General Usuario 2.
SELECT *
FROM transactions
WHERE sender_user_id = 2
    OR receiver_user_id = 2;
--
--
-- Consulta para obtener todas las transacciones realizadas por un usuario específico. Busqueda Detalle Solo Usuario 2.
SELECT sender.name AS sender,
    receiver.name AS receiver,
    t.amount,
    t.transaction_date AS date
FROM transactions t
    JOIN users sender ON t.sender_user_id = sender.user_id
    JOIN users receiver ON t.receiver_user_id = receiver.user_id
WHERE sender_user_id = 2;
--
--
-- Sentencia DML para modificar el campo correo electrónico de un usuario específico. (Usuario 1)
UPDATE users
SET email = 'juan.nuevo@example.com'
WHERE user_id = 1;
--
--
-- Sentencia para eliminar los datos de una transacción (eliminado de la fila completa)
DELETE FROM transactions
WHERE transaction_id = 1;
--
