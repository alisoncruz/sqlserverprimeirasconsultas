/*PRIMEIRAS INSTRUÇÕES SQL*/

--Inserindo registros

insert into clientes(codigo, nome, tipo_pessoa) values(1, 'Thiago','F');

--Omitindo a palavra INTO 
insert clientes(codigo, nome, tipo_pessoa) values(2, 'Thiago','F');

--Trocando a ordem das colunas
insert clientes (tipo_pessoa, codigo, nome) values ('F', 3, 'Thiago');

--Omitindo as colunas (se trocar a ordem das colunas gera erro)
insert clientes values (4, 'Thiago','F');

--Inserindo mais de um registro
insert clientes values (5, 'Thiago','F'),(1,'Thiago','J');

-- Selecionando todas as colunas da tabela
select * from clientes;

/*Atualizar o codigo do último registro, pois esta duplicado
a instrução update precisa da cláusula where, a fim de evitar a
atualização de todos os registros da tabela */

update clientes set codigo = 6, nome = 'José' 
where tipo_pessoa = 'J';

--Para deletar registros
delete from clientes where codigo in(5,4,3,2);

--Utilizando operadores lógicos
select * from clientes 
where codigo = 1 OR tipo_pessoa = 'J'

select * from clientes
where codigo = 1 AND tipo_pessoa = 'F'

--Inserindo registros na tabela da produtos
insert produtos values (1,'caneta','caneta azul',1.5);
insert produtos values (2,'caderno','caderno 10 matérias',20.99);

--Inserindo registros na tabela de pedidos
insert pedido values (1,getdate(),0,3.0,7)
insert pedido values (2,getdate(),0,3.0,1)


--Inserindo registros na tabela de pedido_item
insert pedido_item values(1,1,1.5,2)
insert pedido_item values(2,1,1.5,1)
insert pedido_item values(2,2,20.99,2)

select * from pedido
select * from pedido_item

/*Ao adicionar uma nova coluna com constraint nullable
a inserção que determina as colunas que receberão dados não
resultará em erro*/

alter table clientes add data_criacao datetime null;

-- Gera erro, pois espera dados para 4 colunas
insert into clientes values (2, 'Higor', 'F');

-- Sem erro (determinando as colunas)
insert into clientes (codigo, nome, tipo_pessoa) values (2, 'Higor', 'F');

-- Usando funções para lidar com colunas que aceitam null
select isnull(data_criacao,getdate()), *
from clientes;

-- Usando estruturas de decisão
select *,
		case
			when tipo_pessoa = 'F' then 'Pessoa Física'
			when tipo_pessoa = 'J' then 'Pessoa Jurídica'
			else 'Pessoa Indefinida'
		end
from clientes;

--Formatação
select *, convert(varchar(50), data_solicitacao,103)
from pedido

/*Concatenação do valor da coluna gerada pela estrutura 
de decisão com a data atual gerada pela função getadate()
*/
select *,
		case
			when tipo_pessoa = 'F' then 'Pessoa Física'
			when tipo_pessoa = 'J' then 'Pessoa Jurídica'
			else 'Pessoa Indefinida'
		end + convert(varchar, getdate(),103)
from clientes;















