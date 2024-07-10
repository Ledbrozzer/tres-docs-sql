create table Aluno
(
ID_Aluno int primary key,
Nome varchar(50) check(patindex('%[^A-Za-z ]%', Nome) = 0) not null,
Email varchar(100) check(charindex('@', Email) > 0 and charindex('.', Email) > charindex('@', Email)) not null unique,
Idade int check(Idade >= 6 and Idade <=110) not null,
Data_Nascimento date check(year(Data_Nascimento) >= 1900 and year(Data_Nascimento) <= year(getdate())) not null, --date 13 codigo - DD/MM/AAAA
Sexo char(1) check(upper(Sexo) = 'M' or upper(Sexo) = 'F') not null,
Peso_kg numeric(3, 2) check(Peso_kg > 0) not null, --weight
Altura_cm numeric(3, 2) check(Altura_cm >= 50 and Altura_cm <= 250) not null,
Estado char(2) check(upper(Estado) in('AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE')) not null,
Cidade varchar(50) not null
);


create table Personal
(
ID_Personal int primary key,
CPF int check(len(cast(CPF as varchar (11))) = 11) not null unique,
Nome varchar(100) check(patindex('%[^A-Za-z ]%', Nome) = 0) not null,
Email varchar(100) check(charindex('@', Email) > 0 and charindex('.', Email) > charindex('@', Email)) not null,
Idade int check(Idade >= 18 and Idade <= 110) not null,
Data_Nascimento date check(year(Data_Nascimento) >= 1900 and year(Data_Nascimento) <= year(getdate()))not null,--date 13 codigo - DD/MM/AAAA
Sexo CHAR(1) check(upper(Sexo) = 'M' or upper(Sexo) = 'F') not null,
Estado char(2) check(upper(Estado) in('AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE')) not null,
Cidade varchar(50) not null,
Contato bigint check(len(cast(Contato as varchar(10))) = 10 and Contato not like'%[^0-9]%'),
Plano bit check(Plano in(0, 1)) not null
);


create table Material_Treino
(
ID_Material_Treino int primary key,
Nome_Material varchar(255) not null
);


create table Movimento_Articular
(
ID_Movimento_Articular int primary key,
Nome_Popular varchar(255) not null,
Nome_Articulacao varchar(255) not null,
Movimento_da_Articulacao varchar(255) not null
);


create table Exercicio_Complemento
(
ID_Exercicio_Complemento int primary key,
Nome_Complemento varchar(255) not null
);


create table Maquina_Complemento
(
ID_Maquina_Complemento int primary key,
Nome_Complemento varchar(255) not null
);


create table Tipo_de_Peso
(
ID_Tipo_de_Peso int primary key,
Formato varchar(255) not null
);


create table Fase_Treino
(
ID_Fase_Treino int primary key,
Descricao varchar(255) not null
);


create table Exercicio
(
ID_Exercicio int primary key,
ID_Personal int foreign key(ID_Personal) references Personal(ID_Personal) not null,
ID_Fase_Treino int foreign key(ID_Fase_Treino) references Fase_Treino(ID_Fase_Treino) not null,
Grupo_Muscular varchar(255) not null, ---Add check(musculos lista)
ID_Movimento_Articular int foreign key(ID_Movimento_Articular) references Movimento_Articular(ID_Movimento_Articular) not null,
ID_Maquina_Complemento int foreign key(ID_Maquina_Complemento) references Maquina_Complemento(ID_Maquina_Complemento) not null,
ID_Exercicio_Complemento int foreign key(ID_Exercicio_Complemento) references Exercicio_Complemento(ID_Exercicio_Complemento) not null,
ID_Tipo_de_Peso int foreign key(ID_Tipo_de_Peso) references Tipo_de_Peso(ID_Tipo_de_Peso) not null,
ID_Material_Treino int foreign key(ID_Material_Treino) references Material_Treino(ID_Material_Treino),
Series int check(Series >= 2) not null,
Repeticoes int check(Repeticoes between 1 and 150) not null,
Tempo_Descanco_Segundos numeric(3, 2) check(Tempo_Descanco_Segundos between 30 and 600) not null,
Tecnica_Utilizada varchar(255),---add check(tÈcnicas lista)
Nome_Exercicio varchar(255),
Data_Envio datetime default getdate() not null check(Data_Envio <= getdate())
);


create table Treino
(
ID_Treino int primary key,
ID_Personal int foreign key(ID_Personal) references Personal(ID_Personal) not null,
ID_Exercicio int foreign key(ID_Exercicio) references Exercicio(ID_Exercicio) not null,
Atividade_Fisica_Realizada varchar(100) not null,
Carga_Tipo char(2) check(lower(Carga_Tipo) in ('es', 'rg', 'ch', 'ct')) not null,
Div_Tr char(6) check(upper(Div_Tr) in ('AB', 'ABC', 'ABCDE', 'ABCDEF', 'BLITZ', 'AA', 'AAA', 'FULLB', 'PP')) not null,
Controle_EPE int check(Controle_EPE > 0 or Controle_EPE <= 10) not null,
Tempo_Treino_Minutos numeric(6, 2) check(Tempo_Treino_Minutos between 1 and 300) not null,
Total_Exercicios int check(Total_Exercicios >= 1) not null,
Total_Series int check(Total_Series >= 2) not null,
Data_Envio datetime default getdate() not null check(Data_Envio <= getdate())
);
----Controle EPE = Controle da Escala de PercepÁ„o de EsforÁo.


create table Categoria_Avaliacao
(
ID_Categoria_Avaliacao int primary key,
Nome varchar(255) not null,
Objetivo varchar(255) not null
);


create table Avaliacao
(
ID_Avaliacao int primary key,
ID_Personal int foreign key(ID_Personal) references Personal(ID_Personal) not null,
ID_Categoria_Avaliacao int foreign key(ID_Categoria_Avaliacao) references Categoria_Avaliacao(ID_Categoria_Avaliacao) not null,
Nome_Teste varchar(255) not null,
Teste_Parametros varchar(255) not null,
Ultimo_Teste_Parametros varchar(255),
Ultimo_Teste_Valor numeric(12, 2) check(Ultimo_Teste_Valor >= 0),
Ultimo_Teste_Classificacao varchar(100),
Ultimo_Teste_Data date check(Ultimo_Teste_Data <= getdate()),
Melhor_Resultado_Teste varchar(255),
Material_Equipamento varchar(255) not null,
Data_Envio_Avaliacao datetime not null default getdate() check(Data_Envio_Avaliacao <= getdate())
);


create table Formulario
(
ID_Formulario int primary key,
ID_Personal int foreign key(ID_Personal) references Personal(ID_Personal),
Tipo varchar(255) not null,--add check(tipos list)
Objetivo varchar(255) not null,
Destaque_Questoes varchar(255) not null,
Numero_Questoes int check(Numero_Questoes between 1 and 100) not null,
Data_Envio_Formulario datetime not null default getdate() check(Data_Envio_Formulario <= getdate())
);


create table Acesso
(
ID_Acesso int primary key,
ID_Aluno int foreign key(ID_Aluno) references Aluno(ID_Aluno) not null,
ID_Personal int foreign key(ID_Personal) references Personal(ID_Personal) not null,
Situacao_Atual char(7) check(upper(Situacao_Atual) = 'ATIVA' or upper(Situacao_Atual) = 'FECHADA')
);


