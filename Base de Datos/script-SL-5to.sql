-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema smartlearn
-- -----------------------------------------------------

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
-- Table `smartlearn`.`teoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smartlearn`.`teoria` (
  `id_teoria` INT NOT NULL AUTO_INCREMENT,
  `contenido` TEXT NULL DEFAULT NULL,
  `revisado` TINYINT NULL,
  PRIMARY KEY (`id_teoria`))
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
  `id_teoria` INT NOT NULL,
  PRIMARY KEY (`id_subtema`, `id_teoria`),
  INDEX `id_tema` (`id_tema` ASC) VISIBLE,
  INDEX `fk_subtema_teoria1_idx` (`id_teoria` ASC) VISIBLE,
  CONSTRAINT `subtema_ibfk_1`
    FOREIGN KEY (`id_tema`)
    REFERENCES `smartlearn`.`tema` (`id_tema`),
  CONSTRAINT `fk_subtema_teoria1`
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
  `hecho` TINYINT NULL,
  PRIMARY KEY (`id_ejercicio`),
  INDEX `id_subtema` (`id_subtema` ASC) VISIBLE,
  CONSTRAINT `ejercicio_ibfk_1`
    FOREIGN KEY (`id_subtema`)
    REFERENCES `smartlearn`.`subtema` (`id_subtema`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


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
  `id_pregunta` INT NULL DEFAULT NULL,
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


-- -----------------------------------------------------
-- Table `smartlearn`.`tbl_rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smartlearn`.`tbl_rol` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id_usuario`))
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
  `modo_audio` TINYINT NULL,
  `id_rol` INT NOT NULL,
  PRIMARY KEY (`id_usuario`, `id_rol`),
  INDEX `fk_usuario_tbl_rol1_idx` (`id_rol` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_tbl_rol1`
    FOREIGN KEY (`id_rol`)
    REFERENCES `smartlearn`.`tbl_rol` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


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
