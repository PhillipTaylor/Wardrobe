
drop table tagged_clothing;
drop table clothing;
drop table category;
drop table outfit;

-- CATEGORIES

create table category (
	id            serial not null,
	name          varchar(255) not null
);

alter table category add constraint ccategory_pk1
	primary key (id);

create unique index icategory on category(name);

-- CLOTHING

create table clothing (
	id            serial not null,
	name          varchar(255) not null,
	category_id   integer not null
);

alter table clothing add constraint cclothing_pk1
	primary key (id);

alter table clothing add constraint cclothing_fk1
	foreign key (category_id) references category (id);

create unique index iclothing on clothing(name);

-- OUTFITS

create table outfit (
	id             serial not null,
	name           varchar(255) not null
);

alter table outfit add constraint coutfit_pk
	primary key(id);

create unique index ioutfit on outfit(name);

-- TAGGED CLOTHES

create table tagged_clothing (
	clothing_id    integer not null,
	outfit_id      integer not null
);

alter table tagged_clothing add constraint ctagged_clothing_pk1
	primary key (clothing_id, outfit_id);

alter table tagged_clothing add constraint ctagged_clothing_fk1
	foreign key (clothing_id) references clothing(id);

alter table tagged_clothing add constraint ctagged_clothing_fk2
	foreign key (outfit_id) references outfit(id);

-- insert some sample data

insert into category (id, name) values (default, 'Shirt');
	insert into clothing (id, name, category_id) values (default, 'Blue / Green Shirt', currval('category_id_seq'));
	insert into clothing (id, name, category_id) values (default, 'Red Shirt', currval('category_id_seq'));
	insert into clothing (id, name, category_id) values (default, 'Green Shirt', currval('category_id_seq'));
	insert into clothing (id, name, category_id) values (default, 'Yellow Shirt', currval('category_id_seq'));

insert into category (id, name) values (default, 'Shoes');
	insert into clothing (id, name, category_id) values (default, 'Black Shoes', currval('category_id_seq'));
	insert into clothing (id, name, category_id) values (default, 'Brown Shoes', currval('category_id_seq'));

insert into category (id, name) values (default, 'Socks');
	insert into clothing (id, name, category_id) values (default, 'Brown Socks', currval('category_id_seq'));
	insert into clothing (id, name, category_id) values (default, 'White Socks', currval('category_id_seq'));
	insert into clothing (id, name, category_id) values (default, 'Black Socks', currval('category_id_seq'));

insert into category (id, name) values (default, 'Shorts');
	insert into clothing (id, name, category_id) values (default, 'Swimming Trunks', currval('category_id_seq'));
	insert into clothing (id, name, category_id) values (default, 'Baggy Shorts', currval('category_id_seq'));
	insert into clothing (id, name, category_id) values (default, 'Bermuda Shorts', currval('category_id_seq'));
	insert into clothing (id, name, category_id) values (default, 'Professional Style Shorts', currval('category_id_seq'));
