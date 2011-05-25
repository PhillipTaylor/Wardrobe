
package Wardrobe::Model::Main::Result::Category;
use base qw/DBIx::Class::Core/;

__PACKAGE__->table('category');
__PACKAGE__->add_columns(qw/category_id name/);
__PACKAGE__->set_primary_key('category_id');
__PACKAGE__->has_many('clothes', 'Wardrobe::Model::Main::Result::Clothing', 'category_id');

1;