create table Agenda
(
ID_Agenda int primary key,
ID_Acesso int foreign key(ID_Acesso) references Acesso(ID_Acesso),
ID_Personal int foreign key(ID_Personal) references Personal(ID_Personal) not null,
ID_Formulario int foreign key(ID_Formulario) references Formulario(ID_Formulario),
ID_Avaliacao int foreign key(ID_Avaliacao) references Avaliacao(ID_Avaliacao),
ID_Treino int foreign key(ID_Treino) references Treino(ID_Treino),
Agenda_Data date not null check(Agenda_Data >= getdate()),
Endereco varchar(255) not null,
Nome_Estabelecimento varchar(255),
Horario_Inicio time not null,
Horario_Termino time not null, --check(Horario_Termino > Horario_Inicio) {N„o t· suportando a restriÁ„o check a outra coluna},
Hora_Aula decimal(5, 2) not null check(Hora_Aula > 0),
Momento_Planejamento varchar(50) not null check((Momento_Planejamento) in ('Inicio do Planejamento', 'Durante o Planejamento', 'Final do Planejamento')),
Data_Envio_Agenda datetime default getdate() not null check(Data_Envio_Agenda <= getdate()),
check(Horario_Inicio < Horario_Termino)
);


create table Status_Formulario
(
ID_Status_Formulario int primary key,
ID_Personal int foreign key(ID_Personal) references Personal(ID_Personal) not null,
ID_Formulario int foreign key(ID_Formulario) references Formulario(ID_Formulario) not null,
ID_Agenda int foreign key(ID_Agenda) references Agenda(ID_Agenda) not null,
Descricao_Status varchar(255) not null check((Descricao_Status) in ('Concluido', 'N„o Concluido')),
Destaque varchar(255) not null
);


create table Status_Avaliacao
(
ID_Status_Avaliacao int primary key,
ID_Personal int foreign key(ID_Personal) references Personal(ID_Personal) not null,
ID_Agenda int foreign key(ID_Agenda)  references Agenda(ID_Agenda) not null,
ID_Avaliacao int foreign key(ID_Avaliacao) references Avaliacao(ID_Avaliacao) not null,
Descricao_Status varchar(255) not null check((Descricao_Status) in ('Concluido', 'N„o Concluido', 'Concluido com Dificuldades')),
Teste_Valor numeric(12, 2) not null,
Teste_Classificacao varchar(255)
);


create table Status_Treino
(
ID_Status_Treino int primary key,
ID_Personal int foreign key(ID_Personal) references Personal(ID_Personal) not null,
ID_Treino int foreign key(ID_Treino) references Treino(ID_Treino) not null,
ID_Agenda int foreign key(ID_Agenda) references Agenda(ID_Agenda) not null,
Descricao_Status varchar(255) not null check((Descricao_Status) in ('Concluido', 'N„o Concluido', 'Concluido com Dificuldades'))
);


create table Acompanhamento
(
ID_Acompanhamento int primary key,
ID_Personal int foreign key(ID_Personal) references Personal(ID_Personal) not null,
ID_Acesso int foreign key(ID_Acesso) references Acesso(ID_Acesso) not null,
ID_Status_Avaliacao int foreign key(ID_Status_Avaliacao) references Status_Avaliacao(ID_Status_Avaliacao),
ID_Status_Treino int foreign key(ID_Status_Treino) references Status_Treino(ID_Status_Treino),
ID_Status_Formulario int foreign key(ID_Status_Formulario) references Status_Formulario(ID_Status_Formulario),
ID_Agenda int foreign key(ID_Agenda) references Agenda(ID_Agenda) not null,
ID_Avaliacao int foreign key(ID_Avaliacao) references Avaliacao(ID_Avaliacao),
ID_Treino int foreign key(ID_Treino) references Treino(ID_Treino),
ID_Formulario int foreign key(ID_Formulario) references Formulario(ID_Formulario),
Inicio_Acompanhamento date
);


alter table Aluno
add
ID_Personal int not null,
ID_Acesso int not null,
constraint ID_Personal foreign key(ID_Personal) references Personal(ID_Personal),
constraint ID_Acesso foreign key(ID_Acesso) references Acesso(ID_Acesso);

-----Values:
insert into Categoria_Avaliacao(ID_Categoria_Avaliacao, Nome, Objetivo)
values
(1, 'Teste de 1RM', 'Adequar a PrescriÁ„o de Treinamento, com  nfase no Treinamento de ForÁa'),
(2, 'AvaliaÁ„o Fisica: ForÁa Muscular', 'DiagnÛstico para PrescriÁ„o Adequada do Treinamento'),
(3, 'Medidas AntropomÈtricas', 'Verificar o Tamanho das SecÁıes Transversas e Dimensıes do Corpo'),
(4, 'ComposiÁ„o Corporal', 'Identificar os Valores Relativos ou Absolutos dos Componentes Corporais'),
(5, 'An·lise Postural', 'CorreÁ„o e PrevenÁ„o de Possiveis Lesıes/AlteraÁıes Corporais'),
(6, 'Medidas Neuromotoras', 'Avaliar as Capacidades e o Desenvolvimento'),
(7, 'Medidas MetabÛlicas', '¡nalisar e Obter Valores Metabolicos e de FunÁıes, para Adquar o Treinamento'),
(8, 'Teste de FCm·x', 'Obter a FrequÍncia CardÌaca Maxima'),
(9, 'Teste de VO2m·x', 'Obter o Volume de OxigÍnio Maximo'),
(10, 'PR - Personal Record', 'Manter Registro das Metas e Marcas do Praticante');


insert into Fase_Treino(ID_Fase_Treino, Descricao)
values
(1, 'Aquecimento'),
(2, 'Parte Principal'),
(3, 'Parte Final');


insert into Tipo_de_Peso(ID_Tipo_de_Peso, Formato)
values
(1, 'Anilha'),
(2, 'Barra'),
(3, 'Dumbell'),
(4, 'Kettlebell'),
(5, 'Bloco'),
(6, 'Halter'),
(7, 'Peso Corporal'),
(8, 'IsocinÈtico');


insert into Maquina_Complemento(ID_Maquina_Complemento, Nome_Complemento)
values
(1, 'M·quina Articulada'),
(2, 'M·quina'),
(3, 'Plataforma'),
(4, 'Leg Press'),
(5, 'Cadeira'),
(6, 'M·quina 4 Apoios'),
(7, 'Mesa'),
(8, 'Smith'),
(9, 'Polia'),
(10, 'Banco Articulado'),
(11, 'Peso Livre'),
(12, 'Barra'),
(13, 'Graviton'),
(14, 'Peck Deck'),
(15, 'Fly'),
(16, 'M·quina IsocinÈtica'),
(17, 'M·quina(TraÁ„o)');


