-- MySQL Script generated by MySQL Workbench
-- 08/15/14 00:59:01
-- Model: New Model    Version: 1.0
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema sistema_van
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sistema_van` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `sistema_van` ;


-- -----------------------------------------------------
-- Table `sistema_van`.`USUARIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_van`.`USUARIO` (
  `ID_USUARIO` INT NOT NULL AUTO_INCREMENT,
  `LOGIN` CHAR(12) NOT NULL,
  `SENHA` VARCHAR(45) NOT NULL,
  `NIVEL` NUMERIC(1) NOT NULL,
  PRIMARY KEY (`ID_USUARIO`),
  UNIQUE INDEX `LOGIN_UNIQUE` (`LOGIN` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sistema_van`.`MOTORISTA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_van`.`MOTORISTA` (
  `ID_MOTORISTA` INT NOT NULL AUTO_INCREMENT,
  `EMAIL` VARCHAR(45) NOT NULL,
  `NOME_COMPLETO` VARCHAR(45) NOT NULL,
  `ENDERECO` VARCHAR(45) NOT NULL,
  `TELEFONE1` VARCHAR(45) NOT NULL,
  `TELEFONE2` VARCHAR(45) NULL,
  `CNH` CHAR(11) NOT NULL,
  CONSTRAINT `FK_MOTORISTA_01` FOREIGN KEY (`ID_MOTORISTA`) REFERENCES `sistema_van`.`USUARIO` (`ID_USUARIO`),
  PRIMARY KEY (`ID_MOTORISTA`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sistema_van`.`PASSAGEIRO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_van`.`PASSAGEIRO` (
  `ID_PASSAGEIRO` INT NOT NULL AUTO_INCREMENT,
  `EMAIL` VARCHAR(45) NOT NULL,
  `NOME_COMPLETO` VARCHAR(45) NOT NULL,
  `ENDERECO` VARCHAR(45) NULL,
  `TELEFONE1` VARCHAR(45) NOT NULL,
  `TELEFONE2` VARCHAR(45) NULL,
  CONSTRAINT `FK_PASSAGEIRO_01` FOREIGN KEY (`ID_PASSAGEIRO`) REFERENCES `sistema_van`.`USUARIO` (`ID_USUARIO`),
    PRIMARY KEY (`ID_PASSAGEIRO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sistema_van`.`ADMINISTRADOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_van`.`ADMINISTRADOR` (
  `ID_ADMINISTRADOR` INT NOT NULL AUTO_INCREMENT,
  CONSTRAINT `FK_ADMINISTRADOR_01` FOREIGN KEY (`ID_ADMINISTRADOR`) REFERENCES `sistema_van`.`USUARIO` (`ID_USUARIO`),
  PRIMARY KEY (`ID_ADMINISTRADOR`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sistema_van`.`ROTA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_van`.`ROTA` (
  `ID_ROTA` INT NOT NULL AUTO_INCREMENT,
  `ID_MOTORISTA` INT NOT NULL,
  `CIDADE_ORIGEM` VARCHAR(45) NOT NULL,
  `CIDADE_DESTINO` VARCHAR(45) NOT NULL,
  `DISPONIBILIDADE` VARCHAR(45) NOT NULL,
  `PRECO` DECIMAL(3,2) NOT NULL,
  `HORARIO` TIME NOT NULL,
  CONSTRAINT `FK_ROTA_01` FOREIGN KEY (`ID_MOTORISTA`) REFERENCES `sistema_van`.`MOTORISTA` (`ID_MOTORISTA`),
  PRIMARY KEY (`ID_ROTA`, `ID_MOTORISTA`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sistema_van`.`LOCALIDADE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_van`.`LOCALIDADE` (
  `ID_LOCALIDADE` INT NOT NULL AUTO_INCREMENT,
  `RUA` VARCHAR(45) NOT NULL,
  `BAIRRO` VARCHAR(45) NOT NULL,
  `NUMERO` INT(10) NOT NULL,
  PRIMARY KEY (`ID_LOCALIDADE`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sistema_van`.`RESERVA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_van`.`RESERVA` (
  `ID_RESERVA` INT NOT NULL AUTO_INCREMENT,
  `ID_PASSAGEIRO` INT NOT NULL,
  `ID_ROTA` INT NOT NULL,
  `DATA` DATE NOT NULL,
  `ENDERECO_ORIGEM` VARCHAR(45) NOT NULL,
  `ENDERECO_DESTINO` VARCHAR(45) NOT NULL,
  CONSTRAINT `FK_PASSAGEIRO_02` FOREIGN KEY (`ID_PASSAGEIRO`) REFERENCES `sistema_van`.`PASSAGEIRO` (`ID_PASSAGEIRO`),
  CONSTRAINT `FK_ROTA_02` FOREIGN KEY (`ID_ROTA`) REFERENCES `sistema_van`.`ROTA` (`ID_ROTA`),
  PRIMARY KEY (`ID_RESERVA`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sistema_van`.`AVALIA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_van`.`AVALIA` (
  `COD_PASSAGEIRO` INT NOT NULL,
  `COD_MOTORISTA` INT NOT NULL,
  `COD_AVALIADOR` INT NOT NULL,
  `COD_RESERVA` INT NOT NULL,
  `NOTA` INT(5) NOT NULL,
  `COMENTARIO` VARCHAR(45) NULL,
  CONSTRAINT `FK_PASSAGEIRO_03` FOREIGN KEY (`COD_PASSAGEIRO`) REFERENCES `sistema_van`.`PASSAGEIRO` (`ID_PASSAGEIRO`),
  CONSTRAINT `FK_MOTORISTA_02` FOREIGN KEY (`COD_MOTORISTA`) REFERENCES `sistema_van`.`MOTORISTA` (`ID_MOTORISTA`),
  CONSTRAINT `FK_RESERVA_01` FOREIGN KEY (`COD_RESERVA`) REFERENCES `sistema_van`.`RESERVA` (`ID_RESERVA`),
  PRIMARY KEY (`COD_PASSAGEIRO`, `COD_MOTORISTA`, `COD_AVALIADOR`, `COD_RESERVA`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sistema_van`.`VAN`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_van`.`VAN` (
  `ID_VAN` INT NOT NULL AUTO_INCREMENT,
  `PLACA` CHAR(7) NOT NULL,
  `CHASSI` VARCHAR(45) NOT NULL,
  `ANO` VARCHAR(45) NOT NULL,
  `ID_MOTORISTA` INT NOT NULL,
  CONSTRAINT `FK_MOTORISTA_03` FOREIGN KEY (`ID_MOTORISTA`) REFERENCES `sistema_van`.`MOTORISTA` (`ID_MOTORISTA`),
  PRIMARY KEY (`ID_VAN`, `ID_MOTORISTA`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sistema_van`.`TEM`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_van`.`TEM` (
  `ID_ROTA` INT NOT NULL,
  `ID_LOCALIDADE` INT NOT NULL,
  CONSTRAINT `FK_ROTA_04` FOREIGN KEY (`ID_ROTA`) REFERENCES `sistema_van`.`ROTA` (`ID_ROTA`),
  CONSTRAINT `FK_LOCALIDADE_01` FOREIGN KEY (`ID_LOCALIDADE`) REFERENCES `sistema_van`.`LOCALIDADE` (`ID_LOCALIDADE`),
    PRIMARY KEY (`ID_ROTA`, `ID_LOCALIDADE`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
