-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
--               BANCO DE DADOS OFICINA                  --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

CREATE DATABASE IF NOT EXISTS Oficina;

USE Oficina;

-- TABELA VEÍCULO  -----------------------OK
CREATE TABLE Veiculo(
	idVeiculo INT auto_increment PRIMARY KEY,
    idRevisao INT,
    Placa CHAR(7) NOT NULL,
    CONSTRAINT placa_idVeiculo UNIQUE (idVeiculo, Placa)
);

	ALTER TABLE Veiculo ADD CONSTRAINT fk_eqpMecanicos_Veiculo -- OK
	FOREIGN KEY (idVeiculo)
	REFERENCES EqpMecanicos(idEqpMecanicos);

	ALTER TABLE Veiculo ADD CONSTRAINT fk_Conserto_Veiculo -- OK
	FOREIGN KEY (idVeiculo)
	REFERENCES Conserto(idConserto);

	ALTER TABLE Veiculo ADD CONSTRAINT fk_Revisao_Veiculo -- OK
	FOREIGN KEY (idRevisao)
	REFERENCES Revisao(idRevisao);

-- DESC Veiculo;

-- TABELA CLIENTES -----------------------------------OK
CREATE TABLE Clientes(
	idClientes INT auto_increment PRIMARY KEY,
    idVeiculo INT
);

	ALTER TABLE Clientes ADD CONSTRAINT fk_Veiculo_Clientes -- ok
	FOREIGN KEY (idVeiculo)
	REFERENCES Veiculo(idVeiculo);

-- DESC Clientes;

-- TABELA PESSOA FÍSICA  ---------------------------------- ok
CREATE TABLE PessoaFisica( 
	idPessoaFisica INT auto_increment PRIMARY KEY,
    Nome VARCHAR(45) NOT NULL,
    CPF CHAR(11) NOT NULL,
    Endereço VARCHAR(45),
    Contato CHAR(11),
    CONSTRAINT unique_cpf_PessoaFisica UNIQUE (CPF)
);

	ALTER TABLE PessoaFisica ADD CONSTRAINT fk_Clientes_PessoaFisica  -- OK
	FOREIGN KEY (idPessoaFisica)
	REFERENCES Clientes(idClientes);

	ALTER TABLE PessoaFisica ADD CONSTRAINT fk_clientes_pf  -- OK
	FOREIGN KEY (idPessoaFisica) 
	REFERENCES Clientes(idClientes);

	ALTER TABLE PessoaFisica ADD CONSTRAINT fk_veiculo_PessoaFisica  -- OK
	FOREIGN KEY (idPessoaFisica)
	REFERENCES Veiculo(idVeiculo);

-- DESC PessoaFisica;

-- TABELA PESSOA JURÍDICA ------------------------------ OK
CREATE TABLE PessoaJuridica(
	idPessoaJuridica INT auto_increment PRIMARY KEY,
    RazaoSocial VARCHAR(45) NOT NULL,
    CNPJ CHAR(15) NOT NULL,
    Endereço VARCHAR(45),
    Contato CHAR(11),
    CONSTRAINT unique_cnpj_PessoaJuridica UNIQUE (CNPJ)
);

	ALTER TABLE PessoaJuridica ADD CONSTRAINT fk_clientes_PessoaJuridica  -- OK
    FOREIGN KEY (idPessoaJuridica)
    REFERENCES Clientes(idClientes);
    
	ALTER TABLE PessoaJuridica ADD CONSTRAINT fk_veiculo_PessoaJuridica  -- OK
    FOREIGN KEY (idPessoaJuridica)
    REFERENCES Veiculo(idVeiculo);

-- DESC PessoaJuridica;

-- TABELA EQUIPE MECÂNICOS     ------------------- OK
CREATE TABLE EqpMecanicos(
	idEqpMecanicos INT auto_increment PRIMARY KEY
);

	ALTER TABLE EqpMecanicos ADD CONSTRAINT fk_Mecanico_EqpMecanicos -- OK
	FOREIGN KEY (idEqpMecanicos)
	REFERENCES Mecanico(idMecanico);

	ALTER TABLE EqpMecanicos ADD CONSTRAINT fk_OdServiço_EqpMecanicos -- OK
	FOREIGN KEY (idEqpMecanicos)
	REFERENCES OdServiço(idOdServiço);

