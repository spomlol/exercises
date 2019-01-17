-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Exercise4
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Exercise4
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Exercise4` ;
USE `Exercise4` ;

-- -----------------------------------------------------
-- Table `Exercise4`.`Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Exercise4`.`Doctor` (
  `DoctorId` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Date_of_birth` DATE NULL,
  `Address` VARCHAR(45) NULL,
  `phone_number` VARCHAR(45) NULL,
  PRIMARY KEY (`DoctorId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Exercise4`.`Medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Exercise4`.`Medical` (
  `DoctorId` INT NOT NULL,
  `Overtime_rate` FLOAT NULL,
  PRIMARY KEY (`DoctorId`),
  INDEX `fk_Medical_Doctor1_idx` (`DoctorId` ASC) VISIBLE,
  CONSTRAINT `fk_Medical_Doctor1`
    FOREIGN KEY (`DoctorId`)
    REFERENCES `Exercise4`.`Doctor` (`DoctorId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Exercise4`.`Specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Exercise4`.`Specialist` (
  `Field_areaID` INT NOT NULL,
  `Field_area` VARCHAR(45) NULL,
  PRIMARY KEY (`Field_areaID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Exercise4`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Exercise4`.`Patient` (
  `PatientID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  `phone_number` VARCHAR(45) NULL,
  `Date_of_birth` DATE NULL,
  PRIMARY KEY (`PatientID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Exercise4`.`Doctor_has_Specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Exercise4`.`Doctor_has_Specialist` (
  `DoctorId` INT NOT NULL,
  `Field_areaID` INT NOT NULL,
  `ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Doctor_has_Specialist_Specialist1_idx` (`Field_areaID` ASC) VISIBLE,
  INDEX `fk_Doctor_has_Specialist_Doctor1_idx` (`DoctorId` ASC) VISIBLE,
  CONSTRAINT `fk_Doctor_has_Specialist_Doctor1`
    FOREIGN KEY (`DoctorId`)
    REFERENCES `Exercise4`.`Doctor` (`DoctorId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Doctor_has_Specialist_Specialist1`
    FOREIGN KEY (`Field_areaID`)
    REFERENCES `Exercise4`.`Specialist` (`Field_areaID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Exercise4`.`Appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Exercise4`.`Appointment` (
  `Date` DATE NULL,
  `Time` TIME NULL,
  `DoctorId` INT NOT NULL,
  `PatientID` INT NOT NULL,
  `AppointmentID` INT NOT NULL,
  PRIMARY KEY (`AppointmentID`),
  INDEX `fk_Appointment_Patient1_idx` (`PatientID` ASC) VISIBLE,
  INDEX `fk_Appointment_Doctor1_idx` (`DoctorId` ASC) VISIBLE,
  CONSTRAINT `fk_Appointment_Doctor1`
    FOREIGN KEY (`DoctorId`)
    REFERENCES `Exercise4`.`Doctor` (`DoctorId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Appointment_Patient1`
    FOREIGN KEY (`PatientID`)
    REFERENCES `Exercise4`.`Patient` (`PatientID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Exercise4`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Exercise4`.`Payment` (
  `Payment ID` INT NOT NULL,
  `Details` VARCHAR(45) NULL,
  `Method` ENUM("Bankcontact", "Paypal") NULL,
  `Patient_PatientID` INT NOT NULL,
  PRIMARY KEY (`Payment ID`),
  INDEX `fk_Payment_Patient1_idx` (`Patient_PatientID` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_Patient1`
    FOREIGN KEY (`Patient_PatientID`)
    REFERENCES `Exercise4`.`Patient` (`PatientID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Exercise4`.`Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Exercise4`.`Bill` (
  `BillID` INT NOT NULL,
  `Total` VARCHAR(45) NULL,
  `DoctorId` INT NOT NULL,
  PRIMARY KEY (`BillID`),
  INDEX `fk_Bill_Doctor1_idx` (`DoctorId` ASC) VISIBLE,
  CONSTRAINT `fk_Bill_Doctor1`
    FOREIGN KEY (`DoctorId`)
    REFERENCES `Exercise4`.`Doctor` (`DoctorId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Exercise4`.`Bill_has_Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Exercise4`.`Bill_has_Payment` (
  `BillID` INT NOT NULL,
  `Payment ID` INT NOT NULL,
  `ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Bill_has_Payment_Payment1_idx` (`Payment ID` ASC) VISIBLE,
  INDEX `fk_Bill_has_Payment_Bill1_idx` (`BillID` ASC) VISIBLE,
  CONSTRAINT `fk_Bill_has_Payment_Bill1`
    FOREIGN KEY (`BillID`)
    REFERENCES `Exercise4`.`Bill` (`BillID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bill_has_Payment_Payment1`
    FOREIGN KEY (`Payment ID`)
    REFERENCES `Exercise4`.`Payment` (`Payment ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
