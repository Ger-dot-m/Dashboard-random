CREATE DATABASE tienda;
USE tienda;

CREATE TABLE producto (
  sku VARCHAR(20) PRIMARY KEY,
  descripcion VARCHAR(255) NOT NULL,
  precio1 DOUBLE NOT NULL,
  precio2 DOUBLE,
  costo DOUBLE,
  rodada INT,
  existencia INT,
  linea VARCHAR(255) NOT NULL,
  marca VARCHAR(255) NOT NULL
);

CREATE TABLE vendedor (
  pdv VARCHAR(20),
  vendedor_id INT PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  celular VARCHAR(20),
  sueldo DOUBLE
);

CREATE TABLE cliente (
  cliente_id INT PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  celular VARCHAR(20)
);

CREATE TABLE venta (
  pdv VARCHAR(20) NOT NULL,
  fecha DATE NOT NULL,
  folio VARCHAR(20),
  producto VARCHAR(20),
  cliente INT,
  vendedor INT,
  cantidad INT,
  tipoPago VARCHAR(20),
  importe DOUBLE,
  FOREIGN KEY (producto) REFERENCES producto(sku),
  FOREIGN KEY (cliente) REFERENCES cliente(cliente_id),
  FOREIGN KEY (vendedor) REFERENCES vendedor(vendedor_id)
);

// Para modificar valores existentes


SET SQL_SAFE_UPDATES = 0;
UPDATE "producto" SET "rodada"=0 WHERE "rodada"  is null;

