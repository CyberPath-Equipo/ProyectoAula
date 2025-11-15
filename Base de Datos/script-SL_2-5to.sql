-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema smartlearn
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `smartlearn` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `smartlearn` ;

-- -----------------------------------------------------
-- Table `smartlearn`.`materia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smartlearn`.`materia` (
  `id_materia` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(255) NULL DEFAULT NULL,
  `descripcion` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id_materia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `smartlearn`.`tema`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smartlearn`.`tema` (
  `id_tema` INT NOT NULL AUTO_INCREMENT,
  `id_materia` INT NULL DEFAULT NULL,
  `nombre` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id_tema`),
  INDEX `id_materia` (`id_materia` ASC) VISIBLE,
  CONSTRAINT `tema_ibfk_1`
    FOREIGN KEY (`id_materia`)
    REFERENCES `smartlearn`.`materia` (`id_materia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `smartlearn`.`subtema`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smartlearn`.`subtema` (
  `id_subtema` INT NOT NULL AUTO_INCREMENT,
  `id_tema` INT NULL DEFAULT NULL,
  `nombre` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id_subtema`),
  INDEX `id_tema` (`id_tema` ASC) VISIBLE,
  CONSTRAINT `subtema_ibfk_1`
    FOREIGN KEY (`id_tema`)
    REFERENCES `smartlearn`.`tema` (`id_tema`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `smartlearn`.`teoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smartlearn`.`teoria` (
  `id_teoria` INT NOT NULL AUTO_INCREMENT,
  `contenido` TEXT NULL DEFAULT NULL,
  `revisado` TINYINT NULL DEFAULT NULL,
  `id_subtema` INT NOT NULL,
  PRIMARY KEY (`id_teoria`),
  INDEX `fk_teoria_subtema1_idx` (`id_subtema` ASC) VISIBLE,
  CONSTRAINT `fk_teoria_subtema1`
    FOREIGN KEY (`id_subtema`)
    REFERENCES `smartlearn`.`subtema` (`id_subtema`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `smartlearn`.`archivo_adjunto`  (movida a smartlearn)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smartlearn`.`archivo_adjunto` (
  `id_archivo` INT NOT NULL,
  `url` VARCHAR(55) NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  `id_teoria` INT NOT NULL,
  PRIMARY KEY (`id_archivo`),
  INDEX `fk_archivo_adjunto_teoria_idx` (`id_teoria` ASC) VISIBLE,
  CONSTRAINT `fk_archivo_adjunto_teoria`
    FOREIGN KEY (`id_teoria`)
    REFERENCES `smartlearn`.`teoria` (`id_teoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `smartlearn`.`ejercicio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smartlearn`.`ejercicio` (
  `id_ejercicio` INT NOT NULL AUTO_INCREMENT,
  `id_subtema` INT NULL DEFAULT NULL,
  `nombre` VARCHAR(255) NULL DEFAULT NULL,
  `hecho` TINYINT NULL DEFAULT NULL,
  PRIMARY KEY (`id_ejercicio`),
  INDEX `id_subtema` (`id_subtema` ASC) VISIBLE,
  CONSTRAINT `ejercicio_ibfk_1`
    FOREIGN KEY (`id_subtema`)
    REFERENCES `smartlearn`.`subtema` (`id_subtema`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `smartlearn`.`recurso`  (movida a smartlearn)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smartlearn`.`recurso` (
  `id_recurso` INT NOT NULL,
  `url` VARCHAR(55) NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  `ejercicio_id_ejercicio` INT NOT NULL,
  PRIMARY KEY (`id_recurso`),
  INDEX `fk_recurso_ejercicio1_idx` (`ejercicio_id_ejercicio` ASC) VISIBLE,
  CONSTRAINT `fk_recurso_ejercicio1`
    FOREIGN KEY (`ejercicio_id_ejercicio`)
    REFERENCES `smartlearn`.`ejercicio` (`id_ejercicio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `smartlearn`.`tbl_rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smartlearn`.`tbl_rol` (
  `id_rol` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id_rol`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `smartlearn`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smartlearn`.`usuario` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `nombre_cuenta` VARCHAR(255) NULL DEFAULT NULL,
  `correo` VARCHAR(255) NULL DEFAULT NULL,
  `contrasena` VARCHAR(255) NULL DEFAULT NULL,
  `modo_audio` TINYINT NULL DEFAULT NULL,
  `id_rol` INT NOT NULL,
  PRIMARY KEY (`id_usuario`, `id_rol`),
  INDEX `fk_usuario_tbl_rol1_idx` (`id_rol` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_tbl_rol1`
    FOREIGN KEY (`id_rol`)
    REFERENCES `smartlearn`.`tbl_rol` (`id_rol`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `smartlearn`.`intento_ejercicio` (movida a smartlearn)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smartlearn`.`intento_ejercicio` (
  `id_intento` INT NOT NULL,
  `fecha` DATE NULL,
  `puntuaje` INT NULL,
  `id_ejercicio` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `id_rol` INT NOT NULL,
  PRIMARY KEY (`id_intento`),
  INDEX `fk_intento_ejercicio_ejercicio1_idx` (`id_ejercicio` ASC) VISIBLE,
  INDEX `fk_intento_ejercicio_usuario1_idx` (`id_usuario` ASC, `id_rol` ASC) VISIBLE,
  CONSTRAINT `fk_intento_ejercicio_ejercicio1`
    FOREIGN KEY (`id_ejercicio`)
    REFERENCES `smartlearn`.`ejercicio` (`id_ejercicio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_intento_ejercicio_usuario1`
    FOREIGN KEY (`id_usuario` , `id_rol`)
    REFERENCES `smartlearn`.`usuario` (`id_usuario` , `id_rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `smartlearn`.`pregunta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smartlearn`.`pregunta` (
  `id_pregunta` INT NOT NULL AUTO_INCREMENT,
  `id_ejercicio` INT NULL DEFAULT NULL,
  `enunciado` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id_pregunta`),
  INDEX `id_ejercicio` (`id_ejercicio` ASC) VISIBLE,
  CONSTRAINT `pregunta_ibfk_1`
    FOREIGN KEY (`id_ejercicio`)
    REFERENCES `smartlearn`.`ejercicio` (`id_ejercicio`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `smartlearn`.`opcion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smartlearn`.`opcion` (
  `id_opcion` INT NOT NULL AUTO_INCREMENT,
  `id_pregunta` INT NOT NULL,
  `texto` VARCHAR(255) NULL DEFAULT NULL,
  `es_correcta` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id_opcion`),
  INDEX `id_pregunta` (`id_pregunta` ASC) VISIBLE,
  CONSTRAINT `opcion_ibfk_1`
    FOREIGN KEY (`id_pregunta`)
    REFERENCES `smartlearn`.`pregunta` (`id_pregunta`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- Índice compuesto necesario para FK compuesta (soluciona error 1822)
ALTER TABLE `smartlearn`.`opcion`
ADD INDEX `idx_opcion_pregunta` (`id_opcion`, `id_pregunta`);

-- -----------------------------------------------------
-- Table `smartlearn`.`usuariomateria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smartlearn`.`usuariomateria` (
  `id_usuario_materia` INT NOT NULL AUTO_INCREMENT,
  `id_usuario` INT NULL DEFAULT NULL,
  `id_materia` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_usuario_materia`),
  INDEX `id_usuario` (`id_usuario` ASC) VISIBLE,
  INDEX `id_materia` (`id_materia` ASC) VISIBLE,
  CONSTRAINT `usuariomateria_ibfk_1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `smartlearn`.`usuario` (`id_usuario`),
  CONSTRAINT `usuariomateria_ibfk_2`
    FOREIGN KEY (`id_materia`)
    REFERENCES `smartlearn`.`materia` (`id_materia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
