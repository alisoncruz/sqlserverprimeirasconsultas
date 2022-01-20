/*Trabalhando com tabelas relacionadas*/

create table status_pedido_item(
codigo int not null,
descricao varchar(50) null,
)

alter table status_pedido_item add constraint pk_status_pedido_item primary key (codigo)

create table pedido_item_log (
codigo_pedido int not null,
codigo_produto int not null,
codigo_status_pedido_item int not null,
data_movimento datetime
)

alter table pedido_item_log add constraint pk_pedido_item_log primary key (codigo_pedido,codigo_produto)

alter table pedido_item_log add constraint fk_codigo_pedido 
foreign key (codigo_pedido, codigo_produto) 
references pedido_item(codigo_pedido,codigo_produto)

insert status_pedido_item values 
('Separação solicitada'),
('Em separação'),
('Embalado')


select * from status_pedido_item

insert pedido_item_log (codigo_pedido, codigo_produto, codigo_status_pedido_item,data_movimento)
select codigo_pedido,codigo_produto,1,getdate()
from pedido_item

select * from pedido_item_log

-- Gera erro, pois não há a chave primária na tabela referenciada (pedido_item)
insert pedido_item_log values(1,2,1,getdate())


--JOINS

select * from clientes
select * from pedido

-- inner join
select * 
from clientes cli
inner join pedido p
on p.codigo_cliente = cli.codigo

-- left join
select * 
from clientes cli
left join pedido p
on p.codigo_cliente = cli.codigo
and p.totalpedido > 10.0

-- right join
select * 
from clientes cli
right join pedido p
on p.codigo_cliente = cli.codigo


select cli.nome, p.totalpedido,
		case
			when cli.tipo_pessoa = 'F' then 'Física'
			else 'Jurídica'
		end tipo_pessoa
from clientes cli
left join pedido p
on p.codigo_cliente = cli.codigo

--join com chave primária composta, utilizando funções de agregação

select	t4.codigo, 
		t4.descricao,
		sum(t1.preco * t1.quantidade) total 
from pedido_item t1
inner join pedido_item_log t2
on t1.codigo_pedido = t2.codigo_pedido
and t1.codigo_produto = t2.codigo_produto
inner join status_pedido_item t3
on t3.codigo = t2.codigo_status_pedido_item
inner join produtos t4
on t4.codigo = t2.codigo_produto
group by t4.codigo, t4.descricao
having sum(t1.preco * t1.quantidade) > 10.0

-- Clientes que não tem pedido. Consulta que não é recomendável para bases comomuitos registros

select * from clientes

select * from clientes cli
where cli.codigo not in (select codigo_cliente from pedido)

-- consulta com performance melhor
select * from clientes cli
left join pedido p
on p.codigo_cliente = cli.codigo
where p.codigo is null


insert into pedido values (getdate(), 0, 10.0, 1,1)

select * from pedido

/*A consulta está contando a quantidade de pedidos, mas há clientes que não tem pedido e 
 ainda assim o resultado mostra que tem pedidos */
select	cli.codigo, 
		cli.nome,
		count(*) numero_pedidos
from	clientes cli
left join pedido p
on cli.codigo = p.codigo_cliente
group by cli.codigo, cli.nome


-- Determinando uma coluna na função count() o erro não ocorre
select	cli.codigo, 
		cli.nome,
		count(p.codigo) numero_pedidos
from	clientes cli
left join pedido p
on cli.codigo = p.codigo_cliente
group by cli.codigo, cli.nome

-- Outra forma de fazer join
select * from clientes cli, pedido ped, pedido_item pedItem
where cli.codigo = ped.codigo_cliente
and ped.codigo = pedItem.codigo_pedido


