/*Criando tabelas*/

create table produtos(
codigo int,
nome varchar(100),
descricao varchar(200),
preco float
)

create table clientes(
codigo int not null,
nome varchar(200) not null,
tipo_pessoa char(1) not null
)

create table pedido(
codigo int not null,
data_solicitacao datetime not null,
flag_pago bit not null,
totalpedido float not null,
codigo_cliente int not null
)

create table pedido_item(
codigo_pedido int not null,
codigo_produto int not null,
preco float not null,
quantidade int not null
)