CREATE DATABASE IF NOT EXISTS `db_vendas` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;
USE `db_vendas`;

--
-- Table structure for table `estado`
--

DROP TABLE IF EXISTS `estado`;
CREATE TABLE `estado` (
  `uf` char(2) NOT NULL,
  `descricao` varchar(45) NOT NULL,
  PRIMARY KEY (`uf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `estado` VALUES ('AC','Acre'),('AL','Alagoas'),('AM','Amazonas'),('AP','Amapá'),('BA','Bahia'),('CE','Ceará'),('DF','Distrito Federal'),('ES','Espírito Santo'),('GO','Goiás'),('MA','Maranhão'),('MG','Minas Gerais'),('MS','Mato Grosso do Sul'),('MT','Mato Grosso'),('PA','Pará'),('PB','Paraíba'),('PE','Pernambuco'),('PI','Piauí'),('PR','Paraná'),('RJ','Rio de Janeiro'),('RN','Rio Grande do Norte'),('RO','Rondônia'),('RR','Roraima'),('RS','Rio Grande do Sul'),('SC','Santa Catarina'),('SE','Sergipe'),('SP','São Paulo'),('TO','Tocantins');

COMMIT;

--
-- Table structure for table `cidade`
--

DROP TABLE IF EXISTS `cidade`;
CREATE TABLE `cidade` (
  `id_cidade` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `uf` char(2) NOT NULL,
  PRIMARY KEY (`id_cidade`),
  KEY `uf` (`uf`),
  CONSTRAINT `cidade_ibfk_1` FOREIGN KEY (`uf`) REFERENCES `estado` (`uf`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `cidade` VALUES (2,'Aracaju','SE'),(3,'Belém','PA'),(4,'Belo Horizonte','MG'),(5,'Boa Vista','RR'),(6,'Brasília','DF'),(7,'Campo Grande','MS'),(8,'Cuiabá','MT'),(9,'Curitiba','PR'),(10,'Florianópolis','SC'),(11,'Fortaleza','CE'),(12,'Goiânia','GO'),(13,'João Pessoa','PB'),(14,'Macapá','AP'),(15,'Maceió','AL'),(16,'Manaus','AM'),(17,'Natal','RN'),(18,'Palmas','TO'),(19,'Porto Alegre','RS'),(20,'Porto Velho','RO'),(21,'Recife','PE'),(22,'Rio Branco','AC'),(23,'Rio de Janeiro','RJ'),(24,'Salvador','BA'),(25,'São Luís','MA'),(26,'São Paulo','SP'),(27,'Teresina','PI'),(28,'Vitória','ES');

COMMIT;
--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
CREATE TABLE `cliente` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `id_cidade` int DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  KEY `id_cidade` (`id_cidade`),
  CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`id_cidade`) REFERENCES `cidade` (`id_cidade`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabela de Clientes';

INSERT INTO `cliente` VALUES (2,'ANA CRISTINA CAMILO CERQUEIRA',28),(3,'CAMILLA MIRANDA FIGUEIREDO E SILVA',28),(4,'CARLA NASCIMENTO DE JESUS',28),(5,'EDVALDINA DOS REIS CRUZ',28),(6,'EVELIN LAUREANE SOUSA SANTOS',28),(7,'ADRIANA AZEVEDO DA COSTA',28),(8,'KARLA ARIANNE COSTA ALVES',28),(9,'ARIADNE ROBER DOS SANTOS FLEURY',28),(10,'CAMILA LUIZ DOS SANTOS',28),(11,'FABIO ARAUJO SOARES',28),(12,'ARACELY LUDMILA DA SILVA NOGUEIRA',28),(13,'MARCEMILA DOS SANTOS PEREIRA REIS',28),(14,'WILLIAM DA SILVA SANTANA',28),(15,'TATIANA DE ARRUDA',28),(16,'FRANCINEIDE RODRIGUES SANTOS',28),(17,'GILVANIA GOMES DE OLIVEIRA',28),(18,'CLAUDIA LUCIA QUEIROZ FORTES',28),(19,'TATIANE ASSUNÇÃO DE SOUZA',28),(20,'FERNANDA SANTOS MATOS',28),(21,'CLEBERSON DE OLIVEIRA NUNES',28),(22,'MONIQUE CRIS DE ALMEIDA',28),(23,'JULIANNY DOS REIS TELES',28),(24,'GERALDO PAULINO DE ALENCAR NETO',28),(25,'NATHALIA MAGALHAES LIMA',28),(26,'ELAIS COSTA DA SILVA',28),(27,'KAREN LOREDANA DE SOUZA NEVES DIAS',28),(28,'PEDRO ALMEIDA DOS SANTOS JÚNIOR',28);

COMMIT;
--
-- Table structure for table `produto`
--

DROP TABLE IF EXISTS `produto`;
CREATE TABLE `produto` (
  `id_produto` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(150) DEFAULT NULL,
  `preco` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`id_produto`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `produto` VALUES (2,'Conjunto de Tomada 2P+T 10A',1.99),(3,'Caixa Elétrica de Plástico 4x2',1.19),(4,'Conjunto Interruptor Simples 1 Módulo 6A',5.49),(5,'Suporte 4x2 3 Módulos Branco',1.50),(6,'Luva Soldável 3/4 PVC Antichamas',1.60),(7,'Módulo de Tomada de Energia 1 Módulo 2P',29.90),(8,'Eletroduto Flexível Corrugado PVC',18.60),(9,'Caixa Elétrica de Plástico 4x4',4.58),(10,'Fio/Cabo Flexível Antichamas Flexsil 2,50 mm',109.63),(11,'Grampo para Haste de Aterramento',43.67),(12,'Luva Roscável 3/4 PVC Antichamas',4.69),(13,'Extensão Elétrica 3 tomadas 3m 3 Pólos 10A',24.90),(14,'Disjuntor DIN Monopolar 230/400V 20A',10.50),(15,'Módulo Saída de Fio 680167',17.99),(16,'Lâmpada LED Philips Bulbo 9W ',8.90),(17,'Lâmpada Halógena Eco 72w E27',12.99),(18,'Lâmpada LED Tubular T08 20W',20.50),(19,'Spot LED de Embutir Plástico',9.99),(20,'Abraçadeira PVC  3/4 Top',12.99),(21,'Plafon de Sobrepor 15cm E27',10.90),(22,'Porta Lâmpada Rabicho Latão 250V',9.99),(23,'Balizador de Jardim Solar ABS LED',18.90),(24,'Lâmpada LED Dicróica MR16',21.90);

COMMIT;
--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
CREATE TABLE `pedido` (
  `id_pedido` int NOT NULL AUTO_INCREMENT,
  `dt_pedido` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_cliente` int NOT NULL,
  `valor_total` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id_pedido`),
  KEY `idx_pedido_cliente` (`id_cliente`),
  CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `pedido_produto`
--

DROP TABLE IF EXISTS `pedido_produto`;
CREATE TABLE `pedido_produto` (
  `id_pedido_produto` int NOT NULL AUTO_INCREMENT,
  `id_pedido` int NOT NULL,
  `id_produto` int NOT NULL,
  `quantidade` int NOT NULL,
  `valor_unidade` decimal(12,2) NOT NULL,
  `valor_total` decimal(12,2) GENERATED ALWAYS AS ((`valor_unidade` * `quantidade`)) VIRTUAL,
  PRIMARY KEY (`id_pedido_produto`),
  KEY `id_produto` (`id_produto`),
  KEY `idx_produto_pedido` (`id_pedido`,`id_produto`),
  CONSTRAINT `pedido_produto_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`),
  CONSTRAINT `pedido_produto_ibfk_2` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


