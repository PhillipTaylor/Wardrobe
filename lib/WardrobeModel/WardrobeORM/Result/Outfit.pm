
package WardrobeModel::WardrobeORM::Result::Outfit;
use base qw/DBIx::Class::Core/;

__PACKAGE__->load_components(qw{Helper::Row::ToJSON});

__PACKAGE__->table('outfit');
__PACKAGE__->add_columns(
	outfit_id => {
		is_serializable => 1
	},
	name => {
		is_serializable => 1
	}

);

__PACKAGE__->set_primary_key('outfit_id');
__PACKAGE__->has_many('tagged_clothing', 'WardrobeModel::WardrobeORM::Result::TaggedClothing', 'outfit_id');
__PACKAGE__->many_to_many('clothes', 'tagged_clothing', 'clothing');

1;
