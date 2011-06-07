
package WardrobeORM::ResultSet::Category;
use base WardrobeORM::ResultSet::Base;

__PACKAGE__->load_components();

sub find_or_create_by_name {
	my ($self, $category_name) = @_;

	$self->log()->debug("searching for category: $category_name");

	my $category = $self->find_or_create({
		name => $category_name
	}, { key => 'category_name' });

	return $category;
}

1;
