
package WardrobeORM::ResultSet::Category;
use base WardrobeORM::ResultSet::Base;

__PACKAGE__->load_components();

sub find_or_create_by_name {
	my ($self, $category_name) = @_;

	my $category = $self->find_or_create({
		category_name => $category_name
	}, { key => 'category_name' });

	return $category;
}

1;
