-- PRIMEIRA AULA

create database controle_compras;

use controle_compras;

create table compras (
	id int auto_increment primary key,
    valor double,
    data date,
    recebido boolean, observacoes varchar(255)
);

show tables;

desc compras;

-- INSERE NO BANCO DE DADOS, PASSANDO AS COLUNAS E OS VALORES, SE AS COLUNAS FOREM OMITIDAS ENTÃO SERÁ PEGO PELA ORDEM DAS COLUNAS DA TABELA
insert into compras (valor, data, recebido, observacoes) values(1500.0, '2014-05-14', 1, 'Geladeira nova pq a velha quebrou');


-- MOSTRA TODAS AS COLUNAS E TODOS OS REGISTROS DA TABELA COMPRAS
select * from compras;

-- MOSTRA DATA, VALOR, OBSERVACOES
select data, valor, observacoes from compras;

-- POSSÍVEL PASSAR EXPRESSÕES NAS COLUNAS
select data, valor + 3, observacoes from compras;

-- O WHERE É O FILTRO DO MySQL
select data, valor, obersavacoes from compras where valor > 1000;

-- INSERE MAIS UM REGISTRO NA TABELA COMPRAS
insert into compras (valor, data, recebido, observacoes) values(400.0, '2014-05-18', 0, 'Celular velho da marca xpto');

-- ME TRÁS AS COLUNAS DATA, VALOR, OBSERVACOES DA TABELA COMPRAS ONDE O VALOR É MAIOR QUE 1000 E DATA MAIOR QUE PRIMEIRO DE JANEIRO DE 2014
select data, valor, observacoes from compras where valor > 1000 and data > '2014-01-01';

select data, valor, observacoes from compras where recebido = 1;

select data, valor, observacoes from compras where recebido <> 1;

-- STRING BUSCA TEXTOS EXATOS
-- LIKE É UTILIZADO QUANDO QUER BUSCAR POR PEDAÇOS NA STRING
-- % BUSCA QUALQUER COISA A MAIS QUE TIVER DEPOIS DA FRASE PROCURADA
select data, valor, observacoes from compras where observacoes like 'celular velho%';

select valor, observacoes from compras where data >= '2008-12-15';

select * from compras where data >= '2008-12-15' and data < '2010-12-15';

select * from compras where valor >= 15.0 and valor <= 35.0 and observacoes like 'LANCHONETE%';

SELECT * FROM COMPRAS WHERE VALOR >= 15.0 AND VALOR <= 35.0 AND OBSERVACOES LIKE 'LANCHONETE%';

select * from compras where valor > 5000.00 or recebido = 1;

select * from compras where valor >= 1000.00 and valor <= 3000.00 or valor > 5000.00;


-- SEGUNDA AULA

select * from compras;

-- BETWEEN PEGA DE 200 ATÉ 700, PEGANDO O 200 E O 700
select * from compras where valor between 200 and 700;

select * from compras where data between '2010-01-01' and '2010-04-01';


-- ATUALIZAR A TABELA COMPRAS
update compras set valor = 900 where id = 20;

select * from compras where id = 20;

update compras set valor = 910, observacoes = 'FESTA DE ANIVERSARIO' where id = 20;

update compras set valor = 5, observacoes = 'GASTO PEQUENO' where valor < 50;

-- DELETAR O REGISTRO

delete from compras where id = 44;

select * from compras;

delete from compras where valor < 30;

update compras set observacoes = 'Preparando o natal' where data = '2010-12-20';

select * from compras where data = '2010-12-20';

-- ATUALIZAR TODAS AS COMPRAS FEITAS NO DIA 01/06/2009 PARA O VALOR ATUAL + 10
update compras set valor = valor + 10 where data = '2009-06-01';

-- ATUALIZE TODAS AS COMMPRAS FEITAS ENTRE 01/07/2009 E 01/07/2010 PARA QUE ELAS TENHAM A OBSERVAÇÃO 'ENTREGUE ANTES DE 2011' E A COLUNA RECEBIDO COM O VALOR TRUE
update compras set recebido = 1, observacoes = 'Entregue antes de 2011' where data between '2009-07-01' and '2010-07-01';

