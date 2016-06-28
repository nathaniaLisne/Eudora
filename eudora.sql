-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema avon_local
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema avon_local
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `avon_local` DEFAULT CHARACTER SET latin1 ;
USE `avon_local` ;

-- -----------------------------------------------------
-- Table `avon_local`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `avon_local`.`products` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(255) NULL,
  `cust_value` DECIMAL(5,2) NOT NULL,
  `sale_value` DECIMAL(5,2) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `status` TINYINT(1) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `avon_local`.`stocks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `avon_local`.`stocks` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `products_id` INT UNSIGNED NOT NULL,
  `quantity` TINYINT(1) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `status` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idstocks_UNIQUE` (`id` ASC),
  INDEX `fk_stocks_products_idx` (`products_id` ASC),
  CONSTRAINT `fk_stocks_products`
    FOREIGN KEY (`products_id`)
    REFERENCES `avon_local`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `avon_local`.`countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `avon_local`.`countries` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` VARCHAR(45) NOT NULL,
  `status` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `avon_local`.`states`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `avon_local`.`states` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `uf` VARCHAR(4) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `status` TINYINT(1) NOT NULL,
  `countries_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_states_countries1_idx` (`countries_id` ASC),
  CONSTRAINT `fk_states_countries1`
    FOREIGN KEY (`countries_id`)
    REFERENCES `avon_local`.`countries` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `avon_local`.`cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `avon_local`.`cities` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `status` TINYINT(1) NOT NULL,
  `states_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cities_states1_idx` (`states_id` ASC),
  CONSTRAINT `fk_cities_states1`
    FOREIGN KEY (`states_id`)
    REFERENCES `avon_local`.`states` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `avon_local`.`neighborhoods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `avon_local`.`neighborhoods` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `cities_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_neighborhoods_cities1_idx` (`cities_id` ASC),
  CONSTRAINT `fk_neighborhoods_cities1`
    FOREIGN KEY (`cities_id`)
    REFERENCES `avon_local`.`cities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `avon_local`.`streets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `avon_local`.`streets` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `number` MEDIUMINT(5) NOT NULL,
  `zipcode` VARCHAR(45) NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `status` TINYINT(1) NOT NULL,
  `neighborhoods_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_streets_neighborhoods1_idx` (`neighborhoods_id` ASC),
  CONSTRAINT `fk_streets_neighborhoods1`
    FOREIGN KEY (`neighborhoods_id`)
    REFERENCES `avon_local`.`neighborhoods` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `avon_local`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `avon_local`.`address` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `streets_id` INT UNSIGNED NOT NULL,
  `neighborhoods_id` INT UNSIGNED NOT NULL,
  `cities_id` INT UNSIGNED NOT NULL,
  `states_id` INT UNSIGNED NOT NULL,
  `countries_id` INT UNSIGNED NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `status` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_address_streets1_idx` (`streets_id` ASC),
  INDEX `fk_address_neighborhoods1_idx` (`neighborhoods_id` ASC),
  INDEX `fk_address_cities1_idx` (`cities_id` ASC),
  INDEX `fk_address_states1_idx` (`states_id` ASC),
  INDEX `fk_address_countries1_idx` (`countries_id` ASC),
  CONSTRAINT `fk_address_streets1`
    FOREIGN KEY (`streets_id`)
    REFERENCES `avon_local`.`streets` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_neighborhoods1`
    FOREIGN KEY (`neighborhoods_id`)
    REFERENCES `avon_local`.`neighborhoods` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_cities1`
    FOREIGN KEY (`cities_id`)
    REFERENCES `avon_local`.`cities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_states1`
    FOREIGN KEY (`states_id`)
    REFERENCES `avon_local`.`states` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_countries1`
    FOREIGN KEY (`countries_id`)
    REFERENCES `avon_local`.`countries` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `avon_local`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `avon_local`.`customers` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fullname` VARCHAR(150) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `born` DATE NOT NULL,
  `gender` ENUM('man', 'woman') NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `status` TINYINT(1) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `avon_local`.`customers_has_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `avon_local`.`customers_has_address` (
  `customers_id` INT UNSIGNED NOT NULL,
  `address_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`customers_id`, `address_id`),
  INDEX `fk_customers_has_address_address1_idx` (`address_id` ASC),
  INDEX `fk_customers_has_address_customers1_idx` (`customers_id` ASC),
  CONSTRAINT `fk_customers_has_address_customers1`
    FOREIGN KEY (`customers_id`)
    REFERENCES `avon_local`.`customers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customers_has_address_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `avon_local`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
