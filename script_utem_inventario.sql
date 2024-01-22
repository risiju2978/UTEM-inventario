-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema inventario
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema inventario
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `inventario` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `inventario` ;

-- -----------------------------------------------------
-- Table `inventario`.`articulo_estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`articulo_estado` (
  `articulo_estado_id` INT NOT NULL AUTO_INCREMENT,
  `articulo_estado` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`articulo_estado_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `inventario`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`categoria` (
  `categoria_id` INT NOT NULL AUTO_INCREMENT,
  `categoria` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`categoria_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `inventario`.`sede`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`sede` (
  `campus_id` INT NOT NULL AUTO_INCREMENT,
  `campus` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`campus_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `inventario`.`departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`departamento` (
  `departament_id` INT NOT NULL AUTO_INCREMENT,
  `departament` VARCHAR(255) NOT NULL,
  `campus_id` INT NOT NULL,
  PRIMARY KEY (`departament_id`),
  INDEX `fk_departamento_sede1_idx` (`campus_id` ASC) VISIBLE,
  CONSTRAINT `fk_departamento_sede1`
    FOREIGN KEY (`campus_id`)
    REFERENCES `inventario`.`sede` (`campus_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `inventario`.`oficina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`oficina` (
  `office_id` INT NOT NULL AUTO_INCREMENT,
  `departament_id` INT NOT NULL,
  `office` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`office_id`),
  INDEX `fk_oficina_departamento1_idx` (`departament_id` ASC) VISIBLE,
  CONSTRAINT `fk_oficina_departamento1`
    FOREIGN KEY (`departament_id`)
    REFERENCES `inventario`.`departamento` (`departament_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `inventario`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`rol` (
  `rol_id` INT NOT NULL AUTO_INCREMENT,
  `rol` VARCHAR(255) NOT NULL,
  `state` TINYINT NOT NULL DEFAULT '0',
  PRIMARY KEY (`rol_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `inventario`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`usuario` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `campus_id` INT NOT NULL,
  `rol_id` INT NOT NULL,
  `username` VARCHAR(55) NOT NULL,
  `password` VARCHAR(80) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `user_state` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `correo_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_usuario_sede1_idx` (`campus_id` ASC) VISIBLE,
  INDEX `fk_usuario_rol1_idx` (`rol_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_sede1`
    FOREIGN KEY (`campus_id`)
    REFERENCES `inventario`.`sede` (`campus_id`),
  CONSTRAINT `fk_usuario_rol1`
    FOREIGN KEY (`rol_id`)
    REFERENCES `inventario`.`rol` (`rol_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `inventario`.`articulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`articulo` (
  `id_articulo` INT NOT NULL AUTO_INCREMENT,
  `articulo_estado_id` INT NOT NULL,
  `categoria_id` INT NOT NULL,
  `usuario_id` INT NOT NULL,
  `oficina_id` INT NOT NULL,
  PRIMARY KEY (`id_articulo`),
  INDEX `fk_articulo_articulo_estado1_idx` (`articulo_estado_id` ASC) VISIBLE,
  INDEX `fk_articulo_categoria1_idx` (`categoria_id` ASC) VISIBLE,
  INDEX `fk_articulo_usuario1_idx` (`usuario_id` ASC) VISIBLE,
  INDEX `fk_articulo_oficina1_idx` (`oficina_id` ASC) VISIBLE,
  CONSTRAINT `fk_articulo_articulo_estado1`
    FOREIGN KEY (`articulo_estado_id`)
    REFERENCES `inventario`.`articulo_estado` (`articulo_estado_id`),
  CONSTRAINT `fk_articulo_categoria1`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `inventario`.`categoria` (`categoria_id`),
  CONSTRAINT `fk_articulo_oficina1`
    FOREIGN KEY (`oficina_id`)
    REFERENCES `inventario`.`oficina` (`office_id`),
  CONSTRAINT `fk_articulo_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `inventario`.`usuario` (`user_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `inventario`.`articulo_baja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`articulo_baja` (
  `id_articulo_baja` INT NOT NULL AUTO_INCREMENT,
  `id_articulo` INT NOT NULL,
  `fecha_baja` TIMESTAMP(1) NOT NULL,
  `motivo_baja` VARCHAR(200) NOT NULL,
  `autorizacion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_articulo_baja`),
  INDEX `fk_articulo_baja_articulo1_idx` (`id_articulo` ASC) VISIBLE,
  CONSTRAINT `fk_articulo_baja_articulo1`
    FOREIGN KEY (`id_articulo`)
    REFERENCES `inventario`.`articulo` (`id_articulo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `inventario`.`articulo_detalle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`articulo_detalle` (
  `articulo_detalle_id` INT NOT NULL AUTO_INCREMENT,
  `id_articulo` INT NOT NULL,
  `anio` VARCHAR(255) NOT NULL,
  `dimension` VARCHAR(255) NOT NULL,
  `art_num` VARCHAR(255) NOT NULL,
  `art_nombre` VARCHAR(45) NOT NULL,
  `art_ingreso` TIMESTAMP NULL DEFAULT NULL,
  `art_codigo` VARCHAR(255) NULL DEFAULT NULL,
  `art_glosa` VARCHAR(2000) NULL DEFAULT NULL,
  `art_image_path` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`articulo_detalle_id`, `id_articulo`),
  INDEX `fk_articulo_detalle_articulo1_idx` (`id_articulo` ASC) VISIBLE,
  CONSTRAINT `fk_articulo_detalle_articulo1`
    FOREIGN KEY (`id_articulo`)
    REFERENCES `inventario`.`articulo` (`id_articulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `inventario`.`usuario_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`usuario_log` (
  `user_log_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `details` VARCHAR(255) NULL DEFAULT NULL,
  `class` VARCHAR(255) NULL DEFAULT NULL,
  `accion` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`user_log_id`),
  INDEX `fk_usuario_log_usuario1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_log_usuario1`
    FOREIGN KEY (`user_id`)
    REFERENCES `inventario`.`usuario` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
