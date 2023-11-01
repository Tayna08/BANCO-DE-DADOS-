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