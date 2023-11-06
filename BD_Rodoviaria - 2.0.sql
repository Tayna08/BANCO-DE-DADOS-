#Sistema para Empresa de Transporte Rodoviario

create database bd_Tarefa1;
use bd_Tarefa1;

create table Estado (
id_est int not null primary key auto_increment,
nome_est varchar (200) not null,
sigla_est varchar (2)
);

create table Cidade (
id_cid int not null primary key auto_increment,
nome_cid varchar (200) not null,
id_est_fk int,
foreign key (id_est_fk) references Estado (id_est)
);

create table Endereço (
id_end integer not null primary key auto_increment,
rua_end varchar (300) not null,
numero_end integer,
bairro_end varchar (100),
cep_end varchar (100),
id_cid_fk int not null,
foreign key (id_cid_fk) references Cidade (id_cid)
); 

create table Sexo (
id_sex int not null primary key auto_increment,
nome_sex varchar (100) not null
);

create table Telefone (
id_tel int not null primary key auto_increment,
celular_tel varchar (100),
casa_tel varchar (100),
trabalho_tel varchar (100)
);

create table Cliente (
id_cli integer not null primary key auto_increment,
nome_cli varchar (200) not null,
estadocivil_cli varchar (50),
cpf_cli varchar (20) not null,
rg_cli varchar (30),
datanasc_cli date,
id_sex_fk integer not null,
id_end_fk integer not null,
id_tel_fk integer not null,
foreign key (id_sex_fk) references Sexo (id_sex),
foreign key (id_end_fk) references Endereço (id_end),
foreign key (id_tel_fk) references Telefone (id_tel)
);

create table Departamento (
id_dep integer not null primary key auto_increment,
nome_dep varchar (100),
descrição_dep varchar (300)
);

create table Funcionario (
id_func integer not null primary key auto_increment,
nome_func varchar (200) not null,
cpf_func varchar (20) not null,
rg_func varchar (20),
datanasc_func date,
salário_func double not null,
função_func varchar (50) not null,
id_sex_fk integer not null,
id_dep_fk integer not null,
id_end_fk integer not null,
id_tel_fk integer not null,
foreign key (id_sex_fk) references Sexo (id_sex),
foreign key (id_dep_fk) references Departamento (id_dep),
foreign key (id_end_fk) references Endereço (id_end),
foreign key (id_tel_fk) references Telefone (id_tel)
);

create table onibus (
id_oni integer not null primary key auto_increment,
modelo_oni varchar (100) not null,
marca_oni varchar (100),
placa_oni varchar (50),
tipo_oni varchar (100)
);

create table Poltrona(
id_pol integer not null primary key auto_increment,
número_pol integer not null,
situação_pol varchar (100) not null,
id_oni_fk integer not null,
foreign key (id_oni_fk) references Onibus (id_oni)
);

create table Trecho_Viagem (
id_tre integer not null primary key auto_increment,
data_part_tre date not null,
data_cheg_tre date not null,
horário_part_tre time not null,
horário_cheg_tre time not null,
distancia_tre float,
tarifa_tre float,
id_cid_origem_fk int not null,
id_cid_destino_fk int not null,
id_oni_fk int not null,
foreign key (id_cid_origem_fk) references Cidade (id_cid),
foreign key (id_cid_destino_fk) references Cidade (id_cid),
foreign key (id_oni_fk) references Onibus (id_oni)
);

create table Passagem (
id_pas integer not null primary key auto_increment,
data_pas date,
valor_pas float,
id_cli_fk integer not null,
id_func_fk integer not null,
id_tre_fk integer not null,
poltrona_pas integer,
foreign key (id_cli_fk) references Cliente (id_cli),
foreign key (id_func_fk) references Funcionario (id_func),
foreign key (id_tre_fk) references Trecho_Viagem (id_tre)
);

create table Caixa (
id_caixa integer not null primary key auto_increment,
dataabertura_caixa date not null,
datafechamento_caixa date,
saldoinicial_caixa double not null,
valorcréditos_caixa double,
valordébitos_caixa double,
saldofinal_caixa double,
id_func_fk int not null,
foreign key (id_func_fk) references Funcionario (id_func)
);

create table Recebimentos (
id_receb integer not null primary key auto_increment,
data_receb date,
valor_receb double,
formapag_receb varchar (100),
id_caixa_fk integer not null,
id_pas_fk integer not null,
foreign key (id_caixa_fk) references Caixa (id_caixa),
foreign key (id_pas_fk) references Passagem (id_pas)
);

#INICIE A PARTIR DAQUI SUA LISTA DE EXERCÍCIOS

#Questão 1:







































insert into estado values (null, 'Amazonas', 'AM');
insert into estado values (null, 'Rondonia', 'RO');

insert into cidade values(null, 'Ouro Preto', 2);
insert into Endereço values (null, 'Rua da alegria', 123, 'Bairro da esperança', '12345-678',1);
insert into Endereço values (null, 'Rua ', 123, 'Bairro', '12345',3);
insert into Sexo values (null, 'feminino');
insert into Telefone values (null, '69993697530', '56', '456321');
insert into Departamento values (null, 'vendedor', 'abc');

insert into Funcionario values(null,'João da Silva', '12345678901', '1234', '1990-01-15', 3000.00, 'Vendedor', 1, 1,3, 1);


select * from departamento;
#3

