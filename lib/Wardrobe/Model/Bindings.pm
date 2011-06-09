
package Wardrobe::Model::Bindings;
use Moose;

extends 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config (
    schema_class => 'WardrobeModel::WardrobeORM',
    connect_info => {
        dsn            => 'dbi:Pg:dbname=wardrobe',
        user           => 'username',
        password       => 'password',
        pg_enable_utf8 => 1
    },
	traits => ['SchemaProxy']
);