-- EXCLUA AS COMPRAS REALIZADAS ENTRE 05 E 20 MARÇO DE 2009. COLOQUE ABAIXO O COMANDO EXECUTADO.
delete from compras where data between '2009-03-05' and '2009-03-20';


-- USE O OPERADOR NOT E MONTE UM SELECT QUE RETORNA TODAS AS COMPRAS COM VALOR DIFERENTE DE R$ 108,00.
select * from compras where not valor = 108.00;

-- AULA 03
-- COLOCAMOS NULL PARA QUANDO NÃO QUEREMOS COLOCAR NADA NA COLUNA
insert into compras (valor, data, recebido, observacoes) values(500.00, '2014-04-05', 1, null);

-- PARA NULL UTILIZAMOS A PALAVRA IS E NEGAÇÃO É IS NOT
select * from compras where observacoes is null;

delete from compras where id = 62;

select * from compras;

-- ALTERA A TABELA JÁ CRIADA, MUDA A ESTRUTURA DA TABELA
alter table compras modify observacoes varchar(255) not null;

insert into compras (valor,data, recebido, observacoes) values(500.00, '2014-04-05', 1, 'presente pra mae');

-- SE OMITIR O RECEBIDO ELE SERÁ PREENCHIDO COM 0
-- VALOR PADRÃO RECEBIDO
alter table compras modify recebido tinyint(1) default '0';


insert into compras (valor,data,observacoes) values(530, '2015-04-05','presenta da mamae');

select * from compras where valor = 530.00;

-- ALTERAR A ESTRUTURA DA TABELA, ADICIONANDO UMA NOVA COLUNA
-- ENUM SÃO VALORES PRÉDEFINIDOS QUE SERÃO ACEITOS SOMENTE NA COLUNA
alter table compras add column  forma_pagt enum('cartao', 'boleto', 'dinheiro');

insert into compras(valor, data, observacoes, forma_pagt) values(500.0, '2014-04-05', 'Presente da mae 2', 'cartao');

select * from compras;

update compras set forma_pagt = 'boleto' where forma_pagt is null;

alter table compras modify observacoes varchar(255) not null;

desc compras;


-- REESCREVA O CREATE TABLE DO COMEÇO DO CURSO, MARCANDO OBSERVACOES COMO NÃO NULO, VALOR PADRÃO DO RECEBIDO COMO 1, E FORMA_PAGT COMO ENUM QUE ACEITA DINHEIRO, CARTAO, BOLETO

create table compras (
	id int auto_increment primary key,
    valor double,
    data date,
    recebido boolean default '1', 
    observacoes varchar(255) not null,
    forma_pagt enum('DINHEIRO', 'CARTAO', 'BOLETO')
);

CREATE TABLE compras (
          id int NOT NULL AUTO_INCREMENT,
          valor double,
          data datetime,
          observacoes text NOT NULL,
          recebido tinyint(1) DEFAULT 1,
          forma_pagto ENUM('DINHEIRO', 'CARTAO', 'BOLETO'),
          PRIMARY KEY (id)
        );
        
        
        
-- AULA 04

select * from compras;


-- FUNCTIONS sum
select sum(valor) from compras;

-- SOMA TODOS OS VALORES
select sum(valor) from compras where data > '2010-01-01';

-- CONTA QUANTAS LINHAS
select count(valor) from compras where data > '2010-01-01';

select count(valor), sum(valor) from compras where data > '2010-01-01';

select count(valor) as quantidade, sum(valor) as total from compras where data > '2010-01-01';

-- AGRUPA POR RECEBIDOS
-- WHERE SEMPRE ANTES DO GROUP BY
select recebido, sum(valor) from compras where data < '2011-01-01' group by recebido;


-- ORDENAR ORDER BY
-- CALCULA A MÉDIA DOS VALORES NO MÊS DOS ANOS AGRUPANDO POR MÊS E ANO, ORDENANDO POR ANO E MÊS
select month(data), year(data), avg(valor) from compras group by month(data), year(data) order by year(data), month(data);

use controle_compras;


