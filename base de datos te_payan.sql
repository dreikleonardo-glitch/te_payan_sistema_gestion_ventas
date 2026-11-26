-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         13.0.2-MariaDB - MariaDB Server
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.20.0.7320
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para te_payan
CREATE DATABASE IF NOT EXISTS `te_payan` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `te_payan`;

-- Volcando estructura para tabla te_payan.bitacora
CREATE TABLE IF NOT EXISTS `bitacora` (
  `ID_BITACORA` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_USUARIO` smallint(5) unsigned NOT NULL,
  `ID_ENTREGA` int(10) unsigned NOT NULL,
  `ACCION` varchar(30) NOT NULL,
  `FECHA_HORA` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ID_BITACORA`),
  KEY `FK_BITACORA_USUARIOS` (`ID_USUARIO`),
  KEY `FK_BITACORA_ENTREGAS` (`ID_ENTREGA`),
  CONSTRAINT `FK_BITACORA_ENTREGAS` FOREIGN KEY (`ID_ENTREGA`) REFERENCES `entregas` (`ID_ENTREGA`),
  CONSTRAINT `FK_BITACORA_USUARIOS` FOREIGN KEY (`ID_USUARIO`) REFERENCES `usuarios` (`ID_USUARIO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla te_payan.bitacora: ~0 rows (aproximadamente)

-- Volcando estructura para tabla te_payan.consumo_punto_venta
CREATE TABLE IF NOT EXISTS `consumo_punto_venta` (
  `ID_CONSUMO` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `ID_PUNTO_VENTA` smallint(5) unsigned NOT NULL,
  `BOTELLAS_ACUMULADAS` int(10) unsigned NOT NULL DEFAULT 0,
  `FECHA_ACTUALIZACION` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`ID_CONSUMO`),
  UNIQUE KEY `UQ_CONSUMO_PUNTO_VENTA` (`ID_PUNTO_VENTA`),
  CONSTRAINT `FK_CONSUMO_PUNTOS_VENTA` FOREIGN KEY (`ID_PUNTO_VENTA`) REFERENCES `puntos_venta_clientes` (`ID_PUNTO_VENTA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla te_payan.consumo_punto_venta: ~0 rows (aproximadamente)

-- Volcando estructura para tabla te_payan.detalle_pedido
CREATE TABLE IF NOT EXISTS `detalle_pedido` (
  `ID_DETALLE_PEDIDO` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_PEDIDO` int(10) unsigned NOT NULL,
  `ID_PRODUCTO` smallint(5) unsigned NOT NULL,
  `CANTIDAD_BOTELLAS` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`ID_DETALLE_PEDIDO`),
  KEY `FK_DETPEDIDO_PEDIDOS` (`ID_PEDIDO`),
  KEY `FK_DETPEDIDO_PRODUCTOS` (`ID_PRODUCTO`),
  CONSTRAINT `FK_DETPEDIDO_PEDIDOS` FOREIGN KEY (`ID_PEDIDO`) REFERENCES `pedidos` (`ID_PEDIDO`),
  CONSTRAINT `FK_DETPEDIDO_PRODUCTOS` FOREIGN KEY (`ID_PRODUCTO`) REFERENCES `productos` (`ID_PRODUCTO`),
  CONSTRAINT `CK_DETPEDIDO_CANTIDAD` CHECK (`CANTIDAD_BOTELLAS` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla te_payan.detalle_pedido: ~0 rows (aproximadamente)

-- Volcando estructura para tabla te_payan.detalle_venta
CREATE TABLE IF NOT EXISTS `detalle_venta` (
  `ID_DETALLE_VENTA` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_VENTA` int(10) unsigned NOT NULL,
  `ID_PRODUCTO` smallint(5) unsigned NOT NULL,
  `CANTIDAD_BOTELLAS` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`ID_DETALLE_VENTA`),
  KEY `FK_DETVENTA_VENTAS` (`ID_VENTA`),
  KEY `FK_DETVENTA_PRODUCTOS` (`ID_PRODUCTO`),
  CONSTRAINT `FK_DETVENTA_PRODUCTOS` FOREIGN KEY (`ID_PRODUCTO`) REFERENCES `productos` (`ID_PRODUCTO`),
  CONSTRAINT `FK_DETVENTA_VENTAS` FOREIGN KEY (`ID_VENTA`) REFERENCES `ventas` (`ID_VENTA`),
  CONSTRAINT `CK_DETVENTA_CANTIDAD` CHECK (`CANTIDAD_BOTELLAS` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla te_payan.detalle_venta: ~0 rows (aproximadamente)

-- Volcando estructura para tabla te_payan.entregas
CREATE TABLE IF NOT EXISTS `entregas` (
  `ID_ENTREGA` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_PEDIDO` int(10) unsigned NOT NULL,
  `ID_PUNTO_VENTA` smallint(5) unsigned NOT NULL,
  `ID_USUARIO` smallint(5) unsigned NOT NULL,
  `FECHA_HORA_ENTREGA` datetime NOT NULL DEFAULT current_timestamp(),
  `CANTIDAD_BOTELLAS` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`ID_ENTREGA`),
  KEY `FK_ENTREGAS_PEDIDOS` (`ID_PEDIDO`),
  KEY `FK_ENTREGAS_PUNTOS_VENTA` (`ID_PUNTO_VENTA`),
  KEY `FK_ENTREGAS_USUARIOS` (`ID_USUARIO`),
  CONSTRAINT `FK_ENTREGAS_PEDIDOS` FOREIGN KEY (`ID_PEDIDO`) REFERENCES `pedidos` (`ID_PEDIDO`),
  CONSTRAINT `FK_ENTREGAS_PUNTOS_VENTA` FOREIGN KEY (`ID_PUNTO_VENTA`) REFERENCES `puntos_venta_clientes` (`ID_PUNTO_VENTA`),
  CONSTRAINT `FK_ENTREGAS_USUARIOS` FOREIGN KEY (`ID_USUARIO`) REFERENCES `usuarios` (`ID_USUARIO`),
  CONSTRAINT `CK_ENTREGAS_CANTIDAD` CHECK (`CANTIDAD_BOTELLAS` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla te_payan.entregas: ~0 rows (aproximadamente)

-- Volcando estructura para tabla te_payan.inventario
CREATE TABLE IF NOT EXISTS `inventario` (
  `ID_INVENTARIO` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `ID_PRODUCTO` smallint(5) unsigned NOT NULL,
  `EXISTENCIAS` smallint(5) unsigned NOT NULL DEFAULT 0,
  `FECHA_ACTUALIZACION` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`ID_INVENTARIO`),
  KEY `FK_INVENTARIO_PRODUCTOS` (`ID_PRODUCTO`),
  CONSTRAINT `FK_INVENTARIO_PRODUCTOS` FOREIGN KEY (`ID_PRODUCTO`) REFERENCES `productos` (`ID_PRODUCTO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla te_payan.inventario: ~0 rows (aproximadamente)

-- Volcando estructura para tabla te_payan.pedidos
CREATE TABLE IF NOT EXISTS `pedidos` (
  `ID_PEDIDO` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_PUNTO_VENTA` smallint(5) unsigned NOT NULL,
  `ID_USUARIO` smallint(5) unsigned NOT NULL,
  `FECHA_PEDIDO` datetime NOT NULL DEFAULT current_timestamp(),
  `FECHA_ENTREGA` date NOT NULL,
  `ESTATUS` varchar(10) NOT NULL DEFAULT 'AGENDADO',
  PRIMARY KEY (`ID_PEDIDO`),
  KEY `FK_PEDIDOS_PUNTOS_VENTA` (`ID_PUNTO_VENTA`),
  KEY `FK_PEDIDOS_USUARIOS` (`ID_USUARIO`),
  CONSTRAINT `FK_PEDIDOS_PUNTOS_VENTA` FOREIGN KEY (`ID_PUNTO_VENTA`) REFERENCES `puntos_venta_clientes` (`ID_PUNTO_VENTA`),
  CONSTRAINT `FK_PEDIDOS_USUARIOS` FOREIGN KEY (`ID_USUARIO`) REFERENCES `usuarios` (`ID_USUARIO`),
  CONSTRAINT `CK_PEDIDOS_ESTATUS` CHECK (`ESTATUS` in ('AGENDADO','ENTREGADO','CANCELADO'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla te_payan.pedidos: ~0 rows (aproximadamente)

-- Volcando estructura para tabla te_payan.productos
CREATE TABLE IF NOT EXISTS `productos` (
  `ID_PRODUCTO` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(30) NOT NULL,
  `PRECIO` decimal(6,2) NOT NULL,
  `ESTATUS` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`ID_PRODUCTO`),
  CONSTRAINT `CK_PRODUCTOS_PRECIO` CHECK (`PRECIO` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla te_payan.productos: ~0 rows (aproximadamente)

-- Volcando estructura para tabla te_payan.puntos_venta_clientes
CREATE TABLE IF NOT EXISTS `puntos_venta_clientes` (
  `ID_PUNTO_VENTA` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(50) NOT NULL,
  `DIRECCION` varchar(80) NOT NULL,
  `TELEFONO` char(10) DEFAULT NULL,
  `ESTATUS` tinyint(1) NOT NULL DEFAULT 1,
  `FECHA_REGISTRO` date NOT NULL DEFAULT curdate(),
  PRIMARY KEY (`ID_PUNTO_VENTA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla te_payan.puntos_venta_clientes: ~0 rows (aproximadamente)

-- Volcando estructura para tabla te_payan.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `ID_ROL` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `NOMBRE_ROL` varchar(20) NOT NULL,
  `DESCRIPCION` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID_ROL`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla te_payan.roles: ~2 rows (aproximadamente)
INSERT INTO `roles` (`ID_ROL`, `NOMBRE_ROL`, `DESCRIPCION`) VALUES
	(1, 'Administrador', 'Acceso total al sistema'),
	(2, 'Vendedor', 'Registra ventas, pedidos y entregas');

-- Volcando estructura para tabla te_payan.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `ID_USUARIO` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(30) NOT NULL,
  `APELLIDO_PATERNO` varchar(30) NOT NULL,
  `APELLIDO_MATERNO` varchar(30) DEFAULT NULL,
  `NOMBRE_USUARIO` varchar(20) NOT NULL,
  `CONTRASENA_HASH` char(60) NOT NULL,
  `ID_ROL` smallint(5) unsigned NOT NULL,
  `ESTATUS` tinyint(1) NOT NULL DEFAULT 1,
  `FECHA_REGISTRO` date NOT NULL DEFAULT curdate(),
  PRIMARY KEY (`ID_USUARIO`),
  UNIQUE KEY `UQ_USUARIOS_NOMBRE_USUARIO` (`NOMBRE_USUARIO`),
  KEY `FK_USUARIOS_ROLES` (`ID_ROL`),
  CONSTRAINT `FK_USUARIOS_ROLES` FOREIGN KEY (`ID_ROL`) REFERENCES `roles` (`ID_ROL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla te_payan.usuarios: ~0 rows (aproximadamente)

-- Volcando estructura para tabla te_payan.ventas
CREATE TABLE IF NOT EXISTS `ventas` (
  `ID_VENTA` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_PUNTO_VENTA` smallint(5) unsigned NOT NULL,
  `ID_USUARIO` smallint(5) unsigned NOT NULL,
  `FECHA_VENTA` date NOT NULL,
  `TOTAL` decimal(8,2) NOT NULL,
  PRIMARY KEY (`ID_VENTA`),
  KEY `FK_VENTAS_PUNTOS_VENTA` (`ID_PUNTO_VENTA`),
  KEY `FK_VENTAS_USUARIOS` (`ID_USUARIO`),
  CONSTRAINT `FK_VENTAS_PUNTOS_VENTA` FOREIGN KEY (`ID_PUNTO_VENTA`) REFERENCES `puntos_venta_clientes` (`ID_PUNTO_VENTA`),
  CONSTRAINT `FK_VENTAS_USUARIOS` FOREIGN KEY (`ID_USUARIO`) REFERENCES `usuarios` (`ID_USUARIO`),
  CONSTRAINT `CK_VENTAS_TOTAL` CHECK (`TOTAL` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla te_payan.ventas: ~0 rows (aproximadamente)

-- Volcando estructura para disparador te_payan.TRG_BITACORA_NO_DELETE
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER TRG_BITACORA_NO_DELETE
BEFORE DELETE ON BITACORA FOR EACH ROW
BEGIN
  SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'La bitácora no se puede eliminar';
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador te_payan.TRG_BITACORA_NO_UPDATE
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER TRG_BITACORA_NO_UPDATE
BEFORE UPDATE ON BITACORA FOR EACH ROW
BEGIN
  SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'La bitácora no se puede modificar';
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
