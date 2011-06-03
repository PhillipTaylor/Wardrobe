
package WardrobeORM::Result::TaggedClothing;
use base qw/DBIx::Class::Core/;

__PACKAGE__->load_components(qw{Helper::Row::ToJSON});

__PACKAGE__->table('tagged_clothing');
__PACKAGE__->add_columns(qw/clothing_id outfit_id/);
__PACKAGE__->set_primary_key(qw/clothing_id outfit_id/);
__PACKAGE__->belongs_to('clothing', 'WardrobeORM::Result::Clothing', 'clothing_id');
__PACKAGE__->belongs_to('outfit', 'WardrobeORM::Result::Outfit', 'outfit_id');

1;
