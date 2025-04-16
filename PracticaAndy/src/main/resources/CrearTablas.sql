DROP DATABASE IF EXISTS biblioteca_db;
drop user if exists usuario_prueba;
CREATE DATABASE biblioteca_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

create user 'usuario_prueba'@'%' identified by 'Usuar1o_Clave.';

/*Se asignan los prvilegios sobr ela base de datos TechShop al usuario creado */
grant all privileges on biblioteca_db.* to 'usuario_prueba'@'%';
flush privileges;

USE biblioteca_db;

/* Tabla de roles */
CREATE TABLE role (
    rol VARCHAR(20) PRIMARY KEY
);

INSERT INTO role (rol) VALUES 
('ADMIN'), 
('VENDEDOR'), 
('USUARIO');

/* Tabla de usuarios */
CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE
);

/* Tabla de asignación de roles (relación muchos a muchos estilo techshop) */
CREATE TABLE rol (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20),
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- Asignación inicial (Las contraseñas son 123, 456, y 789)
INSERT INTO usuario (username, password, nombre, apellidos, correo, activo) VALUES
('andy', '$2a$12$9EfhFXIBSu0wlDnjmlpOAus4J3OIwiLpOQDdtN9ycf6nB2wX0M/nu', 'Andy', 'Hidalgo', 'admin@biblioteca.com', TRUE),
('vend', '$2a$12$ofSrcbi.dHwX3gKXK6d6k.QN.fuOKUAKW.sBd5Uf7CQDH5Pw3e0BW', 'Vendedor', 'biblio', 'vendedor@biblioteca.com', TRUE),
('user', '$2a$12$LEMHwZYKEcHpX3Ogk6F02.Pr51xIMKxu9jAVLJlV.NR.M2.uQMxD.', 'Usuario', 'biblio', 'usuario@biblioteca.com', TRUE);

INSERT INTO rol (nombre, id_usuario) VALUES
('ADMIN', 1), ('VENDEDOR', 1), ('USUARIO', 1),
('VENDEDOR', 2), ('USUARIO', 2),
('USUARIO', 3);

/* Categorías */
CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

INSERT INTO categoria (descripcion, activo) VALUES
('Novela', true), ('Poesía', true), ('Historia', true), ('Ciencia', true), ('Informática', true), ('Filosofía', true);

/* Libros */
CREATE TABLE libro (
    id_libro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    precio	decimal(10,2),
    editorial VARCHAR(100),
    idioma VARCHAR(50),
    existencias INT NOT NULL,
    id_categoria INT NOT NULL,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

/* Préstamos */
CREATE TABLE prestamo (
    id_prestamo INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_libro INT NOT NULL,
    fecha_prestamo DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_devolucion_esperada DATETIME NOT NULL,
    fecha_devolucion_real DATETIME,
    estado VARCHAR(20) DEFAULT 'PRESTADO', -- en lugar de ENUM para mantener formato
    observaciones TEXT,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_libro) REFERENCES libro(id_libro)
);

INSERT INTO libro (titulo, precio, editorial, idioma, existencias, id_categoria) VALUES
('Cien años de soledad', 15.99, 'Editorial Sudamericana', 'Español', 50, 1),
('The Lord of the Rings', 28.00, 'George Allen & Unwin', 'Inglés', 40, 2),
('Orgullo y prejuicio', 12.75, 'Alianza Editorial', 'Español', 45, 1),
('Harry Potter and the Sorcerer\'s Stone', 20.00, 'Scholastic Press', 'Inglés', 65, 2),
('Don Quijote de la Mancha', 19.95, 'Real Academia Española', 'Español', 25, 3),
('Crónica de una muerte anunciada', 11.50, 'Editorial Norma', 'Español', 55, 1),
('The Hobbit', 17.50, 'Houghton Mifflin', 'Inglés', 35, 2),
('Emma', 14.00, 'Debolsillo', 'Español', 40, 1),
('Matar un ruiseñor', 17.60, 'HarperCollins', 'Español', 20, 3),
('Los juegos del hambre', 13.90, 'RBA Molino', 'Español', 70, 2);