-- DESC EqpMecanicos;

-- TABELA ORDEM DE SERVIÇO      --------------------- OK
CREATE TABLE OdServiço(
	idOdServiço INT auto_increment PRIMARY KEY,
    DataEmissão DATE,
    ValorServiço FLOAT NOT NULL,
    ValorPeça FLOAT NOT NULL,
    ValorTotal FLOAT NOT NULL,
    Status ENUM('AGUARDANDO', 'EM ANDAMENTO', 'CONCLUIDO', 'CANCELADO'),
    DataConclusão DATE
);

	ALTER TABLE OdServiço ADD CONSTRAINT fk_serviços_OdServiço  -- OK
	FOREIGN KEY (idOdServiço)
	REFERENCES Serviços(idServiços);


	ALTER TABLE OdServiço ADD CONSTRAINT fk_os_serviços
	FOREIGN KEY (OdServiço)
	REFERENCES OdServiço(idOdServiço);

-- DESC OdServiço;

-- TABELA REFERÊNCIA DE PREÇOS     ------------- OK
CREATE TABLE ReferenciaPreços(
	idReferenciaPreços INT auto_increment PRIMARY KEY
);

	ALTER TABLE ReferenciaPreços ADD CONSTRAINT fk_OdServiço_ReferenciaPreços -- OK
	FOREIGN KEY (idReferenciaPreços)
	REFERENCES OdServiço(idOdServiço);

-- DESC ReferenciaPreços;

-- TABELA AUTORIZAÇÃO CLIENTE    ---------------- OK
CREATE TABLE Autorização(
	idAutorização INT auto_increment PRIMARY KEY,
	Autorizado BOOL DEFAULT FALSE
);

	ALTER TABLE Autorização ADD CONSTRAINT fk__clientes_autorização -- OK
	FOREIGN KEY (idAutorização)
	REFERENCES Clientes(idClientes);

	ALTER TABLE Autorização ADD CONSTRAINT fk_veiculo_autorização -- OK
	FOREIGN KEY (idAutorização)
	REFERENCES Veiculo(idVeiculo);

	ALTER TABLE Autorização ADD CONSTRAINT fk_OdServiço_autorização -- OK
	FOREIGN KEY (idAutorização)
	REFERENCES OdServiço(idOdServiço);
    
-- DESC Autorização;

-- TABELA ORDEM DE SERVIÇO PEÇAS      ----------------- OK
CREATE TABLE OsPecas(
	idOsPecas INT auto_increment PRIMARY KEY
);

	ALTER TABLE OsPecas ADD CONSTRAINT fk__pecas_Ospecas -- OK
	FOREIGN KEY (idOsPecas)
	REFERENCES Pecas(idPecas);

	ALTER TABLE OsPecas  ADD CONSTRAINT fk_OdServiço_Ospecas -- OK
	FOREIGN KEY (idOsPecas)
	REFERENCES OdServiço(idOdServiço);

-- DESC OsPecas;

-- TABELA CONSERTO       --------------------------------- OK
CREATE TABLE Conserto(
	idConserto INT auto_increment PRIMARY KEY,
    Descrição VARCHAR(45) NOT NULL
);

-- DESC Conserto;

-- TABELA REVISÃO    ------------------------------ OK
CREATE TABLE Revisao(
	idRevisao INT auto_increment PRIMARY KEY,
    Descrição VARCHAR(45) NOT NULL
);

-- DESC Revisao;

-- TABELA MECÂNICO        ---------------- OK
CREATE TABLE Mecanico(
	idMecanico INT auto_increment PRIMARY KEY,
    Nome VARCHAR(45) NOT NULL,
    Endereço VARCHAR(45) NOT NULL,
    Especialidade VARCHAR(45) NOT NULL
);

-- DESC Mecanico;

-- TABELA PEÇAS     --------------------- OK
CREATE TABLE Pecas(
	idPecas INT auto_increment PRIMARY KEY,
    Descrição VARCHAR(45),
    Valor FLOAT NOT NULL
);

-- DESC Pecas;

-- TABEELA SERVIÇOS      --------------------------- OK
CREATE TABLE Serviços(
	idServiços INT auto_increment PRIMARY KEY,
    Descrição VARCHAR(45),
    Valor FLOAT NOT NULL
);

