

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Quan_ly_NCKH_sv
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Quan_ly_NCKH_sv
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Quan_ly_NCKH_sv` DEFAULT CHARACTER SET utf8 ;
USE `Quan_ly_NCKH_sv` ;

-- -----------------------------------------------------
-- Table `Quan_ly_NCKH_sv`.`Giảng viên`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Quan_ly_NCKH_sv`.`Giảng viên` (
  `ID_giang_vien` INT NOT NULL AUTO_INCREMENT,
  `Tên giảng viên` VARCHAR(45) NOT NULL,
  `Chức vụ` VARCHAR(45) NOT NULL,
  `Khoa giảng dạy` VARCHAR(45) NOT NULL,
  `Lĩnh vực nghiên cứu` VARCHAR(45) NULL,
  PRIMARY KEY (`ID_giang_vien`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Quan_ly_NCKH_sv`.`Đề tài NCKH`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Quan_ly_NCKH_sv`.`Đề tài NCKH` (
  `ID_de_tai` INT NOT NULL AUTO_INCREMENT,
  `Tên đề tài` VARCHAR(45) NOT NULL,
  `Lĩnh vực nghiên cứu` VARCHAR(45) NOT NULL,
  `Tóm tắt đề tài` VARCHAR(45) NOT NULL,
  `Năm học` DATE NOT NULL,
  `Khoa quản lý đề tài` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_de_tai`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Quan_ly_NCKH_sv`.`Sinh viên`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Quan_ly_NCKH_sv`.`Sinh viên` (
  `id_Sinh_vien` INT NOT NULL AUTO_INCREMENT,
  `Họ và tên` VARCHAR(45) NOT NULL,
  `Lớp` VARCHAR(45) NOT NULL,
  `Ngành` VARCHAR(45) NOT NULL,
  `Khoa` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Sinh_vien`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Quan_ly_NCKH_sv`.`Giải thưởng`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Quan_ly_NCKH_sv`.`Giải thưởng` (
  `ID_giai_thuong` INT NOT NULL AUTO_INCREMENT,
  `Tên giải thưởng` VARCHAR(45) NOT NULL,
  `Cấp giải thưởng` VARCHAR(45) NOT NULL,
  `Năm học` DATE NOT NULL,
  `DS đề tài đạt giải` VARCHAR(45) NOT NULL,
  `Mã đề tài` INT NOT NULL,
  PRIMARY KEY (`ID_giai_thuong`, `Mã đề tài`),
  INDEX `fk_Giai_thuong_De_tai1_idx` (`Mã đề tài` ASC) VISIBLE,
  CONSTRAINT `fk_Giai_thuong_De_tai1`
    FOREIGN KEY (`Mã đề tài`)
    REFERENCES `Quan_ly_NCKH_sv`.`Đề tài NCKH` (`ID_de_tai`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Quan_ly_NCKH_sv`.`Giảng viên hướng dẫn đề tài`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Quan_ly_NCKH_sv`.`Giảng viên hướng dẫn đề tài` (
  `Mã giảng viên` INT NOT NULL,
  `Mã đề tài` INT NOT NULL,
  PRIMARY KEY (`Mã giảng viên`, `Mã đề tài`),
  INDEX `fk_Giang_vien_huong_dan_has_De_tai_De_tai1_idx` (`Mã đề tài` ASC) VISIBLE,
  INDEX `fk_Giang_vien_huong_dan_has_De_tai_Giang_vien_huong_dan_idx` (`Mã giảng viên` ASC) VISIBLE,
  CONSTRAINT `fk_Giang_vien_huong_dan_has_De_tai_Giang_vien_huong_dan`
    FOREIGN KEY (`Mã giảng viên`)
    REFERENCES `Quan_ly_NCKH_sv`.`Giảng viên` (`ID_giang_vien`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Giang_vien_huong_dan_has_De_tai_De_tai1`
    FOREIGN KEY (`Mã đề tài`)
    REFERENCES `Quan_ly_NCKH_sv`.`Đề tài NCKH` (`ID_de_tai`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Quan_ly_NCKH_sv`.`Sinh viên tham gia NCKH`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Quan_ly_NCKH_sv`.`Sinh viên tham gia NCKH` (
  `Mã đề tài` INT NOT NULL,
  `Mã sinh viên` INT NOT NULL,
  `Vai trò` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Mã đề tài`, `Mã sinh viên`),
  INDEX `fk_De_tai_has_Sinh_vien_Sinh_vien1_idx` (`Mã đề tài` ASC) VISIBLE,
  INDEX `fk_De_tai_has_Sinh_vien_De_tai1_idx` (`Mã sinh viên` ASC) VISIBLE,
  CONSTRAINT `fk_De_tai_has_Sinh_vien_De_tai1`
    FOREIGN KEY (`Mã sinh viên`)
    REFERENCES `Quan_ly_NCKH_sv`.`Đề tài NCKH` (`ID_de_tai`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_De_tai_has_Sinh_vien_Sinh_vien1`
    FOREIGN KEY (`Mã đề tài`)
    REFERENCES `Quan_ly_NCKH_sv`.`Sinh viên` (`id_Sinh_vien`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Quan_ly_NCKH_sv`.`Sinh viên đạt giải`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Quan_ly_NCKH_sv`.`Sinh viên đạt giải` (
  `Mã đề tài` INT NOT NULL,
  `Mã sinh viên` INT NOT NULL,
  `Mã giải thưởng` INT NOT NULL,
  `Năm học` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Mã đề tài`, `Mã sinh viên`, `Mã giải thưởng`),
  INDEX `fk_Giai_thuong_has_Sinh_vien_Sinh_vien1_idx` (`Mã sinh viên` ASC) VISIBLE,
  INDEX `fk_Giai_thuong_has_Sinh_vien_Giai_thuong1_idx` (`Mã giải thưởng` ASC, `Mã đề tài` ASC) VISIBLE,
  CONSTRAINT `fk_Giai_thuong_has_Sinh_vien_Giai_thuong1`
    FOREIGN KEY (`Mã giải thưởng` , `Mã đề tài`)
    REFERENCES `Quan_ly_NCKH_sv`.`Giải thưởng` (`ID_giai_thuong` , `Mã đề tài`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Giai_thuong_has_Sinh_vien_Sinh_vien1`
    FOREIGN KEY (`Mã sinh viên`)
    REFERENCES `Quan_ly_NCKH_sv`.`Sinh viên` (`id_Sinh_vien`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Quan_ly_NCKH_sv`.`Giảng viên hướng dẫn đề tài đạt giải`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Quan_ly_NCKH_sv`.`Giảng viên hướng dẫn đề tài đạt giải` (
  `Mã giảng viên` INT NOT NULL,
  `Mã đề tài đạt giải` INT NOT NULL,
  `Mã giải thưởng` INT NOT NULL,
  `Năm học` DATE NOT NULL,
  PRIMARY KEY (`Mã giảng viên`, `Mã đề tài đạt giải`, `Mã giải thưởng`),
  INDEX `fk_Giai_thuong_has_Giảng viên hướng dẫn đề tài__idx` (`Mã giảng viên` ASC) VISIBLE,
  INDEX `fk_Giai_thuong_has_Giảng viên hướng dẫn đề tài__idx1` (`Mã giải thưởng` ASC, `Mã đề tài đạt giải` ASC) VISIBLE,
  CONSTRAINT `fk_Giai_thuong_has_Giảng viên hướng dẫn đề tài_Gi1`
    FOREIGN KEY (`Mã giải thưởng` , `Mã đề tài đạt giải`)
    REFERENCES `Quan_ly_NCKH_sv`.`Giải thưởng` (`ID_giai_thuong` , `Mã đề tài`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Giai_thuong_has_Giảng viên hướng dẫn đề tài_Gi2`
    FOREIGN KEY (`Mã giảng viên`)
    REFERENCES `Quan_ly_NCKH_sv`.`Giảng viên hướng dẫn đề tài` (`Mã giảng viên`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