insert into Exercicio_Complemento(ID_Exercicio_Complemento, Nome_Complemento)
values
(1, 'Barra W'),
(2, 'Barra H'),
(3, 'Barra Reta'),
(4, 'Tri‚ngulo'),
(5, 'Unilateral'),
(6, 'Alternado'),
(7, 'Simult‚neo'),
(8, 'Corda'),
(9, 'Baixa'),
(10, 'MÈdia'),
(11, 'Alta'),
(12, 'Bloco'),
(13, 'Pronada'),
(14, 'Supinada'),
(15, 'Neutra'),
(16, 'Fixa'),
(17, 'Movel'),
(18,'Banco'),
(19, 'Inclinado'),
(20, '45∞'),
(21, '30∞'),
(22, '60∞'),
(23, '75∞'),
(24, '90∞'),
(25, 'Vertical'),
(26, 'Horizontal'),
(27, 'Paralela'),
(28, 'Passada'),
(29, 'Passada Lateral(CrabWalk)'),
(30, 'Extensora'),
(31, 'Flexora'),
(32, 'Adutora'),
(33, 'Abdutora');


insert into Movimento_Articular(ID_Movimento_Articular, Nome_Popular, Nome_Articulacao, Movimento_da_Articulacao)
values
(1, 'Ombro', 'GlenoUmeral, AcromioClavicular, EsternoClavicular, EscapuloTor·cica', ' Flex„o de Ombros'),
(2, 'Ombro', 'GlenoUmeral, AcromioClavicular, EsternoClavicular, EscapuloTor·cica', 'Extens„o de Ombros'),
(3, 'Ombro', 'GlenoUmeral, AcromioClavicular, EsternoClavicular, EscapuloTor·cica', 'AduÁ„o de Ombros'),
(4, 'Ombro', 'GlenoUmeral, AcromioClavicular, EsternoClavicular, EscapuloTor·cica', 'AbduÁ„o de Ombros'),
(5, 'Ombro', 'GlenoUmeral, AcromioClavicular, EsternoClavicular, EscapuloTor·cica', 'AduÁ„o Horizontal de Ombros'),
(6, 'Ombro', 'GlenoUmeral, AcromioClavicular, EsternoClavicular, EscapuloTor·cica', 'AbduÁ„o Horizontal de Ombros'),
(7, 'Ombro', 'GlenoUmeral, AcromioClavicular, EsternoClavicular, EscapuloTor·cica', 'RotaÁ„o Interna dos Ombros'),
(8, 'Ombro', 'GlenoUmeral, AcromioClavicular, EsternoClavicular, EscapuloTor·cica', 'RotaÁ„o Externa dos Ombros'),
(9, 'Esc·pula', 'Esc·pulo-Tor·cica ou Esc·pulo-Costal', 'AduÁ„o/RetraÁ„o das Esc·pulas'),
(10, 'Esc·pula', 'Esc·pulo-Tor·cica ou Esc·pulo-Costal', 'AbduÁ„o/ProtraÁ„o das Esc·pulas'),
(11, 'Esc·pula', 'Esc·pulo-Tor·cica ou Esc·pulo-Costal', 'ElevaÁ„o das Esc·pulas'),
(12, 'Esc·pula', 'Esc·pulo-Tor·cica ou Esc·pulo-Costal', 'Depress„o das Esc·pulas'),
(13, 'Esc·pula', 'Esc·pulo-Tor·cica ou Esc·pulo-Costal', 'RotaÁ„o para/ Cima (Esc·pula)'),
(14, 'Esc·pula', 'Esc·pulo-Tor·cica ou Esc·pulo-Costal', 'RotaÁ„o para/ Baixo (Esc·pula)'),
(15, 'Cotovelo', '⁄mero Ulnar, UmeroRradial, R·dio Ulnar', 'Flex„o de Cotovelo'),
(16, 'Cotovelo', '⁄mero Ulnar, UmeroRradial, RadioUlnar', 'Extens„o de Cotovelo'),
(17, 'Punho', 'RadioUlnar Distal, R·dio-C·rpica', 'Flex„o de Punho'),
(18, 'Punho', 'RadioUlnar Distal, R·dio-C·rpica', 'Extens„o de Punho'),
(19, 'Punho', 'RadioUlnar Distal, R·dio-C·rpica', 'AduÁ„o de Punho'),
(20, 'Punho', 'RadioUlnar Distal, R·dio-C·rpica', 'AbduÁ„o de Punho'),
(21, 'Quadril', 'CoxoFemoral', 'Flex„o de Quadril'),
(22, 'Quadril', 'CoxoFemoral', 'Extens„o de Quadril'),
(23, 'Quadril', 'CoxoFemoral', 'AduÁ„o de Quadril'),
(24, 'Quadril', 'CoxoFemoral', 'AbduÁ„o de Quadril'),
(25, 'Quadril', 'CoxoFemoral', 'RotaÁ„o Interna de Quadril'),
(26, 'Quadril', 'CoxoFemoral', 'RotaÁ„o Externa de Quadril'),
(27, 'Joelho', 'TibioFemoral, PateloFemoral', 'Flex„o de Joelhos'),
(28, 'Joelho', 'TibioFemoral, PateloFemoral', 'Extens„o de Joelhos'),
(29, 'Joelho', 'TibioFemoral, PateloFemoral', 'RotaÁ„o Interna do Joelhos'),
(30, 'Joelho', 'TibioFemoral, PateloFemoral', 'RotaÁ„o Externa do Joelhos'),
(31, 'Tornozelo', 'TaloCrural, TaloCalcaneonavicular, Subtalar', 'Flex„o Plantar'),
(32, 'Tornozelo', 'TaloCrural, TaloCalcaneonavicular, Subtalar', 'DorsiFlex„o'),
(33, 'Coluna', 'Artic. Intervertebrais, Artic. Cartilaginosas, Artic. Atlanto-Occipital, Artic. AtlantoAxial', 'Flex„o da Coluna'),
(34, 'Coluna', 'Artic. Intervertebrais, Artic. Cartilaginosas, Artic. Atlanto-Occipital, Artic. AtlantoAxial', 'Extens„o da Coluna'),
(35, 'Coluna', 'Artic. Intervertebrais, Artic. Cartilaginosas, Artic. Atlanto-Occipital, Artic. AtlantoAxial', 'Flex„o Lateral da Coluna'),
(36, 'Coluna', 'Artic. Intervertebrais, Artic. Cartilaginosas, Artic. Atlanto-Occipital, Artic. AtlantoAxial', 'RotaÁ„o da Coluna');


insert into Material_Treino(ID_Material_Treino, Nome_Material)
values
(1, 'Corrente'),
(2, 'Caneleira de Peso'),
(3, 'Kettlebell'),
(4, 'Escada de agilidade'),
(5, 'Corda Naval'),
(6, 'Corda'),
(7, 'Mini Band'),
(8, 'Elastico'),
(9, 'Faixa(ProteÁ„o)'),
(10, 'Cinto de TraÁ„o'),
(11, 'Bola SuÌÁa'),
(12, 'MedicineBall'),
(13, 'SandBag'),
(14, 'Step'),
(15, 'Colchonete');





-----Procedures:
create procedure Novo_Exercicio
(
@ID_Exercicio int,
@ID_Personal int,
@ID_Fase_Treino int,
@Grupo_Muscular varchar(255),
@ID_Movimento_Articular int,
@ID_Maquina_Complemento int,
@ID_Exercicio_Complemento int,
@ID_Tipo_de_Peso int,
@ID_Material_Treino int,
@Series int,
@Repeticoes int,
@Tempo_Descanco_Segundos numeric(3, 2),
@Tecnica_Utilizada varchar(255),
@Nome_Exercicio varchar(255),
@Data_Envio datetime = null
)
as
begin
if @Data_Envio is null
set @Data_Envio = getdate()

