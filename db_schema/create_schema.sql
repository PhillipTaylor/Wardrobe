
create table tCategory (
	category_id   integer not null,
	name          varchar(255) not null
);

alter table tCategory add constraint cCategory_pk1
	primary key (category_id);

create table tClothing (
	clothing_id   integer not null,
	name          varchar(255) not null,
	category_id   integer not null
);

alter table tClothing add constraint cClothing_pk1
	primary key (clothing_id);

alter table tClothing add constraint cClothing_fk1
	foreign key (category_id) references tCategory (category_id);
