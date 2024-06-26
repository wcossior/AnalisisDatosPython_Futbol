-- MySQL Script generated by MySQL Workbench
-- Sat May 18 11:37:11 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db_futlbol
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_futlbol
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_futlbol` DEFAULT CHARACTER SET utf8 ;
USE `db_futlbol` ;

-- -----------------------------------------------------
-- Table `db_futlbol`.`dim_dates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_futlbol`.`dim_dates` (
  `date_game` DATE NOT NULL,
  `year_game` INT NULL,
  `month_game` INT NULL,
  `yearmonth_game` INT NULL,
  `decade_game` VARCHAR(9) NULL,
  PRIMARY KEY (`date_game`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_futlbol`.`fact_results`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_futlbol`.`fact_results` (
  `id_game` INT NOT NULL,
  `date_game` DATE NOT NULL,
  `home_team` VARCHAR(70) NULL,
  `away_team` VARCHAR(70) NULL,
  `home_score` INT NULL,
  `away_score` INT NULL,
  `tournament` VARCHAR(70) NULL,
  `city` VARCHAR(45) NULL,
  `country` VARCHAR(70) NULL,
  `neutral` VARCHAR(10) NULL,
  PRIMARY KEY (`id_game`),
  INDEX `fk_fact_results_dim_dates1_idx` (`date_game` ASC) VISIBLE,
  CONSTRAINT `fk_fact_results_dim_dates1`
    FOREIGN KEY (`date_game`)
    REFERENCES `db_futlbol`.`dim_dates` (`date_game`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_futlbol`.`dim_shootouts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_futlbol`.`dim_shootouts` (
  `id_game` INT NOT NULL,
  `date_game` DATE NOT NULL,
  `home_team` VARCHAR(70) NOT NULL,
  `away_team` VARCHAR(70) NOT NULL,
  `winner` VARCHAR(70) NULL,
  `first_shooter` VARCHAR(70) NULL,
  INDEX `fk_dim_shootouts_fact_results1_idx` (`id_game` ASC) VISIBLE,
  PRIMARY KEY (`id_game`),
  CONSTRAINT `fk_dim_shootouts_fact_results1`
    FOREIGN KEY (`id_game`)
    REFERENCES `db_futlbol`.`fact_results` (`id_game`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_futlbol`.`dim_goalscorers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_futlbol`.`dim_goalscorers` (
  `d_game` INT NOT NULL,
  `id_golascore` INT NOT NULL,
  `date_game` DATE NOT NULL,
  `home_team` VARCHAR(70) NULL,
  `away_team` VARCHAR(70) NULL,
  `scorer_team` VARCHAR(70) NULL,
  `scorer` VARCHAR(100) NULL,
  `minute` INT NULL,
  `own_goal` VARCHAR(10) NULL,
  `penalty` VARCHAR(10) NULL,
  PRIMARY KEY (`d_game`, `id_golascore`),
  INDEX `fk_dim_goalscorers_fact_results_idx` (`d_game` ASC) VISIBLE,
  CONSTRAINT `fk_dim_goalscorers_fact_results`
    FOREIGN KEY (`d_game`)
    REFERENCES `db_futlbol`.`fact_results` (`id_game`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