insert into Exercicio
(
ID_Exercicio,
ID_Personal,
ID_Fase_Treino,
Grupo_Muscular,
ID_Movimento_Articular,
ID_Maquina_Complemento,
ID_Exercicio_Complemento,
ID_Tipo_de_Peso,
ID_Material_Treino,
Series,
Repeticoes,
Tempo_Descanco_Segundos,
Tecnica_Utilizada,
Nome_Exercicio,
Data_Envio
)
values
(@ID_Exercicio, @ID_Personal, @ID_Fase_Treino, @Grupo_Muscular, @ID_Movimento_Articular, @ID_Maquina_Complemento, @ID_Exercicio_Complemento, @ID_Tipo_de_Peso,
@ID_Material_Treino, @Series, @Repeticoes, @Tempo_Descanco_Segundos, @Tecnica_Utilizada, @Nome_Exercicio, @Data_Envio)
end;


--Procedure p/ Criar Treino
create procedure Criar_Treino
(
@ID_Treino int,
@ID_Personal int,
@ID_Exercicio int,
@Atividade_Fisica_Realizada varchar(100),
@Carga_Tipo char(2),
@Div_Tr char(6),
@Controle_EPE int,
@Tempo_Treino_Minutos numeric(6, 2),
@Total_Exercicios int,
@Data_Envio datetime = null
)
as
begin
if @Data_Envio is null
set @Data_Envio = getdate()
insert into Treino
(ID_Treino, ID_Personal, ID_Exercicio, Atividade_Fisica_Realizada, Carga_Tipo, Div_Tr, Controle_EPE, Tempo_Treino_Minutos, Total_Exercicios, Data_Envio)
values
(@ID_Treino,
@ID_Personal,
@ID_Exercicio,
@Atividade_Fisica_Realizada,
@Carga_Tipo,
@Div_Tr,
@Controle_EPE,
@Tempo_Treino_Minutos,
@Total_Exercicios,
@Data_Envio)
end;


--Procedure Cadastrar Personal
create procedure Cadastrar_Personal
(
@ID_Personal int,
@CPF int,
@Nome varchar(100),
@Email varchar(100),
@Idade int,
@Data_Nascimento date,
@Sexo char(1),
@Estado char(2),
@Cidade varchar(50),
@Contato numeric,
@Plano bit
)
as
begin
insert into Personal
(ID_Personal, CPF, Nome, Email, Idade, Data_Nascimento, Sexo, Estado, Cidade, Contato, Plano)
values
(@ID_Personal,
@CPF,
@Nome,
@Email,
@Idade,
@Data_Nascimento,
@Sexo,
@Estado,
@Cidade,
@Contato,
@Plano)
end;


--Procedure p/ Cadastrar Aluno
create procedure Cadastrar_Aluno
(@ID_Aluno int,
@Nome varchar(50),
@Email varchar(100),
@Idade int,
@Data_Nascimento date,
@Sexo char(1),
@Peso_kg numeric(3, 2),
@Altura_cm numeric(3, 2),
@Estado char(2),
@Cidade varchar(50))
as
begin
insert into Aluno(ID_Aluno, Nome, Email, Idade, Data_Nascimento, Sexo, Peso_kg, Altura_cm, Estado, Cidade)
values
(@ID_Aluno,
@Nome,
@Email,
@Idade,
@Data_Nascimento,
@Sexo,
@Peso_kg,
@Altura_cm,
@Estado,
@Cidade)
end;


--Procedure p/ Criar AvaliaÁ„o
create procedure Nova_Avaliacao
(
@ID_Avaliacao int,
@ID_Personal int,
@ID_Categoria_Avaliacao int,
@Nome_Teste varchar(255),
@Teste_Paramentros varchar(255),
@Ultimo_Teste_Parametros varchar(255),
@Ultimo_Teste_Valor numeric(12, 2),
@Ultimo_Teste_Classificacao varchar(100),
@Ultimo_Teste_Data date,
@Melhor_Resultado_Teste varchar(255),
@Material_Equipamento varchar(255),
@Data_Envio_Avaliacao datetime = null
)
as
begin
if @Data_Envio_Avaliacao is null
set @Data_Envio_Avaliacao = getdate()
insert into Avaliacao(ID_Avaliacao, ID_Personal, ID_Categoria_Avaliacao, Nome_Teste, Teste_Parametros, Ultimo_Teste_Parametros, Ultimo_Teste_Valor, Ultimo_Teste_Classificacao, Ultimo_Teste_Data, Melhor_Resultado_Teste, Material_Equipamento, Data_Envio_Avaliacao)
values
(@ID_Avaliacao,
@ID_Personal,
@ID_Categoria_Avaliacao,
@Nome_Teste,
@Teste_Paramentros,
@Ultimo_Teste_Parametros,
@Ultimo_Teste_Valor,
@Ultimo_Teste_Classificacao,
@Ultimo_Teste_Data,
@Melhor_Resultado_Teste,
@Material_Equipamento,
@Data_Envio_Avaliacao)
end;


--Procedure Criar Formul·rio
create procedure Novo_Formulario
(
@ID_Formulario int,
@ID_Personal int,
@Tipo varchar(255),
@Objetivo varchar(255),
@Destaque_Questoes varchar(255),
@Numero_Questoes int,
@Data_Envio_Formulario datetime = null
)
as
begin
if @Data_Envio_Formulario is null
set @Data_Envio_Formulario = getdate()
insert into Formulario(ID_Formulario, ID_Personal, Tipo, Objetivo, Destaque_Questoes, Numero_Questoes, Data_Envio_Formulario)
values
(@ID_Formulario,
@ID_Personal,
@Tipo,
@Objetivo,
@Destaque_Questoes,
@Numero_Questoes,
@Data_Envio_Formulario)
end;


--Procedure Inserir na Agenda
create procedure Inserir_Agenda
(
@ID_Agenda int,
@ID_Acesso int,
@ID_Personal int,
@ID_Formulario int,
@ID_Avaliacao int,
@ID_Treino int,
@Agenda_Data date,
@Endereco varchar(255),
@Nome_Estabelecimento varchar(255),
@Horario_Inicio time,
@Horario_Termino time,
@Hora_Aula decimal(5, 2),
@Momento_Planejamento varchar(50),
@Data_Envio_Agenda datetime = null
)
as
begin
if @Data_Envio_Agenda is null
set @Data_Envio_Agenda = getdate()
insert into Agenda(ID_Agenda, ID_Acesso, ID_Personal, ID_Formulario, ID_Avaliacao, ID_Treino, Agenda_Data, Endereco, Nome_Estabelecimento, Horario_Inicio, Horario_Termino, Hora_Aula, Momento_Planejamento, Data_Envio_Agenda)
values
(@ID_Agenda,
@ID_Acesso,
@ID_Personal,
@ID_Formulario,
@ID_Avaliacao,
@ID_Treino,
@Agenda_Data,
@Endereco,
@Nome_Estabelecimento,
@Horario_Inicio,
@Horario_Termino,
@Hora_Aula,
@Momento_Planejamento,
@Data_Envio_Agenda)
end;


