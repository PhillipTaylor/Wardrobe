
package WardrobeORM::Result::Outfit;
use base qw/DBIx::Class::Core/;

__PACKAGE__->table('outfit');
__PACKAGE__->add_columns(qw/outfit_id name/);
__PACKAGE__->set_primary_key('outfit_id');
__PACKAGE__->has_many('tagged_clothing', 'WardrobeORM::Result::TaggedClothing', 'outfit_id');
__PACKAGE__->many_to_many('clothes', 'tagged_clothing', 'clothing');

1;
