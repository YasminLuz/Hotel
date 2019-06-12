CREATE DATABASE Hotel
USE Hotel
GO

CREATE TABLE Data(
id_data INT IDENTITY(1,1)PRIMARY KEY,
data_entrada DATETIME,
data_saida DATETIME,
CONSTRAINT CK_Data CHECK (data_entrada < data_saida)
);

CREATE TABLE Reserva(
id_reserva INT IDENTITY(1,1) PRIMARY KEY,
id_responsavel BIGINT NOT NULL,
id_data INT NOT NULL,
id_acomodacao INT UNIQUE NOT NULL,
quant_hospedes TINYINT NOT NULL,
CONSTRAINT FK_responsavel FOREIGN KEY(id_responsavel) REFERENCES Funcionario(id_funcionario_FK),
CONSTRAINT FK_dataReservada FOREIGN KEY(id_data) REFERENCES Data(id_data),
CONSTRAINT FK_acomodacao FOREIGN KEY(id_acomodacao) REFERENCES Acomodacao(id_acomodacao), 
CONSTRAINT CK_QuantHospedes CHECK(quant_hospedes BETWEEN 0 AND 5)
);

CREATE TABLE Telefone(
id_telefone INT  IDENTITY(1,1) PRIMARY KEY,
cod_pais TINYINT NOT NULL,
ddd TINYINT NOT NULL,
residencial INT,
celular INT NOT NULL 
);

CREATE TABLE Endereco(
id_endereco INT IDENTITY(1,1)PRIMARY KEY,
logradouro VARCHAR(50),
numero_bloco VARCHAR(3),
bairro VARCHAR(50),
estado VARCHAR(50),
cidade VARCHAR(50),
complemento VARCHAR(50)
);

CREATE TABLE Pessoa(
cpf BIGINT PRIMARY KEY,
rg BIGINT UNIQUE NOT NULL ,
data_nascimento DATETIME NOT NULL,
nome_completo VARCHAR(100) NOT NULL,
id_endereco INT,
id_telefone INT,
CONSTRAINT FK_id_endereco FOREIGN KEY(id_endereco) REFERENCES Endereco(id_endereco),
CONSTRAINT FK_id_telefone FOREIGN KEY(id_telefone) REFERENCES Telefone(id_telefone)
);

CREATE TABLE Funcionario(
id_funcionario_FK BIGINT PRIMARY KEY,
CONSTRAINT FK_id_funcionario FOREIGN KEY(id_funcionario_FK) REFERENCES Pessoa(cpf),
);

CREATE TABLE Acomodacao(
id_acomodacao INT IDENTITY(1,1) PRIMARY KEY,
tipo VARCHAR(20) NOT NULL,
padrao VARCHAR(20) NOT NULL,
tarifa DECIMAL,
CONSTRAINT CK_Tipo CHECK (tipo IN ('Simples', 'Duplo', 'Triplo')),
CONSTRAINT CK_Padrao CHECK (padrao IN ('Standard', 'Suite', 'Luxo')),
);


--INCLUDES INSERT
INSERT INTO Data VALUES ('26/05/2019','31/05/2019');
INSERT INTO Data VALUES ('10/02/2019','15/02/2019');
INSERT INTO Data VALUES ('18/04/2019','20/04/2019');
INSERT INTO Data VALUES ('08/05/2019','11/05/2019');
INSERT INTO Data VALUES ('24/12/2019','28/12/2019');
INSERT INTO Data VALUES ('25/12/2019','01/01/2020');

INSERT INTO Telefone VALUES (55, 71, null , 995785564);
INSERT INTO Telefone VALUES (55, 75, 32154120, 986274120);
INSERT INTO Telefone VALUES (55, 11, null, 981259788);
INSERT INTO Telefone VALUES (55, 21, 32004120, 999906100);
INSERT INTO Telefone VALUES (55, 71, 25263228,989849966);
INSERT INTO Telefone VALUES (55, 71, 23260526,982009961);

INSERT INTO Endereco VALUES ('Rua Rio de Janeiro', 9, 'Pituba', 'BA', 'Salvador', 'prox a padaria MeGustaPan');
INSERT INTO Endereco VALUES ('Rua Sergipe', 12, 'Marechal Rondon', 'BA', 'Salvador', 'proximo a escola Kimel');
INSERT INTO Endereco VALUES ('Estrada Campinas de Pirajá', 3, 'São Caetano', 'BA', 'Salvador', null);
INSERT INTO Endereco VALUES ('Avenida São Luiz', 25, 'Paripe', 'BA', 'Salvador', null);
INSERT INTO Endereco VALUES ('Loteamento Espaço Alpha', null , 'Bairro Novo', 'BA', 'Camaçari', 'Em frente ao IFBA');
INSERT INTO Endereco VALUES ('R Paulo Barreto', 5, 'Botafogo', 'RJ', 'Rio de Janeiro', 'temos horário de chegada e saída');