DELIMITER $$
CREATE PROCEDURE InserirEndereco(rua VARCHAR(300), numero INT, bairro VARCHAR(100), cep VARCHAR(100), cidade_id INT)
BEGIN
    DECLARE fk_cid_id INT;
    set fk_cid_id = (select id_cid from Cidade where id_cid = cidade_id);
    
    IF (fk_cid_id is not null) THEN
   
        INSERT INTO Endereço (rua_end, numero_end, bairro_end, cep_end, id_cid_fk)
        VALUES (rua, numero, bairro, cep, cidade_id);

        SELECT 'Endereço inserido com sucesso!' AS mensagem;
    ELSE
        SELECT 'Código de cidade inválido. Insira um código de cidade válido.' AS mensagem;
    END IF;
END;
$$ DELIMITER ;
CALL InserirEndereco('Rua da alegria', 123, 'Bairro da esperança', '12345-678', 1);
CALL InserirEndereco('Rua do Tony Stark', 456, 'Bairro Lindo', '98765-432', 1);
CALL InserirEndereco('Rua do Stark', 456, 'Bairro ', '987432',1);
CALL InserirEndereco('Stark', 456, 'Bairro a ', '987432',1);
CALL InserirEndereco('Stark', 456, 'Bairro b', '9872',1);
CALL InserirEndereco('Stark', 456, 'Bairro c', '7432',1);
CALL InserirEndereco('Stark', 456, 'Bairro d', '97432',1);
CALL InserirEndereco('Stark', 456, 'Bairro e', '8742',1);
CALL InserirEndereco('Stark', 456, 'Bairro f', '980432',1);
CALL InserirEndereco('Stark', 456, 'Bairro g', '98792',1);








#8
DELIMITER $$
CREATE PROCEDURE InserirFuncionario(nome VARCHAR(200), cpf VARCHAR(20), rg VARCHAR(20), datanasc DATE, salario DOUBLE, funcao VARCHAR(50), sexo_id INT, dep_id INT, end_id INT, telefone_id INT)
BEGIN
    DECLARE fk_end INT;
    DECLARE fk_sex INT;
    DECLARE fk_tel INT;
    DECLARE fk_dep INT;

    SET fk_end = (select id_end from Endereço where id_end = end_id);
    SET fk_sex = (select id_sex from Sexo where id_sex = sexo_id);
    SET fk_tel = (select id_tel from Telefone where id_tel = telefone_id);
    SET fk_dep = (select id_dep from Departamento where id_dep = dep_id);

		 IF (fk_end is not null) THEN
			 IF (fk_sex is not null) THEN
				 IF (fk_tel  is not null) THEN
					 IF (fk_dep is not null) THEN
						 IF (funcao = 'Vendedor' AND fk_dep =!1) THEN
                      INSERT INTO Funcionario (nome_func, cpf_func, rg_func, datanasc_func, salário_func, função_func, id_sex_fk, id_dep_fk, id_end_fk, id_tel_fk)
					  VALUES (nome, cpf, rg, datanasc, salario, funcao, sexo_id, dep_id, end_id, telefone_id);
                        else
					   INSERT INTO Funcionario (nome_func, cpf_func, rg_func, datanasc_func, salário_func, função_func, id_sex_fk, id_dep_fk, id_end_fk, id_tel_fk)
					   VALUES (nome, cpf, rg, datanasc, salario, funcao, sexo_id, dep_id, end_id, telefone_id);
                       end if;
                     else
                      SELECT 'Código de Departamento inválido. Insira um código de Departamento válido.' AS mensagem;
					end if;
				else
                    SELECT 'Código de Telefone inválido. Insira um código de Telefone válido.' AS mensagem;
				end if;
			else
				SELECT 'Código de Sexo inválido. Insira um código de Sexo válido.' AS mensagem;
			end if;
		else
			 SELECT 'Código de Endereço inválido. Insira um código de Endereço válido.' AS mensagem;
		end if;
END;
$$ DELIMITER ;
CALL InserirFuncionario('João da Silva', '12345678901', '1234', '1990-01-15', 3000.00, 'Vendedor', 1, 1, 3, 1);  
CALL InserirFuncionario('João da Silva', '12345678901', '1234', '1990-01-15', 3000.00, 'Vendedor', 1, 2, 5, 1);  

select *from funcionario;




















#Questão 4
delimiter $$
create procedure InserindoDadosSexo (nome varchar(200))
begin
declare sexo1 varchar(100);
set sexo1 = (select nome_sex from Sexo where (nome_sex = nome));

	if(nome <> '') then
		if(sexo1 <> '') then
        
        insert into Sexo values (null, nome);
        select 'O INSERT FUNCIONOU' as Confirmação;
        
        else
        select 'ESSE SEXO JÁ EXISTE' as Erro;
        end if;

	else
    select 'PREENCHA O NOME' as Confirmação;
    end if;
end
$$ delimter ;

call InserindoDadosSexo ('Masculino');
call InserindoDadosSexo ('Feminino');
select * from Sexo;





























#Questão 5
delimiter $$
create procedure InsereTel (celular varchar (100), casa varchar (100), trabalho varchar (100))
begin
if(celular <> '') then
insert into Telefone values (null, celular, casa, trabalho);
select 'O contato foi adicionado com sucesso!!' as SUCESSO;
else
select 'Preencha o campo celular' as ERRO;
end if;
end
$$ delimiter ;

call InsereTel ('(69) 9946-6707', '(69) 9946-6707', '(69) 9946-6707');
call InsereTel ('(69) 99209-6461', '(69) 99209-6461', '(69) 99209-6461');
call InsereTel ('(69) 99927-6914', '(69) 99927-6914', '(69) 99927-6914');
call InsereTel ('(69) 99904-8136', '(69) 99904-8136', '(69) 99904-8136');
call InsereTel ('(69) 99954-1503', '(69) 99954-1503', '(69) 99954-1503');

select * from Telefone;