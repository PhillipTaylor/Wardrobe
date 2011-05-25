
drop table tagged_clothing;
drop table clothing;
drop table category;
drop table outfit;

create table category (
	category_id   integer not null,
	name          varchar(255) not null
);

alter table category add constraint ccategory_pk1
	primary key (category_id);

create table clothing (
	clothing_id   integer not null,
	name          varchar(255) not null,
	category_id   integer not null
);

alter table clothing add constraint cclothing_pk1
	primary key (clothing_id);

alter table clothing add constraint cclothing_fk1
	foreign key (category_id) references tCategory (category_id);

create table outfit (
	outfit_id      integer not null,
	name           varchar(255) not null
);

alter table outfit add constraint coutfit_pk
	primary key(outfit_id);

create table tagged_clothing (
	clothing_id    integer not null,
	outfit_id      integer not null
);

alter table tagged_clothing add constraint ctagged_clothing_pk1
	primary key (clothing_id, outfit_id);


-- insert some sample data

insert into category values (1, 'Shirt');
insert into category values (2, 'Shoes');
insert into category values (3, 'Socks');
insert into category values (4, 'Shorts');

insert into clothing values (1, 'Blue Shirt', 1);
insert into clothing values (2, 'Red Shirt', 1);
insert into clothing values (3, 'Green Shirt', 1);
insert into clothing values (4, 'Yellow Shirt', 1);

insert into clothing values (5, 'Black Shoes', 2);
insert into clothing values (6, 'Brown Shoes', 2);

insert into clothing values (7, 'Brown Socks', 3);
insert into clothing values (8, 'White Socks', 3);
insert into clothing values (9, 'Black Socks', 3);

insert into clothing values (10, 'Swimming Trunks', 4);
insert into clothing values (11, 'Baggy Shorts', 4);
insert into clothing values (12, 'Bermuda Shorts', 4);
insert into clothing values (13, 'Professional Style Shorts', 4);