-- DESC Serviços;

/*
show tables;

-- -- -- -- -- -- -- -- -- -- -- -- INSERINDO DADOS -- -- -- -- -- -- -- -- -- -- -- --

INSERT INTO PessoaFisica (idPessoaFisica, nome, cpf, endereço, contato) VALUES
(1, 'Gilmar', 36588767218, 'Rua Pedra Alta, nº 886', '11966378765'),
(2, 'Mariano', 43409865612, 'Rua Santa Rita, nº 233', '11974789937'),
(3, 'Juliana', 35698755615, 'Rua José Bonifácio, nº 218', '11967874356'),
(4, 'Odair', 73718927855, 'Rua Anta Nordestina, nº 513', '11978273908'),
(5, 'Claudia', 35378678419, 'Rua Cogumelo do Sol, 135', '11989656723');

INSERT INTO Veiculo (idVeiculo, idRevisao, Placa) VALUES 
(1, 1, 'GFD1765'),
(2, 2, 'KKD8845'),
(3, 3, 'BJS3441'),
(4, 4, 'QQP6734'),
(5, 5, 'DVL3488');

INSERT INTO Conserto (idConserto, descricao) VALUES 
(1, 'Motor falhando'),
(2, 'Freio de mão quebrado'),
(3, 'Painel não acende'),
(4, 'Barulho rodas dianteiras'),
(5, 'Elétrica com mau contato');
                            
INSERT INTO Mecanico (idMecanico, nome, endereco, especialidade) VALUES	
(1, 'Ademilson', 'Rua Sabiá, nº 33', 'Mecânico Geral'),
(2, 'José', 'Rua da Pamonha, n° 10', 'Eletricista'),
(3, 'Manoel', 'Rua Águas Claras, n° 345', 'Mecânico Geral'),
(4, 'Roberto', 'Rua São Joaquim, nº 115', 'Eletricista'),
(5, 'Anderson', 'Rua do Curupira, nº 823', 'Funilaria');

INSERT INTO OdServiço (idOdServiço, DataEmissão, ValorServiço, ValorPeça, ValorTotal, status, DataConclusão) VALUES 	
(1, '2023/07/08', '250.00', '150.00', '400.00', 'AGUARDANDO', NULL),
(2, '2023/06/11', '200.00', '100.00', '300.00', 'CONCLUIDO', '2023/06/12'),
(3, '2023/08/22', '350.00', '250.00', '600.00', 'EM ANDAMENTO', NULL),
(4, '2023/08/26', '400.00', '300.00', '700.00', 'CONCLUIDO', '2023/09/07'),
(5, '2023/07/25', '500.00', '350.00', '850.00', 'CANCELADO', NULL);
                                
INSERT INTO Autorização (idAutorização, Autorizado) VALUES 
(1, TRUE),
(2, TRUE),
(3, FALSE),
(4, TRUE),
(5, FALSE);
                                
INSERT INTO Pecas (idPecas, Descrição, Valor) VALUES 	-- ok
(1, 'Rolamento da direção', '150.00'),
(2, 'Jogo de velas', '100.00'),
(3, 'Volante', '250.00'),
(4, 'Caixa eletrica de fusíveis', '300.00'),
(5, 'Jogo lanternas traseiras', '350.00');
                                
INSERT INTO Serviços (idServiços, Descrição, Valor) VALUES 	-- ok
(1, 'Troca do rolamento da direção', '250.00'),
(2, 'Troca jogo de velas', '200.00'),
(3, 'Troca do volante', '350.00'),
(4, 'Troca da caixa eletrica de fusíveis', '400.00'),
(5, 'Troca de jogo lanternas traseiras', '500.00');

-- -- -- -- -- -- -- -- -- -- -- -- FAZENDO CONSULTAS -- -- -- -- -- -- -- -- -- -- -- --

SELECT * FROM PessoaFisica;

SELECT * FROM Veiculo;

SELECT * FROM Conserto;

SELECT * FROM Mecanico;

SELECT * FROM OdServiço;

SELECT * FROM Autorização;

SELECT * FROM Pecas;

SELECT * FROM Serviços;

SELECT Autorização.Autorizado, OdServiço.idOdServiço, Clientes.idClientes
FROM Autorização
CROSS JOIN OdServiço, Clientes; 

*/
