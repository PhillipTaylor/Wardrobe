
package WardrobeORM::Result::Category;
use base qw/DBIx::Class::Core/;

__PACKAGE__->table('category');
__PACKAGE__->add_columns(qw/category_id name/);
__PACKAGE__->set_primary_key('category_id');
__PACKAGE__->add_unique_constraint(['name']);
__PACKAGE__->has_many('clothes', 'WardrobeORM::Result::Clothing', 'category_id');

1;