--Procedure Inserir Status - Treino
create procedure Informar_Status_Treino
(
@ID_Status_Treino int,
@ID_Personal int,
@ID_Treino int,
@ID_Agenda int,
@Descricao_Status varchar(255)
)
as
begin
insert into Status_Treino(
ID_Status_Treino, ID_Personal, ID_Treino, ID_Agenda, Descricao_Status
)
values
(@ID_Status_Treino, @ID_Personal, @ID_Treino, @ID_Agenda, @Descricao_Status)
end;


--Procedure Inserir Status - AvaliaÁ„o
create procedure Informar_Status_Avaliacao
(
@ID_Status_Avaliacao int,
@ID_Personal int,
@ID_Agenda int,
@ID_Avaliacao int,
@Descricao_Status varchar(255),
@Teste_Valor numeric(12, 2),
@Teste_Classificacao varchar(255)
)
as
begin
insert into Status_Avaliacao
(ID_Status_Avaliacao, ID_Personal, ID_Agenda, ID_Avaliacao, Descricao_Status, Teste_Valor, Teste_Classificacao)
values
(@ID_Status_Avaliacao,
@ID_Personal,
@ID_Agenda,
@ID_Avaliacao,
@Descricao_Status,
@Teste_Valor,
@Teste_Classificacao)
end;


--Procedure Inserir Status - Formul·rio
create procedure Informar_Status_Formulario
(
@ID_Status_Formulario int,
@ID_Personal int,
@ID_Formulario int,
@ID_Agenda int,
@Descricao_Status varchar(255),
@Destaque varchar(255)
)
as
begin
insert into Status_Formulario(ID_Status_Formulario, ID_Personal, ID_Formulario, ID_Agenda, Descricao_Status, Destaque)
values
(@ID_Status_Formulario,
@ID_Personal,
@ID_Formulario,
@ID_Agenda,
@Descricao_Status,
@Destaque)
end;


--Procedure Incluir Acompanhamento
create procedure Incluir_Acompanhamento
(
@ID_Acompanhamento int,
@ID_Personal int,
@ID_Acesso int,
@ID_Status_Avaliacao int,
@ID_Status_Treino int,
@ID_Status_Formulario int,
@ID_Agenda int,
@ID_Avaliacao int,
@ID_Treino int,
@ID_Formulario int,
@Inicio_Acompanhamento date
)
as
begin
insert into Acompanhamento(
ID_Acompanhamento, ID_Personal, ID_Acesso, ID_Status_Avaliacao, ID_Status_Treino, ID_Status_Formulario, ID_Agenda, ID_Avaliacao, ID_Treino, ID_Formulario, Inicio_Acompanhamento
)
values
(@ID_Acompanhamento,
@ID_Personal,
@ID_Acesso,
@ID_Status_Avaliacao,
@ID_Status_Treino,
@ID_Status_Formulario,
@ID_Agenda,
@ID_Avaliacao,
@ID_Treino,
@ID_Formulario,
@Inicio_Acompanhamento)
end;


--Procedure Cadastrar Acesso
create procedure Cadastrar_Acesso
(
@ID_Acesso int,
@ID_Aluno int,
@ID_Personal int,
@Situacao_Atual char(7)
)
as
begin
insert into Acesso(ID_Acesso, ID_Aluno, ID_Personal, Situacao_Atual)
values
(@ID_Acesso,
@ID_Aluno,
@ID_Personal,
@Situacao_Atual)
end;



---Procedures p/ Atualizar Cadastros
--Aluno
create procedure Atualizar_Aluno
@ID_Aluno int,
@Nome varchar(255),
@Email varchar(255),
@Idade int,
@Data_Nascimento date,
@Sexo char(1),
@Peso_kg numeric(3, 2),
@Altura_cm numeric(3, 2),
@Estado char(2),
@Cidade varchar(50)
as
begin
begin try
update Aluno
set Nome = @Nome, Email = @Email, Idade = @Idade, Data_Nascimento = @Data_Nascimento, Sexo = @Sexo, Peso_kg = @Peso_kg, Altura_cm = @Altura_cm, Estado = @Estado, Cidade = @Cidade
where ID_Aluno = @ID_Aluno

if @@rowcount = 0
print 'Nenhum ALUNO foi Atualizado!'
else
print 'ALUNO Atualizado com Sucesso!'
end try
begin catch
print 'Ocorreu um Erro ao Atualizar o ALUNO!'
end catch
end;


--Personal
create procedure Atualizar_Personal
@ID_Personal int,
@CPF int,
@Nome varchar(255),
@Email varchar(255),
@Idade int,
@Data_Nascimento date,
@Sexo char(1),
@Estado char(2),
@Cidade varchar(50),
@Contato numeric,
@Plano bit
as
begin
if @Nome = '' or @Sexo not in('M', 'F')
begin
print 'NOME e SEXO s„o campos obrigatÛrios.'
return
end
if @Plano not in(0, 1)
begin
print 'PLANO deve ser 0 ou 1!'
return
end
if charindex('@', @Email) = 0 or charindex('.', @Email) < charindex('@', @Email)
begin
print 'Email INV¡LIDO!'
return
end
if patindex('%[^A-Za-z ]%', @Nome) <> 0
begin
print 'Nome sÛ pode conter LETRAS e ESPA«OS!!'
return
end
if len(cast(@Contato as varchar(10))) <> 10 or @Contato like '%[^0-9]%'
begin
print 'Contato Deve ser um N˙mero de 10 DÕGITOS!'
return
end
if len(cast(@CPF as varchar (11))) <> 11
begin
print 'CPF Deve ter 11 DÌgitos!!'
return
end
begin try
update Personal
set Nome = @Nome, CPF = @CPF, Email = @Email, Idade = @Idade, Data_Nascimento = @Data_Nascimento, Sexo = @Sexo, Estado = @Estado, Cidade = @Cidade, Contato = @Contato, Plano = @Plano
where ID_Personal = @ID_Personal

if @@rowcount = 0
print 'Nenhum PERSONAL foi Atualizado!'
else
print 'PERSONAL Atualizado com Sucesso!'
end try
begin catch
print 'Ocorreu um Erro ao Atualizar o PERSONAL!'
end catch
end;


---Acesso
create procedure Atualizar_Acesso
@ID_Acesso int,
@ID_Aluno varchar(255),
@ID_Personal int,
@Situacao_Atual char(7)
as
begin
begin try
update Acesso
set ID_Aluno = @ID_Aluno, ID_Personal = @ID_Personal, Situacao_Atual = @Situacao_Atual
where ID_Acesso = @ID_Acesso

if @@rowcount = 0
print 'Nenhum ACESSO foi Atualizado!'
else
print 'ACESSO Atualizado com Sucesso!'
end try
begin catch
print 'Ocorreu um Erro ao Atualizar o ACESSO!'
end catch
end;


