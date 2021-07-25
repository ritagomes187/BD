-- ------------------------------------------------------
-- ------------------------------------------------------
-- Universidade do Minho
-- Mestrado Integrado em Engenharia Informática
-- Lincenciatura em Ciências da Computação
-- Unidade Curricular de Bases de Dados
-- 
-- Caso de Estudo: Centro de Reabilitação Física
-- Povoamento inicial da base de dados
-- Novembro/2020
-- ------------------------------------------------------
-- ------------------------------------------------------

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema crf
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema crf
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `crf` ;
-- -----------------------------------------------------
-- Schema new_schema1
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema new_schema2
-- -----------------------------------------------------
USE `crf` ;

-- -----------------------------------------------------
-- Table `crf`.`Contacto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crf`.`Contacto` (
  `rua` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL,
  `n_telemovel` VARCHAR(9) NOT NULL,
  `localidade` VARCHAR(45) NOT NULL,
  `cod_postal` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`n_telemovel`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `crf`.`Utente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crf`.`Utente` (
  `id` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `idade` INT NOT NULL,
  `datanascimento` DATE NOT NULL,
  `indice` INT NOT NULL,
  `genero` CHAR NOT NULL,
  `Contacto` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Utente_Contacto1_idx` (`Contacto` ASC) VISIBLE,
  CONSTRAINT `fk_Utente_Contacto1`
    FOREIGN KEY (`Contacto`)
    REFERENCES `crf`.`Contacto` (`n_telemovel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `crf`.`Terapeuta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crf`.`Terapeuta` (
  `idTerapeuta` INT NOT NULL,
  `função` VARCHAR(15) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `Contacto` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`idTerapeuta`),
  INDEX `fk_Terapeuta_Contacto1_idx` (`Contacto` ASC) VISIBLE,
  CONSTRAINT `fk_Terapeuta_Contacto1`
    FOREIGN KEY (`Contacto`)
    REFERENCES `crf`.`Contacto` (`n_telemovel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `crf`.`Médico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crf`.`Médico` (
  `idMédico` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `Contacto` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`idMédico`),
  INDEX `fk_Médico_Contacto_idx` (`Contacto` ASC) VISIBLE,
  CONSTRAINT `fk_Médico_Contacto`
    FOREIGN KEY (`Contacto`)
    REFERENCES `crf`.`Contacto` (`n_telemovel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `crf`.`Material`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crf`.`Material` (
  `stockmin` INT NOT NULL,
  `quantidade` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`nome`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `crf`.`Máquina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crf`.`Máquina` (
  `idMáquina` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `funcional` TINYINT NOT NULL,
  PRIMARY KEY (`idMáquina`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `crf`.`Tratamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crf`.`Tratamento` (
  `data_tratamento` DATE NOT NULL,
  `Tipo` VARCHAR(15) NOT NULL,
  `Descrição` VARCHAR(45) NULL,
  `identificador` INT NOT NULL,
  `idUtente` INT NOT NULL,
  `idMédico` INT NOT NULL,
  `idTerapeuta` INT NULL,
  `preco` FLOAT NOT NULL,
  PRIMARY KEY (`identificador`),
  INDEX `fk_Tratamento_Utente1_idx` (`idUtente` ASC) VISIBLE,
  INDEX `fk_Tratamento_Médico1_idx` (`idMédico` ASC) VISIBLE,
  INDEX `fk_Tratamento_Terapeuta1_idx` (`idTerapeuta` ASC) VISIBLE,
  CONSTRAINT `fk_Tratamento_Utente1`
    FOREIGN KEY (`idUtente`)
    REFERENCES `crf`.`Utente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tratamento_Médico1`
    FOREIGN KEY (`idMédico`)
    REFERENCES `crf`.`Médico` (`idMédico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tratamento_Terapeuta1`
    FOREIGN KEY (`idTerapeuta`)
    REFERENCES `crf`.`Terapeuta` (`idTerapeuta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `crf`.`Terapeuta_has_Material`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crf`.`Terapeuta_has_Material` (
  `idTerapeuta` INT NOT NULL,
  `Material_nome` VARCHAR(45) NOT NULL,
  INDEX `fk_Terapeuta_has_Material_Material1_idx` (`Material_nome` ASC) VISIBLE,
  INDEX `fk_Terapeuta_has_Material_Terapeuta1_idx` (`idTerapeuta` ASC) VISIBLE,
  CONSTRAINT `fk_Terapeuta_has_Material_Terapeuta1`
    FOREIGN KEY (`idTerapeuta`)
    REFERENCES `crf`.`Terapeuta` (`idTerapeuta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Terapeuta_has_Material_Material1`
    FOREIGN KEY (`Material_nome`)
    REFERENCES `crf`.`Material` (`nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `crf`.`Terapeuta_has_Máquina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crf`.`Terapeuta_has_Máquina` (
  `idTerapeuta` INT NOT NULL,
  `idMáquina` INT NOT NULL,
  INDEX `fk_Terapeuta_has_Máquina_Máquina1_idx` (`idMáquina` ASC) VISIBLE,
  INDEX `fk_Terapeuta_has_Máquina_Terapeuta1_idx` (`idTerapeuta` ASC) VISIBLE,
  CONSTRAINT `fk_Terapeuta_has_Máquina_Terapeuta1`
    FOREIGN KEY (`idTerapeuta`)
    REFERENCES `crf`.`Terapeuta` (`idTerapeuta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Terapeuta_has_Máquina_Máquina1`
    FOREIGN KEY (`idMáquina`)
    REFERENCES `crf`.`Máquina` (`idMáquina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- Esquema: CRF
use `crf`;

create schema crf;

drop schema crf;

-- Permissão para fazer operações de remoção de dados.
SET SQL_SAFE_UPDATES = 0;

-- Povoamento da tabela "Utente" 
insert into `crf`.`utente` 
	(id, nome, idade, datanascimento, indice, genero, contacto)
	values
		(0, "Joaquim Ricardo da Silva Campos", 55, "1965-01-22", 2, 'M', "950123456"),
        (1, "Carla Madalena Sepúlveda Pinto", 23, "1997-04-04", 9, 'F', "945627884"),
        (2, "Maria Rita Rodrigues Sousa", 19, "2001-11-08", 7, 'F', "923451226"),
        (3, "Cláudio Gomes Rocha", 28, "1992-03-13", 9, 'M', "925554126"),
        (4, "Mariana Sousa Machado", 20, "2000-10-10", 10, 'M', "916542585"),
        (5, "Cristiano Ronaldo dos Santos Aveiro", 35, "1985-02-05", 10, 'M', "925627410"),
        (6, "Jéssica Marques Oliveira", 19, "2000-12-29", 8, 'F', "962513300"),
        (7, "Joana Gonçalves Faria", 22, "1998-09-02", 5, 'F', "939633004"),
        (8, "António Miguel Lopes Pires", 40, "1980-08-05", 4, 'M', "917475630")
;

select * from utente;
delete from Utente where utente.id = 0;

insert into Médico 
	(idMédico, nome, contacto)
    values
		(0, "Nuno Manuel da Silva Teixeira", "924562411"),
        (1, "Ana Filipa Veiga Pereira", "911230455")
;

select * from Médico;
delete from Médico;

insert into terapeuta 
	(idTerapeuta, função, nome, contacto)
    values
		(0, "Fisioterapeuta", "Ana Cristina Dias Soares", "923514788"),
        (1, "Preparador fisico", "Pedro Miguel Coelho Lopes", "93648222"),
        (2, "Fisioterapeuta", "Rúben Carvalho Ferreira", "932147854"),
        (3, "Preparador fisico", "Maria Natália Gomes Campos", "936998329")
;

select idTerapeuta from terapeuta where nome = "Pedro Miguel Coelho Lopes";
delete from terapeuta;

insert into material
	(stockmin, quantidade, nome)
    values
		(4, 4, "Bola medicinal 4kg"),
        (3, 3, "Bola medicinal 2kg"),
        (4, 6, "Discos 2kg"),
        (6, 6, "Tapete"),
        (2, 1, "Step Aeróbico"),
        (2, 0, "Creme de massagem NIVEA")
;

select nome from material;
select nome from material where quantidade < stockmin;

insert into tratamento
    (data_tratamento, tipo, descrição, identificador, idUtente, idMédico, idTerapeuta, preco)
    values
    ("2020-03-18", "Grave", "Tendinite na virilha", 0, 0, 0, 0, 285.50),
    ("2020-07-06", "Leve", "Deslocação do ombro", 1, 1, 0, 0, 171.80),
    ("2020-08-14", "Muito Grave", "Fratura da clavícula", 2, 2, 1, 2, 440.22),
    ("2020-06-12", "Médio", "Distensão abdominal", 3, 3, 1, 1, 220.40),
    ("2020-01-02", "Muito Leve", "Torção do tornozelo", 4, 4, 0, 3, 189.99),
    ("2020-05-12", "Muito Grave", "Instabilidade na rótula", 5, 5, 0, 0, 420.00),
    ("2020-07-03", "Grave", "Distensão muscular na virilha", 6, 6, 1, 3, 360.70),
    ("2020-09-11", "Muito Grave", "Rotura de ligamentos no joelho", 7, 7, 1, 1, 490.77),
    ("2020-08-02", "Médio", "Rotura de ligamentos no pulso", 8, 8, 0, 0, 310.40),
    ("2020-04-18", "Médio", "Distensão no bícep", 9, 3, 0, 0, 180.99),
    ("2020-06-09", "Leve", "Falta de mobilidade na anca", 10, 6, 1, 0, 120.55),
    ("2020-05-30", "Leve", "Distensão no gémeo", 11, 1, 1, 1, 192.12),
    ("2020-09-28", "Médio", "Distensão muscular nas costas", 12, 4, 0, 1, 220.10)
;

select u.nome, t.data_tratamento, t.tipo, t.Descrição from tratamento as t
	inner join utente as u on t.idUtente = u.id
	where idTerapeuta = 
    (select idTerapeuta from terapeuta where nome = "Pedro Miguel Coelho Lopes")
    order by data_tratamento asc;
   
select data_tratamento, tipo, Descrição, preco from tratamento 
	where idUtente = 
    (select id from utente where nome = "Cristiano Ronaldo dos Santos Aveiro");   
   
select utente.nome from tratamento as t
inner join utente on t.idUtente = utente.id
where t.Tipo = "Médio" 
group by utente.nome 
order by utente.nome asc;

select tratamento.idUtente, utente.nome from tratamento 
inner join utente on tratamento.idUtente = utente.id
where month(tratamento.data_tratamento) <= 8 && month(tratamento.data_tratamento) >= 5
group by utente.nome 
order by utente.nome asc;

insert into máquina
	(idMáquina, nome, funcional)
    values
		(0, "Eletroestimulador", 1),
        (1, "Passadeira", 1),
        (2, "Passadeira", 1),
        (3, "Eletroestimulador", 1),
        (4, "Eletroestimulador", 0)
;

select idMáquina, nome from máquina where funcional = 0; 
select * from Máquina;

insert into contacto
    (rua, email, n_telemovel, localidade, cod_postal)
    values
    ("Rua Fernão Sousa, n 42", "jrcs00@gmail.com", "950123456", "Braga", "4720-444"),
    ("Rua dos Congregados, n 24", "cmsp20@gmail.com", "945627884", "Braga", "4715-424"),
    ("Rua Amélia do Carmo, n 124", "mrrs22@hotmail.com", "923451226", "Braga", "4715-234"),
    ("Rua Sá Valente, n 220", "cgr1212@gmail.com", "925554126", "Braga", "4710-253"),
    ("Rua Mário Fernandes, n 7", "msm.12@gmail.com", "916542585", "Braga", "4715-440"),
    ("Rua das Pereiras, n 42", "crsa33@hotmail.com", "925627410", "Braga", "4720-111"),
    ("Rua Carmo Ferreira, n 88", "jmo.o@gmail.com", "962513300", "Braga", "4715-787"),
    ("Rua Manuel Gomes Faria, n 40", "jgf99@gmail.com", "939633004", "Braga", "4720-777"),
    ("Rua Faria Sousa, n 4", "amlp@hotmail.com", "917475630", "Braga", "4715-567"),
    ("Rua Palmeira Campos, n 200", "nmst@gmail.com", "924562411", "Braga", "4720-890"),
    ("Rua dos Namorados, n 23", "afvp@gmail.com", "911230455", "Braga", "4710-343"),
    ("Rua das Camélias, n 55", "acds33@hotmail.com", "923514788", "Braga", "4715-743"),
    ("Rua dos Congregados, n 20", "pmcl22@gmail.com", "93648222", "Braga", "4720-311"),
    ("Rua dos Capelistas, n 12", "rcf44@gmail.com", "932147854", "Braga", "4715-987"),
    ("Rua Senhora a Branca, n 75", "mngc11@gmail.com", "936998329", "Braga", "4730-874")
;
        
insert into terapeuta_has_material
	(idTerapeuta, Material_nome)
    values
    (0, "Bola medicinal 2kg"),
    (0, "Tapete"),
    (1, "Bola medicinal 4kg"),
    (3, "Step Aeróbico"),
    (2, "Discos 2kg"),
    (1, "Discos 2kg"),
    (0, "Tapete")
;

insert into terapeuta_has_máquina
	(idTerapeuta, idMáquina)
    values
    (0, 0),
    (1, 1),
    (1, 2),
    (2, 4),
    (3, 3),
    (3, 1)
;
 
 delete from stockMateriaisView;
 
 
 -- View Stock 
CREATE VIEW stockMateriaisView AS
    SELECT nome,
        quantidade,
        stockmin
    FROM material
        ORDER BY nome ASC;        
 
delete from stockMateriaisView;
select * from stockMateriaisView;

-- View Contactos Utentes
create view contactosUtentes as
	select u.nome, c.n_telemovel, c.email, c.rua, c.localidade, c.cod_postal 
		from utente as u 
        inner join contacto as c
        on u.contacto = c.n_telemovel;
select * from contactosUtentes;

-- View faturacao
create view infoFaturacao as
	select sum(preco) as 'Total Faturado',
		max(preco) as 'Tratamento mais caro', 
		avg(preco) as 'Preço médio de tratamento', 
		min(preco) as 'Tratamento mais barato', 
		count(preco) as 'Número de tratamentos'
			from tratamento;