INSERT INTO Pessoa VALUES (44721841507, 381951352, '08/09/1984', 'Laís Caroline Marcela da Silva', 6, 4); 
INSERT INTO Pessoa VALUES (04084880507, 210606605, '08/11/1995', 'Eduardo Raimundo de Paula', 2, 1);
INSERT INTO Pessoa VALUES (08710303570, 383784645, '13/04/1995', 'Vitor Julio Vicente Ramos', 5, 2);
INSERT INTO Pessoa VALUES (04047841507, 381951052, '25/12/1989', 'Márcio Aragão', 3, 5);
INSERT INTO Pessoa VALUES (10967613515, 120423455, '20/10/1999', 'Isaac Caleb Brito', 4, 6);
INSERT INTO Pessoa VALUES (54694453564, 249832999, '15/02/1945', 'Marcos Araújo de Carvalho', 1, 3);

INSERT INTO Funcionario VALUES (44721841507);
INSERT INTO Funcionario VALUES (10967613515);
INSERT INTO Funcionario VALUES (04084880507);

INSERT INTO Acomodacao VALUES ('Simples','Standard',300);
INSERT INTO Acomodacao VALUES ('Simples','Standard',300);
INSERT INTO Acomodacao VALUES ('Simples','Standard',300);
INSERT INTO Acomodacao VALUES ('Simples','Standard',300);
INSERT INTO Acomodacao VALUES ('Duplo','Standard',450);
INSERT INTO Acomodacao VALUES ('Duplo','Standard',450);
INSERT INTO Acomodacao VALUES ('Duplo','Standard',450);
INSERT INTO Acomodacao VALUES ('Triplo','Standard',600);
INSERT INTO Acomodacao VALUES ('Triplo','Standard',600);
INSERT INTO Acomodacao VALUES ('Simples','Suite',800);
INSERT INTO Acomodacao VALUES ('Simples','Suite',800);
INSERT INTO Acomodacao VALUES ('Duplo','Suite',1050);
INSERT INTO Acomodacao VALUES ('Simples','Luxo',1200);
INSERT INTO Acomodacao VALUES ('Simples','Luxo',1200);
INSERT INTO Acomodacao VALUES ('Duplo','Luxo',1850);
INSERT INTO Acomodacao VALUES ('Duplo','Luxo',1850);

INSERT INTO Reserva VALUES (44721841507, 3, 12, 2);
INSERT INTO Reserva VALUES (44721841507, 2, 8, 3);
INSERT INTO Reserva VALUES (10967613515, 2, 13, 1);
INSERT INTO Reserva VALUES (04084880507, 2, 14, 2);
INSERT INTO Reserva VALUES (44721841507, 3, 15, 2);
INSERT INTO Reserva VALUES (04084880507, 1, 9, 4);

--DROPS
DROP TABLE Data;
DROP TABLE Reserva;
DROP TABLE Telefone;
DROP TABLE Endereco;
DROP TABLE Pessoa;
DROP TABLE Funcionario;
DROP TABLE Acomodacao;

--QUERIES SELECTOR
SELECT * FROM Data;
SELECT * FROM Reserva;
SELECT * FROM Telefone;
SELECT * FROM Endereco;
SELECT * FROM Pessoa;
SELECT * FROM Funcionario;
SELECT * FROM Acomodacao;

--Procedures
CREATE PROCEDURE p_Ocupados
AS
SELECT id_acomodacao as 'Acomodações ocupadas hoje'
FROM Reserva 
WHERE id_data = (SELECT id_data 
			     FROM Data 
				 WHERE GETDATE() BETWEEN data_entrada AND data_saida);
       
CREATE PROCEDURE p_Disponíveis
AS
SELECT id_acomodacao as 'Acomodações disponíveis hoje'
FROM Acomodacao EXCEPT
SELECT id_acomodacao 
FROM Reserva 
WHERE id_data = (SELECT id_data 
				  FROM Data 
				  WHERE GETDATE() BETWEEN data_entrada AND data_saida);

CREATE PROCEDURE p_Liberacao (@entrada_data DATETIME)
AS
SELECT id_acomodacao as'Liberacao de acomodações'
FROM Reserva
WHERE id_data = (SELECT id_data 
				  FROM Data 
				  WHERE @entrada_data = data_saida);
				   
CREATE PROCEDURE p_Ocupacao (@saida_data DATETIME)
AS
SELECT id_acomodacao as'Ocupação de acomodações'
FROM Reserva
WHERE id_data = (SELECT id_data 
				  FROM Data 
				  WHERE @saida_data = data_entrada);


CREATE PROCEDURE p_Responsavel
AS
SELECT R.id_responsavel, R.id_reserva, nome_completo as'Funcionário responsável'
FROM Reserva as R
INNER JOIN Pessoa as P
ON (R.id_responsavel = P.cpf);

--Execute Procedures
EXEC p_Ocupados;
EXEC p_Disponíveis;
EXEC p_Liberacao --(inserir data de consulta aqui);
EXEC p_Ocupacao --(inserir data de consulta aqui) ;
EXEC p_Responsavel;
