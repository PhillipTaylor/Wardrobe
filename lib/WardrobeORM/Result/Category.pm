
package WardrobeORM::Result::Category;
use base qw/DBIx::Class::Core/;

__PACKAGE__->load_components(qw{Helper::Row::ToJSON});

__PACKAGE__->table('category');

__PACKAGE__->add_columns(
	category_id => {
		data_type       => 'integer',
		is_serializable => 1,
	},
	name => {
		data_type       => 'varchar',
		is_serializable => 1
	}
);

__PACKAGE__->set_primary_key('category_id');
__PACKAGE__->add_unique_constraint(['name']);
__PACKAGE__->has_many('clothes', 'WardrobeORM::Result::Clothing', 'category_id');

1;
