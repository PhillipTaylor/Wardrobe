
package WardrobeModel::WardrobeORM::Result::Category;
use base qw/DBIx::Class::Core/;

__PACKAGE__->table('category');

__PACKAGE__->add_columns(
	id => {
	#	data_type         => 'integer',
		is_serializable   => 1,
	#	is_auto_increment => 1
	},
	name => {
	#	data_type       => 'varchar',
		is_serializable => 1
	}
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(['name']);
__PACKAGE__->has_many('clothes', 'WardrobeModel::WardrobeORM::Result::Clothing', 'category_id');

1;