--Agenda
create procedure Atualizar_Agenda
@ID_Agenda int,
@ID_Acesso int,
@ID_Personal int,
@ID_Formulario int,
@ID_Avaliacao int,
@ID_Treino int,
@Agenda_Data date,
@Endereco varchar(255),
@Nome_Estabelecimento varchar(255),
@Horario_Inicio time,
@Horario_Termino time,
@Hora_Aula decimal(5, 2),
@Momento_Planejamento varchar(50),
@Data_Ultima_Alteracao datetime = null
as
begin
if @Data_Ultima_Alteracao is null
set @Data_Ultima_Alteracao = getdate()
begin try
update Agenda
set ID_Acesso = @ID_Acesso, ID_Personal = @ID_Personal, ID_Formulario = @ID_Formulario,
ID_Avaliacao = @ID_Avaliacao, ID_Treino = @ID_Treino, Agenda_Data = @Agenda_Data,
Endereco = @Endereco, Nome_Estabelecimento = @Nome_Estabelecimento, Horario_Inicio = @Horario_Inicio,
Horario_Termino = @Horario_Termino, Hora_Aula = @Hora_Aula, Momento_Planejamento = @Momento_Planejamento, Data_Envio_Agenda = @Data_Ultima_Alteracao
where ID_Agenda = @ID_Agenda

if @@rowcount = 0
print 'Nenhum REGISTRO da AGENDA foi Atualizado!'
else
print 'O REGISTRO da AGENDA Atualizado com Sucesso!'
end try
begin catch
print 'Ocorreu um Erro ao Atualizar o REGISTRO da AGENDA!'
end catch
end;



---Procedures p/ Remover Valores
--Aluno
create procedure Remover_Aluno
@ID_Aluno int
as
begin
delete from Acesso where ID_Aluno = @ID_Aluno;
delete from Aluno where ID_Aluno = @ID_Aluno;
end;


--Acompanhamento
create procedure Remover_Acompanhamento
@ID_Acompanhamento int
as
begin
delete from Acompanhamento
where ID_Acompanhamento =@ID_Acompanhamento
end;


--Agenda
create procedure Remover_Agenda
@ID_Agenda int
as
begin
delete from Status_Treino where ID_Agenda = @ID_Agenda
delete from Status_Formulario where ID_Agenda = @ID_Agenda
delete from Status_Avaliacao where ID_Agenda = @ID_Agenda;
delete from Acompanhamento where ID_Agenda = @ID_Agenda;
delete from Agenda where ID_Agenda = @ID_Agenda;
end;


--Acesso
create procedure Remover_Acesso
@ID_Acesso int
as
begin
    -- Deletar registros filhos
    delete from Acompanhamento where ID_Acesso = @ID_Acesso;
    delete from Agenda where ID_Acesso = @ID_Acesso;
    delete from Acesso where ID_Acesso = @ID_Acesso;
end;




------------------Triggers:
create trigger checkNomeMaterial
on Material_Treino
after insert, update
as
begin
if exists (select 1 from inserted where Nome_Material like '%[^a-z·ÈÌÛ˙·ËÏÚ˘‚ÍÓÙ˚„ıÁA-Z¡…Õ”⁄¿»Ã“Ÿ¬ Œ‘€√’« ]%')
begin
raiserror ('Nome_Material contÈm caracteres inv·lidos', 16, 1);
rollback transaction;
return;
end
end;



----------------Trigger p/ controlar inserÁ„o de caracteres.
create trigger checkMovimentoArticular
on Movimento_Articular
after insert, update
as
begin
if exists (
select 1 from inserted where Nome_Popular like '%[^a-z·ÈÌÛ˙·ËÏÚ˘‚ÍÓÙ˚„ıÁA-Z¡…Õ”⁄¿»Ã“Ÿ¬ Œ‘€√’« ]%'
or Nome_Articulacao like '%[^a-z·ÈÌÛ˙·ËÏÚ˘‚ÍÓÙ˚„ıÁA-Z¡…Õ”⁄¿»Ã“Ÿ¬ Œ‘€√’« ]%'
or Movimento_da_Articulacao like '%[^a-z·ÈÌÛ˙·ËÏÚ˘‚ÍÓÙ˚„ıÁA-Z¡…Õ”⁄¿»Ã“Ÿ¬ Œ‘€√’« ]%'
)
begin
raiserror ('Os Valores Inseridos contÍm Caracteres Inv·lidos', 16, 1);
rollback transaction;
return;
end
end;



------------Trigger p/ integridade de dados(Treino/Exercicio).
create trigger checkTotalSeriesandExercicios on Treino
after insert, update---Trigger È disparada apÛs cada insert/update in "Treino"
as
begin
declare @Total_Series int, @Total_Exercicios int, @ID_Exercicio int, @ID_Treino int;
select @Total_Series = sum(Series) from Exercicio where ID_Exercicio = @ID_Exercicio;
select @Total_Exercicios = count(*) from Exercicio where ID_Exercicio = @ID_Exercicio;
---Verifica se "Total_Series"(in "Treino") = "Series"("Exercicio") + "Series"...
---Verifica se "Total_Exercicio"(in "Treino") = "Exercicio" + "Exercicio"...
if exists (
select 1
from Treino
where ID_Treino = @ID_Treino
and
(Total_Series != @Total_Series or Total_Exercicios != @Total_Exercicios)
)
begin
raiserror('Total de Series ou Total de Exercicios est· Incorreto!!', 16, 1);
rollback transaction;
return;
end
end;



-----------Trigger p/ integridade dados-Tempo|Min|Treino.
create trigger checkTempoTreino on Treino
after insert, update
as
begin
declare @Tempo_Treino decimal(6, 2), @Tempo_Descanco_Total decimal(6, 2), @ID_Exercicio int, @ID_Treino int;
select @ID_Treino = ID_Treino, @ID_Exercicio = ID_Exercicio, @Tempo_Treino = Tempo_Treino_Minutos from inserted;

select @Tempo_Descanco_Total = isnull(sum(Tempo_Descanco_Segundos) / 60.0, 0)
from Exercicio
where ID_Exercicio = @ID_Exercicio;

if @Tempo_Treino < @Tempo_Descanco_Total
begin
raiserror('O Tempo de Treino È Menor do que o Total do Tempo de Descanso!!', 16, 1);
rollback transaction;
return;
end
end;



-------------Trigger Verifica Horario_Termino e Horario_Inicio
create trigger Verifica_Horario on Agenda
after insert, update
as
begin
    if exists (select 1 from inserted where Horario_Inicio >= Horario_Termino)
    begin
        raiserror('Horario_Inicio deve ser menor do que Horario_Termino!', 16, 1);
        rollback transaction;
        return;
    end
end;



---------------Trigger p/ Barrar InserÁ„o no Acompanhamento se o Plano È 0
create trigger checkPersonal_Plano_Acompanhamento
on Acompanhamento
after insert
as
begin
declare @ID_Personal int;
declare @Plano bit;

select @ID_Personal = ID_Personal from inserted;
select @Plano = Plano from Personal
where ID_Personal = @ID_Personal;

if @Plano = 0
begin
raiserror('Um Personal com Plano = 0 n„o pode Adicionar Dados ao Acompanhamento!', 16, 1);
rollback transaction;
return;
end
end;



---------------Trigger p/ barrar inserÁ„o na Agenda se o Plano È 0
create trigger checkPersonal_Plano
on Agenda
after insert
as
begin
declare @ID_Personal int;
declare @Plano bit;

