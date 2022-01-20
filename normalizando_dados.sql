/*Normalizando dados*/

/*	Chave primária -> Identifica o registro de forma única
	Chave estrangeira -> relaciona uma tabela a outra
*/

--Adicionando Chave primária
alter table clientes add constraint pk_cliente primary key(codigo)

--Gera erro, já que há um registro com o código 1
insert clientes values('Julio','J',getdate());


--Em pedido_item as chaves não são auto geradas, pois são referências a outras tabelas

-- Gera erro, pois há duplicidade
insert pedido_item values (2,2,10.5,1)


--Adicionando chave primária em pedido_item
alter table pedido_item add constraint pk_pedido_item primary key (codigo_pedido,codigo_produto)

--Adicionando chave estrangeira em pedido_item
alter table pedido_item add constraint fk_pedido foreign key (codigo_pedido) references pedido(codigo)
alter table pedido_item add constraint fk_produto foreign key (codigo_produto) references produtos(codigo)

-- Adicionando chave estrangeira em pedido
alter table pedido add constraint fk_cliente foreign key(codigo_cliente) references clientes(codigo)

/* Normalização
 1 fase 
 Não deve haver um conjunto de colunas repetido ou 
 um conjunto de informações em uma mesma propriedade 
 
 2 fase 
 Não pode existir informações duplicadas que dependam de chave primária
 */
 
 -- 3 fase
 alter table pedido add codigo_status int
 alter table pedido add desc_status varchar(50)

 update pedido set codigo_status = 1, desc_status = 'Em andamento'

 select * from pedido

 /*Se for necessário alterar o código_status do pedido, 
 também deverá realizar a mudança em desc_status. solução: */

 --Criando uma tabela status
 create table status(
	codigo int not null,
	descricao varchar(50) null
 )

 alter table status add constraint pk_codigo primary key (codigo)
 alter table pedido add constraint fk_status foreign key (codigo_status) references status(codigo)
 
 insert status values
 ('Em andamento'),
 ('Processado'),
 ('Pago'),
 ('Entregue');

 
 alter table pedido drop column desc_status

