INSERT INTO db_vendas.estado (uf, descricao)
VALUES ('AC', 'Acre'),
('AL', 'Alagoas'),
('AM', 'Amazonas'),
('AP', 'Amapá'),
('BA', 'Bahia'),
('CE', 'Ceará'),
('DF', 'Distrito Federal'),
('ES', 'Espírito Santo'),
('GO', 'Goiás'),
('MA', 'Maranhão'),
('MG', 'Minas Gerais'),
('MS', 'Mato Grosso do Sul'),
('MT', 'Mato Grosso'),
('PA', 'Pará'),
('PB', 'Paraíba'),
('PE', 'Pernambuco'),
('PI', 'Piauí'),
('PR', 'Paraná'),
('RJ', 'Rio de Janeiro'),
('RN', 'Rio Grande do Norte'),
('RO', 'Rondônia'),
('RR', 'Roraima'),
('RS', 'Rio Grande do Sul'),
('SC', 'Santa Catarina'),
('SE', 'Sergipe'),
('SP', 'São Paulo'),
('TO', 'Tocantins');

INSERT INTO db_vendas.cidade (nome, uf) VALUES ('Aracaju', 'SE');
INSERT INTO db_vendas.cidade (nome, uf) VALUES ('Belém', 'PA');
INSERT INTO db_vendas.cidade (nome, uf) VALUES ('Belo Horizonte', 'MG');
INSERT INTO db_vendas.cidade (nome, uf) VALUES ('Boa Vista', 'RR');
INSERT INTO db_vendas.cidade (nome, uf) VALUES ('Brasília', 'DF');
INSERT INTO db_vendas.cidade (nome, uf) VALUES ('Campo Grande', 'MS');
INSERT INTO db_vendas.cidade (nome, uf) VALUES ('Cuiabá', 'MT');
INSERT INTO db_vendas.cidade (nome, uf) VALUES ('Curitiba', 'PR');
INSERT INTO db_vendas.cidade (nome, uf) VALUES ('Florianópolis', 'SC');
INSERT INTO db_vendas.cidade (nome, uf) VALUES ('Fortaleza', 'CE');
INSERT INTO db_vendas.cidade (nome, uf) VALUES ('Goiânia', 'GO');
INSERT INTO db_vendas.cidade (nome, uf) VALUES ('João Pessoa', 'PB');
INSERT INTO db_vendas.cidade (nome, uf) VALUES ('Macapá', 'AP');
INSERT INTO db_vendas.cidade (nome, uf) VALUES ('Maceió', 'AL');
INSERT INTO db_vendas.cidade (nome, uf) VALUES ('Manaus', 'AM');
INSERT INTO db_vendas.cidade (nome, uf) VALUES ('Natal', 'RN');
INSERT INTO db_vendas.cidade (nome, uf) VALUES ('Palmas', 'TO');
INSERT INTO db_vendas.cidade (nome, uf) VALUES ('Porto Alegre', 'RS');
INSERT INTO db_vendas.cidade (nome, uf) VALUES ('Porto Velho', 'RO');
INSERT INTO db_vendas.cidade (nome, uf) VALUES ('Recife', 'PE');
INSERT INTO db_vendas.cidade (nome, uf) VALUES ('Rio Branco', 'AC');
INSERT INTO db_vendas.cidade (nome, uf) VALUES ('Rio de Janeiro', 'RJ');
INSERT INTO db_vendas.cidade (nome, uf) VALUES ('Salvador', 'BA');
INSERT INTO db_vendas.cidade (nome, uf) VALUES ('São Luís', 'MA');
INSERT INTO db_vendas.cidade (nome, uf) VALUES ('São Paulo', 'SP');
INSERT INTO db_vendas.cidade (nome, uf) VALUES ('Teresina', 'PI');
INSERT INTO db_vendas.cidade (nome, uf) VALUES ('Vitória', 'ES');


INSERT INTO db_vendas.cliente (nome)
VALUES ("ANA CRISTINA CAMILO CERQUEIRA"),
("CAMILLA MIRANDA FIGUEIREDO E SILVA"),
("CARLA NASCIMENTO DE JESUS"),
("EDVALDINA DOS REIS CRUZ"),
("EVELIN LAUREANE SOUSA SANTOS"),
("ADRIANA AZEVEDO DA COSTA"),
("KARLA ARIANNE COSTA ALVES"),
("ARIADNE ROBER DOS SANTOS FLEURY"),
("CAMILA LUIZ DOS SANTOS"),
("FABIO ARAUJO SOARES"),
("ARACELY LUDMILA DA SILVA NOGUEIRA"),
("MARCEMILA DOS SANTOS PEREIRA REIS"),
("WILLIAM DA SILVA SANTANA"),
("TATIANA DE ARRUDA"),
("FRANCINEIDE RODRIGUES SANTOS"),
("GILVANIA GOMES DE OLIVEIRA"),
("CLAUDIA LUCIA QUEIROZ FORTES"),
("TATIANE ASSUNÇÃO DE SOUZA"),
("FERNANDA SANTOS MATOS"),
("CLEBERSON DE OLIVEIRA NUNES"),
("MONIQUE CRIS DE ALMEIDA"),
("JULIANNY DOS REIS TELES"),
("GERALDO PAULINO DE ALENCAR NETO"),
("NATHALIA MAGALHAES LIMA"),
("ELAIS COSTA DA SILVA"),
("KAREN LOREDANA DE SOUZA NEVES DIAS"),
("PEDRO ALMEIDA DOS SANTOS JÚNIOR");

UPDATE db_vendas.cliente set id_cidade = (select max(id_cidade) from  db_vendas.cidade) WHERE id_cidade is null;

INSERT INTO db_vendas.produto
(descricao,
preco)
VALUES
("Conjunto de Tomada 2P+T 10A",1.99),
("Caixa Elétrica de Plástico 4x2",1.19),
("Conjunto Interruptor Simples 1 Módulo 6A",5.49),
("Suporte 4x2 3 Módulos Branco",1.50),
("Luva Soldável 3/4 PVC Antichamas",1.60),
("Módulo de Tomada de Energia 1 Módulo 2P",29.90),
("Eletroduto Flexível Corrugado PVC",18.60),
("Caixa Elétrica de Plástico 4x4",4.58),
("Fio/Cabo Flexível Antichamas Flexsil 2,50 mm",109.63),
("Grampo para Haste de Aterramento",43.67),
("Luva Roscável 3/4 PVC Antichamas",4.69),
("Extensão Elétrica 3 tomadas 3m 3 Pólos 10A",24.90),
("Disjuntor DIN Monopolar 230/400V 20A",10.50),
("Módulo Saída de Fio 680167",17.99),
("Lâmpada LED Philips Bulbo 9W ",8.90),
("Lâmpada Halógena Eco 72w E27",12.99),
("Lâmpada LED Tubular T08 20W",20.50),
("Spot LED de Embutir Plástico",9.99),
("Abraçadeira PVC  3/4 Top",12.99),
("Plafon de Sobrepor 15cm E27",10.90),
("Porta Lâmpada Rabicho Latão 250V",9.99),
("Balizador de Jardim Solar ABS LED",18.90),
("Lâmpada LED Dicróica MR16",21.90);

COMMIT;


