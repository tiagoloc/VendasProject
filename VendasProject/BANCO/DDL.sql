-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
SHOW WARNINGS;
-- -----------------------------------------------------
-- Schema db_vendas
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `db_vendas` ;

-- -----------------------------------------------------
-- Schema db_vendas
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_vendas` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
SHOW WARNINGS;
USE `db_vendas` ;

-- -----------------------------------------------------
-- Table `db_vendas`.`estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_vendas`.`estado` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `db_vendas`.`estado` (
  `uf` CHAR(2) NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`uf`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SHOW WARNINGS;
CREATE UNIQUE INDEX `uf_UNIQUE` ON `db_vendas`.`estado` (`uf` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `db_vendas`.`cidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_vendas`.`cidade` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `db_vendas`.`cidade` (
  `id_cidade` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `uf` CHAR(2) NOT NULL,
  PRIMARY KEY (`id_cidade`),
  CONSTRAINT `uf_cidade_fk`
    FOREIGN KEY (`uf`)
    REFERENCES `db_vendas`.`estado` (`uf`))
ENGINE = InnoDB
AUTO_INCREMENT = 28
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SHOW WARNINGS;
CREATE INDEX `uf_fk_idx` ON `db_vendas`.`cidade` (`uf` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `db_vendas`.`cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_vendas`.`cliente` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `db_vendas`.`cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `id_cidade` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_cliente`, `nome`),
  CONSTRAINT `cidade_cliente_fk`
    FOREIGN KEY (`id_cidade`)
    REFERENCES `db_vendas`.`cidade` (`id_cidade`))
ENGINE = InnoDB
AUTO_INCREMENT = 23
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'Tabela de Clientes';

SHOW WARNINGS;
CREATE INDEX `id_nome_cliente_idx` ON `db_vendas`.`cliente` (`nome` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `cidade_cliente_fk_idx` ON `db_vendas`.`cliente` (`id_cidade` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `db_vendas`.`pedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_vendas`.`pedido` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `db_vendas`.`pedido` (
  `id_pedido` INT NOT NULL AUTO_INCREMENT,
  `dt_pedido` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_cliente` INT NOT NULL,
  `valor_total` DECIMAL(12,2) NOT NULL,
  PRIMARY KEY (`id_pedido`),
  CONSTRAINT `id_cliente_pedido_fk`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `db_vendas`.`cliente` (`id_cliente`))
ENGINE = InnoDB
AUTO_INCREMENT = 22
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SHOW WARNINGS;
CREATE INDEX `id_cliente_cliente_fk_idx` ON `db_vendas`.`pedido` (`id_cliente` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `db_vendas`.`produto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_vendas`.`produto` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `db_vendas`.`produto` (
  `id_produto` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(150) NULL DEFAULT NULL,
  `preco` DECIMAL(12,2) NULL DEFAULT NULL,
  PRIMARY KEY (`id_produto`))
ENGINE = InnoDB
AUTO_INCREMENT = 23
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `db_vendas`.`pedido_produto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_vendas`.`pedido_produto` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `db_vendas`.`pedido_produto` (
  `id_pedido_produto` INT NOT NULL AUTO_INCREMENT,
  `id_pedido` INT NOT NULL,
  `id_produto` INT NOT NULL,
  `quantidade` INT NOT NULL,
  `valor_unidade` DECIMAL(12,2) NOT NULL,
  `valor_total` DECIMAL(12,2) GENERATED ALWAYS AS ((`valor_unidade` * `quantidade`)) VIRTUAL,
  PRIMARY KEY (`id_pedido_produto`),
  CONSTRAINT `'id_pedido_pedido_prod_fk`
    FOREIGN KEY (`id_pedido`)
    REFERENCES `db_vendas`.`pedido` (`id_pedido`),
  CONSTRAINT `id_produto_pedido_prod_fk`
    FOREIGN KEY (`id_produto`)
    REFERENCES `db_vendas`.`produto` (`id_produto`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SHOW WARNINGS;
CREATE INDEX `id_produto_pedido_prod_fk_idx` ON `db_vendas`.`pedido_produto` (`id_produto` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `id_pedido_produto_idx` ON `db_vendas`.`pedido_produto` (`id_produto` ASC, `id_pedido` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `'id_pedido_pedido_prod_fk_idx` ON `db_vendas`.`pedido_produto` (`id_pedido` ASC) VISIBLE;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
