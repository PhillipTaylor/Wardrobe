
package Wardrobe::Model::Main::Result::Clothing;
use base qw/DBIx::Class::Core/;

__PACKAGE__->table('clothing');
__PACKAGE__->add_columns(qw/clothing_id name category_id/);
__PACKAGE__->set_primary_key('clothing_id');
__PACKAGE__->belongs_to('category', 'Wardrobe::Model::Main::Result::Category', 'category_id');

1;
