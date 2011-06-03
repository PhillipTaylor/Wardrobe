
package WardrobeORM::Result::Clothing;
use base qw/DBIx::Class::Core/;

#__PACKAGE__->load_components(qw{Helper::Row::ToJSON});

__PACKAGE__->table('clothing');

__PACKAGE__->add_columns(
	clothing_id => {
		is_serializable => 1
	}, 
	name => {
		is_serializable => 1
	},
	category_id => {
		is_serializable => 1
	}
);

__PACKAGE__->set_primary_key('clothing_id');
__PACKAGE__->add_unique_constraint(['name']);
__PACKAGE__->belongs_to('category', 'WardrobeORM::Result::Category', 'category_id');
__PACKAGE__->has_many('tagged_clothing', 'WardrobeORM::Result::TaggedClothing', 'clothing_id');
__PACKAGE__->many_to_many('outfits', 'tagged_clothing', 'outfit');

#__PACKAGE__->serializable_columns(qw/clothing_id name category_id/);

sub TO_JSON {
	my $self = shift;

	return {
		clothing_id => $self->clothing_id,
		name        => $self->name,
		category_id => $self->category_id
	};
}

1;