select @ID_Personal = ID_Personal from inserted;
select @Plano = Plano from Personal where ID_Personal = @ID_Personal;

if @Plano = 0
begin
raiserror('Um Personal com Plano = 0 n„o pode adicionar dados ‡ Agenda!', 16, 1);
rollback transaction;
return;
end
end;



-----------Trigger p/ Controlar SituaÁ„o do ID_Acesso
create trigger Anular_Relacao
on Acesso
after insert
as
begin
declare @Situacao_Atual varchar(7);
declare @ID_Aluno int;
declare @ID_Personal int;
select @Situacao_Atual = Situacao_Atual, @ID_Aluno = ID_Aluno, @ID_Personal = ID_Personal from inserted;
if upper(@Situacao_Atual) = 'FECHADA'
begin
raiserror('A SitauÁ„o Atual da RelaÁ„o est· "FECHADA"!', 16, 1);
rollback transaction;
return;
end
end;



-------------------Trigger p/ Verificar Professor/Personal
create trigger Verificar_Personal
on Acesso
after insert, update
as
begin
declare @ID_Aluno int;
declare @Personal_Existente int;

select @ID_Aluno = ID_Aluno from inserted;
select @Personal_Existente = count(*) from Acesso where ID_Aluno = @ID_Aluno;
if @Personal_Existente > 0
begin
raiserror('Um Aluno N„o Pode ter Mais de Um Professor', 16, 1);
rollback transaction;
end
end;



--------------
create trigger checkPlanobeforeinsert
on Acompanhamento
instead of insert
as
begin
if exists(select 1 from inserted i
join Personal p
on i.ID_Personal = p.ID_Personal
where p.Plano = 0)
begin
raiserror('Um Personal com Plano = 0 n„o pode ser associado a um Acompanhamento!', 16, 1);
return;
end
else
begin
insert into Acompanhamento
select* from inserted;
end
end;



create trigger checkPersonalPlanobeforeupdatedois
on Acompanhamento
instead of update
as
begin
if exists(select 1 from inserted i
join Personal p
on i.ID_Personal = p.ID_Personal
where p.Plano = 0)
begin
raiserror('Um Personal com Plano = 0 n„o pode ser associado a um Acompanhamento!!', 16, 1);
return;
end
else
begin
update Acompanhamento set ID_Personal = i.ID_Personal
from Acompanhamento a
join inserted i
on a.ID_Acompanhamento = i.ID_Acompanhamento;
end
end;



----------------------
create trigger checkPersonalPlanoupdateAluno
on Aluno
instead of update
as
begin
if exists(select 1 from inserted i
join Personal p
on i.ID_Personal = p.ID_Personal
where p.Plano = 0)
begin
raiserror('Um Personal com Plano = 0 n„o pode ser associado a um Aluno!!', 16, 1);
return;
end
else
begin
update Aluno set ID_Personal = i.ID_Personal
from Aluno a
join inserted i
on a.ID_Aluno = i.ID_Aluno;
end
end;



-------------------Trigger p/ Verificar o Plano do Personal
create trigger checkPlano_Treino on Treino
instead of insert
as
begin
    if exists (select 1 from inserted i join Personal p on i.ID_Personal = p.ID_Personal where p.Plano = 0)
    begin
        raiserror('Um Personal com Plano = 0 n„o pode adicionar dados ao Treino!', 16, 1);
        return;
    end
    else
    begin
        insert into Treino select * from inserted;
    end
end;


create trigger checkPlano_Avaliacao on Avaliacao
instead of insert
as
begin
    if exists (select 1 from inserted i join Personal p on i.ID_Personal = p.ID_Personal where p.Plano = 0)
    begin
        raiserror('Um Personal com Plano = 0 n„o pode adicionar dados na Avaliacao!', 16, 1);
        return;
    end
    else
    begin
        insert into Avaliacao select * from inserted;
    end
end;



-----------------------Cursores:
---Cursor Aluno
declare @ID_Aluno int,
@Nome_Aluno varchar(50),
@Email_Aluno varchar(100),
@Data_Nascimento_Aluno date,
@Sexo_Aluno char(1);
declare Aluno_Cursor cursor for
select ID_Aluno, Nome, Email, Data_Nascimento, Sexo
from Aluno

open Aluno_Cursor

fetch next from Aluno_Cursor into @ID_Aluno, @Nome_Aluno, @Email_Aluno, @Data_Nascimento_Aluno, @Sexo_Aluno

while @@fetch_status = 0
begin
    print 'ID_Aluno: ' + cast(@ID_Aluno as varchar(10)) + ', Nome: ' + @Nome_Aluno + ', Email: ' + @Email_Aluno +  ', Data de Nascimento: ' + convert(varchar, @Data_Nascimento_Aluno, 103) + ', Sexo: ' + @Sexo_Aluno

    fetch next from Aluno_Cursor into @ID_Aluno, @Nome_Aluno, @Email_Aluno, @Data_Nascimento_Aluno, @Sexo_Aluno
end

close Aluno_Cursor
deallocate Aluno_Cursor



---Cursor Personal
declare @ID_Personal int,
@CPF int,
@Nome_Personal varchar(255),
@Email_Personal varchar(255),
@Contato bigint,
@Plano bit;
declare Personal_Cursor cursor for
select ID_Personal, CPF, Nome, Email, Contato, Plano
from Personal;

open Personal_Cursor;

fetch next from Personal_Cursor into @ID_Personal, @CPF, @Nome_Personal, @Email_Personal, @Contato, @Plano;

while @@fetch_status = 0
begin
    print 'ID_Personal: ' + cast(@ID_Personal as varchar(10)) + ', Nome: ' + @Nome_Personal + ', Email: ' + @Email_Personal + ', Contato: ' + cast(@Contato as varchar(10)) + ', Plano: ' + cast(@Plano as varchar(1))
    print @Nome_Personal;

    fetch next from Personal_Cursor into @ID_Personal, @CPF, @Nome_Personal, @Email_Personal, @Contato, @Plano;
end;

close Personal_Cursor;
deallocate Personal_Cursor;



---Cursor Listar Protocolo de Treino
declare @ID_Aluno int,
@Nome_Aluno varchar(50),
@Email_Aluno varchar(100),
@ID_Personal int,
@Nome_Personal varchar(255),
@Email_Personal varchar(255),
@ID_Treino int,
@Atividade_Fisica_Realizada varchar(100);
declare Personal_Treino_Cursor cursor for
select A.ID_Aluno, A.Nome, A.Email, P.ID_Personal, P.Nome, P.Email, T.ID_Treino, T.Atividade_Fisica_Realizada
from Aluno A
join Personal P on A.ID_Personal = P.ID_Personal
join Treino T on P.ID_Personal = T.ID_Personal;

open Personal_Treino_Cursor;

fetch next from Personal_Treino_Cursor into @ID_Aluno, @Nome_Aluno, @Email_Aluno, @ID_Personal, @Nome_Personal, @Email_Personal, @ID_Treino, @Atividade_Fisica_Realizada;

