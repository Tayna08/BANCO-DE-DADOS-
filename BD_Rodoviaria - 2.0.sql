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

delimiter $$
create procedure InserirEstado (nome varchar(300), sigla varchar(300))
begin
    declare InserirEstado int;
    set InserirEstado = (select nome_est from Estado where (nome_est = nome));
  
  if InserirEstado = 0 then
   insert into Estado (nome_est, sigla_est) values (nome_est, sigla_est); 
   
    select 'O Registro foi inserido com sucesso!' as Confirmacao;
    
 else
 
    select 'Já contém um estado com esse nome. Insira um nome de estado válido!' as Alerta;
    
 end if;
 
end;
 
$$ delimiter ;
    
call InserirEstado('Rondônia', 'RO');
call InserirEstado('Mato Grosso', 'MT');
call InserirEstado('Acre', 'AC');
call InserirEstado('Amazonas', 'AM');
call InserirEstado('Mato Grosso do Sul', 'MS');

select * from Estado;


#Questão 6:

delimiter $$
create procedure InserirCliente (nome varchar(300), estado_civil varchar(300), cpf varchar(300), rg varchar(300), data_nascimento date, fk_sex int, fk_end int, fk_tel int)
begin
declare id_end int;
declare id_sex int;
declare id_tel int;

set id_end = (select id_end from Endereço where (id_end = id_end_fk));
set id_sex = (select id_sex from Sexo where (id_sex = id_sex_fk));
set id_tel = (select id_tel from Telefone where (id_tel = id_tel_fk));

if (id_end > 0) then
   if (id_sex > 0) then
      if (id_tel > 0) then
 insert into Cliente values (nome_cli, estadocivil_cli, cpf_cli, rg_cli, datanasc_cli, id_sex_fk, id_end_fk, id_tel_fk);
 
select concat('O Cliente', nome, 'foi salvo com sucesso!') as Confirmacao;
else
  select 'O campo NOME é obrigatório!' as Alert;
end if;

select concat('O Endereco_FK', id_end, 'Foi salvo com sucesso!') as Confirmacao;
else
  select 'A FK informada não existe na tabela Endereço!' as Alerta;
end if;

select concat('O Sexo_FK', id_sex, 'Foi salvo com sucesso!') as Confirmacao;
else
  select 'A FK informada não existe na tabela Sexo!' as Alerta;
end if;
end;

select concat('O Telefone_FK', id_tel, 'Foi salvo com sucesso!') as Confirmacao;
else
  select 'A FK informada não existe na tabela Telefone!' as Alerta;
end if;

$$ delimiter ;

Call InserirCliente('Bruce Banner', 'Casado', '111.111.111-11', '5465489', '20-06-1987', 1, 1, 1);
Call InserirCliente('Rodrigo Hilbert', 'Casado', '111.111.111-22','8429473', '30-07-1982', 2, 2, 2); 
Call InserirCliente('Tiago Lacerda', 'Casado', '111.111.111-33', '8429384', '29-09-1998', 3, 3, 3);
Call InserirCliente('Tom Cruise', 'Solteiro', '222.222.222-88', '8293847', '24-01-1970', 4, 4, 4);
Call InserirCliente('Marcos Araujo de Souza', 'Casado', '522.222.153-15', '8923942', '28-01-1980', 5, 5, 5);

select * from Cliente;










































insert into estado values (null, 'Amazonas', 'AM');
insert into cidade values(null, 'Manaus', 1);
insert into Endereço values (null, 'Rua da alegria', 123, 'Bairro da esperança', '12345-678',1);

select * from endereço;

#3

DELIMITER $$
CREATE PROCEDURE InserirEndereco(rua_end VARCHAR(300), numero_end INT, bairro_end VARCHAR(100), cep_end VARCHAR(100), id_cid_fk INT)
BEGIN
    DECLARE id_cid INT;
    set id_cid = (select id_cid from cidade where (id_cid = id_cid_fk));
    
    IF (id_cid >0) THEN
    
        INSERT INTO Endereço (rua_end, numero_end, bairro_end, cep_end, id_cid_fk)
        VALUES (rua_end, numero_end, bairro_end, cep_end, id_cid_fk);

        SELECT 'Endereço inserido com sucesso!' AS mensagem;
    ELSE
        SELECT 'Código de cidade inválido. Insira um código de cidade válido.' AS mensagem;
    END IF;
END;
$$ DELIMITER ;
CALL InserirEndereco('Rua da alegria', 123, 'Bairro da esperança', '12345-678', 3);
CALL InserirEndereco('Rua do Tony Stark', 456, 'Bairro Lindo', '98765-432', 2);




























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