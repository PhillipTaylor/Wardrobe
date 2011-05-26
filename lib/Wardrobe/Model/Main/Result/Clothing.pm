
package Wardrobe::Model::Main::Result::Clothing;
use base qw/DBIx::Class::Core/;

__PACKAGE__->table('clothing');
__PACKAGE__->add_columns(qw/clothing_id name category_id/);
__PACKAGE__->set_primary_key('clothing_id');
__PACKAGE__->belongs_to('category', 'Wardrobe::Model::Main::Result::Category', 'category_id');
__PACKAGE__->has_many('tagged_clothing', 'Wardrobe::Model::Main::Result::TaggedClothing', 'clothing_id');
__PACKAGE__->many_to_many('outfits', 'tagged_clothing', 'outfit');

1;