while @@fetch_status = 0
begin
    print 'ID_Aluno: ' + cast(@ID_Aluno as varchar(10)) + ', Nome_Aluno: ' + @Nome_Aluno + ', Email_Aluno: ' + @Email_Aluno;
    print 'ID_Personal: ' + cast(@ID_Personal as varchar(10)) + ', Nome_Personal: ' + @Nome_Personal + ', Email_Personal: ' + @Email_Personal;
    print 'ID_Treino: ' + cast(@ID_Treino as varchar(10)) + ', Atividade_Fisica_Realizada: ' + @Atividade_Fisica_Realizada;

    fetch next from Personal_Treino_Cursor into @ID_Aluno, @Nome_Aluno, @Email_Aluno, @ID_Personal, @Nome_Personal, @Email_Personal, @ID_Treino, @Atividade_Fisica_Realizada;
end;

close Personal_Treino_Cursor;
deallocate Personal_Treino_Cursor;



----Cursor Listar Treinos na Agenda
declare @ID_Aluno int,
@Nome_Aluno varchar(50),
@Email_Aluno varchar(100),
@ID_Personal int,
@Nome_Personal varchar(255),
@Email_Personal varchar(255),
@ID_Treino int,
@Atividade_Fisica_Realizada varchar(100),
@Nome_Exercicio varchar(255);
declare Treino_Exercicio_Cursor cursor for
select A.ID_Aluno, A.Nome, A.Email, P.ID_Personal, P.Nome, P.Email, T.ID_Treino, T.Atividade_Fisica_Realizada, E.Nome_Exercicio
from Aluno A
join Personal P on A.ID_Personal = P.ID_Personal
join Treino T on P.ID_Personal = T.ID_Personal
join Exercicio E on T.ID_Exercicio = E.ID_Exercicio;

open Treino_Exercicio_Cursor;

fetch next from Treino_Exercicio_Cursor into @ID_Aluno, @Nome_Aluno, @Email_Aluno, @ID_Personal, @Nome_Personal, @Email_Personal, @ID_Treino, @Atividade_Fisica_Realizada, @Nome_Exercicio;

while @@fetch_status = 0
begin
    print 'ID_Aluno: ' + cast(@ID_Aluno as varchar(10)) + ', Nome_Aluno: ' + @Nome_Aluno + ', Email_Aluno: ' + @Email_Aluno;
    print 'ID_Personal: ' + cast(@ID_Personal as varchar(10)) + ', Nome_Personal: ' + @Nome_Personal + ', Email_Personal: ' + @Email_Personal;
    print 'ID_Treino: ' + cast(@ID_Treino as varchar(10)) + ', Atividade_Fisica_Realizada: ' + @Atividade_Fisica_Realizada;
    print 'Nome_Exercicio: ' + @Nome_Exercicio;

    fetch next from Treino_Exercicio_Cursor into @ID_Aluno, @Nome_Aluno, @Email_Aluno, @ID_Personal, @Nome_Personal, @Email_Personal, @ID_Treino, @Atividade_Fisica_Realizada, @Nome_Exercicio;
end;

close Treino_Exercicio_Cursor;
deallocate Treino_Exercicio_Cursor;



----Cursor Listar RelaÁıes
declare @ID_Aluno int,
@Nome_Aluno varchar(50),
@ID_Personal int,
@Nome_Personal varchar(100);
declare Relacoes_Cursor cursor for
select P.ID_Personal, P.Nome, A.ID_Aluno, A.Nome
from Personal P
join Acesso AC on P.ID_Personal = AC.ID_Personal
join Aluno A on AC.ID_Aluno = A.ID_Aluno;

open Relacoes_Cursor;

fetch next from Relacoes_Cursor into @ID_Personal, @Nome_Personal, @ID_Aluno, @Nome_Aluno;

while @@fetch_status = 0
begin
    print 'ID_Personal: ' + cast(@ID_Personal as varchar(10)) + ', Nome_Personal: ' + @Nome_Personal;
    print 'ID_Aluno: ' + cast(@ID_Aluno as varchar(10)) + ', Nome_Aluno: ' + @Nome_Aluno;

    fetch next from Relacoes_Cursor into @ID_Personal, @Nome_Personal, @ID_Aluno, @Nome_Aluno;
end;

close Relacoes_Cursor;
deallocate Relacoes_Cursor;



--------------------Transactiorns:
--



--------------------Indices Cluesterizados e Indices N„o Clusterizados:
--create clustered index ix_Nome_Popular on Movimento_Articular(Nome_Popular);--Index Movimento_Articular

create nonclustered index ix_Nome_Articulacao on Movimento_Articular(Nome_Articulacao);

create index idx_Aluno_Nome on Aluno(Nome);--Index Aluno

create index idx_Aluno_Email on Aluno(Email);

create index idx_Aluno_Estado on Aluno(Estado);

create index idx_Personal_Nome on Personal(Nome);--Index Personal

create index idx_Personal_Email on Personal(Email);

create index idx_Personal_Estado on Personal(Estado);

create index idx_Exercicio_ID_Personal on Exercicio(ID_Personal);--Index Exercicio

create index idx_Exercicio_ID_Fase_Treino on Exercicio(ID_Fase_Treino);

create index idx_Exercicio_Grupo_Muscular on Exercicio(Grupo_Muscular);

create index idx_Treino_ID_Personal on Treino(ID_Personal);--Index Treino

create index idx_Treino_ID_Exercicio on Treino(ID_Exercicio);

create index idx_Avaliacao_ID_Personal on Avaliacao(ID_Personal);--Index Avaliacao

create index idx_Avaliacao_ID_Categoria_Avaliacao on Avaliacao(ID_Categoria_Avaliacao);

create index idx_Formulario_ID_Personal on Formulario(ID_Personal);--Index Formulario

create index idx_Acesso_ID_Aluno on Acesso(ID_Aluno);--Index Acesso

create index idx_Acesso_ID_Personal on Acesso(ID_Personal);

create index idx_Agenda_ID_Acesso on Agenda(ID_Acesso);--Index Agenda

create index idx_Agenda_ID_Personal on Agenda(ID_Personal);

create index idx_Agenda_ID_Avaliacao on Agenda(ID_Avaliacao);

create index idx_Acompanhamento_ID_Treino on Acompanhamento(ID_Treino);--Index Acompanhamento

create index idx_Acompanhamento_ID_Agenda on Acompanhamento(ID_Agenda);

create index idx_Acompanhamento_ID_Acesso on Acompanhamento(ID_Acesso);



---------------------Queries/Consultas

--Consulta p/ data no formato 'dd/MM/yyyy'
select format(Data_Nascimento, 'dd/MM/yyyy') as DataFormatada from Personal;
select format(Data_Nascimento, 'dd/MM/yyyy') as DataFormatada from Aluno;


update Material_Treino
set Nome_Material = ''
where ID_Material_Treino = ;


delete from Material_Treino
where ID_Material_Treino = ;

---------------------Functions [FunÁıes - Terminar!]
create function dbo.checkNomeMaterial(@Nome_Material varchar(255))
returns bit
as
begin
if @Nome_Material like '%[^a-z·ÈÌÛ˙·ËÏÚ˘‚ÍÓÙ˚„ıÁA-Z¡…Õ”⁄¿»Ã“Ÿ¬ Œ‘€√’« ]%'
return 0
else
return 1
end
go
---
(dbo.checkNomeMaterial(Nome_Material) = 1)