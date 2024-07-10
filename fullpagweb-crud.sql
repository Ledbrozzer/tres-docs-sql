create database CRUD;
use CRUD;

create table Personal
(
Nome varchar(255),
Email varchar(255),
CPF_Personal int primary key,
Contato integer,
Sexo char(1) check((Sexo) in('M', 'F', 'm', 'f')),
Estado char(2),
Cidade varchar(255),
Idade integer,
Senha varchar(255)
);


create table Acesso
(
ID_Acesso int primary key,
Estado_Relacao varchar(50)
);

create table Agenda
(
 ID_Agenda int primary key,
 Data_Conclusao date,
 Data_Realizacao date,
 Horario_Encontro time
);

create table Exercicio
(
ID_Exercicio int primary key,
Nome_Exercicio varchar(255),
Grupamento_Muscular varchar(255),
Series int,
Repeticoes int,
Tecnica varchar(255),
Descanco_Segundos numeric
);

create table Treino
(
ID_Treino int primary key,
Local_Treino varchar(255),
Tempo_Treino numeric,
Total_Series int
);

create table Avaliacao
(
ID_Avaliacao int primary key,
Nome_Avaliacao varchar(255),
Objetivo_Avaliacao varchar(255)
);

create table Formulario
(
ID_Formulario int primary key,
Nome_Formulario varchar(255),
Objetivo_Formulario varchar(255),
Numero_Questoes int
);

create table Status_Formulario
(
ID_Status_Formulario int primary key,
Situacao_da_Atividade varchar(255),
Feedback_Formulario varchar(255)
);

create table Status_Avaliacao
(
ID_Status_Avaliacao int primary key,
Situacao_da_Avaliacao varchar(255),
Resultado_Avaliacao varchar(255),
Feedback_Avaliacao varchar(255)
);

create table Status_Treino
(
ID_Status_Treino int primary key,
Situacao_do_Treino varchar(255),
Observacoes_Treino varchar(255),
Feedback_Treino varchar(255)
);

create table Acompanhamento
(
ID_Acompanhamento int primary key,
Inicio_Acompanhamento date
);

create table Resultado_Acompanhamento
(
ID_Resultado_Acompanhamento int primary key,
Inicio_Observacao_Data date,
Especificacao_da_Observacao varchar(255),
Valor_Resultado numeric,
Descricao_Resultado varchar(255),
Durante_Observacao_Data date,
Especificacao_Observacao_Durante varchar(255),
Valor_Resultado_Durante numeric,
Descricao_Resultado_Durante varchar(255),
Ultima_Observacao_Data date,
Especificacao_Ultima_Observacao varchar(255),
Valor_Ultimo_Resultado numeric,
Descricao_Ultimo_Resultado varchar(255),
Final_Protocolo_Data date,
Observacao_Final varchar(255),
Valor_Resultado_Final numeric,
Descricao_Resultado_Final varchar(255)
);