-- CALCULE A MÉDIA DE TODAS AS COMPRAS COM DATAS INFERIORES A 12/05/2009. COLE A INSTRUÇÃO SQL AQUI QUANDO ACABAR
select avg(valor) from compras where data < '2009-05-12';

-- CALCULE A SOMA DO VALOR DE TODAS AS COMPRAS COM DATAS INFERIORES A 10/10/2010, AGRUPADAS POR FORMA DE PAGAMENTO.
select forma_pagt, sum(valor) from compras where data < '2009-10-10' group by forma_pagt;

SELECT FORMA_PAGT, SUM(VALOR) FROM COMPRAS WHERE DATA < '2010-10-10' GROUP BY FORMA_PAGT;

-- CALCULE A QUANTIDADE DE COMPRAS COM DATAS INFERIORES A 12/05/2009 E QUE JÁ FORAM RECEBIDAS
select count(1) from compras where data < '2009-05-12' and recebido = 1;
select count(id) from compras where data < '2009-05-12' and recebido = 1;

-- CALCULE A SOMA DE TODAS AS COMPRAS, AGRUPADAS POR FORMA DE PAGAMENTO E COMPRA RECEBIDA OU NÃO
select sum(valor) from compras group by forma_pagt, recebido;
SELECT RECEBIDO, FORMA_PAGT, SUM(VALOR) FROM COMPRAS GROUP BY FORMA_PAGT, RECEBIDO;



-- AULA 05 - Juntando dados de várias tabelas

use controle_compras;

create table compradores(
	id int not null auto_increment,
    nome varchar(100) not null,
    endereco varchar(100) not null,
    telefone varchar(20) not null,
    primary key(id)
);

insert into compradores(nome, endereco, telefone) values('Mauricio', 'Rua Vergueiro', '1234566');
insert into compradores(nome, endereco, telefone) values('Adriano', 'Av Paulista', '2222-3344');
delete from compradores where id = 2;

select * from compradores;

show tables;

alter table compras add column comprador_id int;

desc compras;

update compras set comprador_id = 1 where id <= 8;
update compras set comprador_id = 3 where id > 8;

select * from compras;


-- JUNTAR TABELAS
select observacoes, valor, nome from compras join compradores on compras.comprador_id = compradores.id;

insert into compras (valor, data, recebido, observacoes, forma_pagt, comprador_id) values(20.00, '2010-10-30', 1, 'compra boa', 'cartao', 4);

select * from compras where comprador_id = 4;

-- COLOCAR A CHAVE ESTRANGEIRA
alter table compras add foreign key (comprador_id) references compradores(id);


-- EXIBA O NOME DO COMPRADOR E O VALOR DE TODAS AS COMPRAS FEITAS ANTES DE 09/08/2010

show tables;
desc compras;
select compradores.nome, compras.valor from compradores join compras on compradores.id = compras.comprador_id where compras.data < '2010-08-09';

SELECT NOME, VALOR FROM COMPRAS INNER JOIN COMPRADORES ON COMPRAS.COMPRADOR_ID = COMPRADORES.ID
        WHERE DATA < '2010-08-09';
        
-- EXIBA TODAS AS COMPRAS DO COMPRADOR QUE POSSUI ID IGUAL A 1
SELECT * from compras join compradores on compras.comprador_id = compradores.id where compradores.id = 1;
SELECT * FROM COMPRAS WHERE COMPRADOR_ID = 1;
SELECT * FROM COMPRAS INNER JOIN COMPRADORES ON COMPRAS.COMPRADOR_ID = COMPRADORES.ID WHERE COMPRADOR_ID = 1;

-- EXIBA TODAS AS COMPRAS (MAS SEM OS DADOS DO COMPRADOR), CUJO COMPRADOR TENHA NOME QUE COMEÇA COM 'GUILHERME'
select compras.* from compras join compradores on compras.comprador_id = compradores.id where compradores.nome like 'GUILHERME%';
  SELECT COMPRAS.* FROM COMPRAS INNER JOIN COMPRADORES ON COMPRAS.COMPRADOR_ID = COMPRADORES.ID WHERE NOME LIKE 'GUILHERME%';