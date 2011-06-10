
package WardrobeModel::WardrobeORM::ResultSet::Category;
use base WardrobeModel::WardrobeORM::ResultSetBase;

__PACKAGE__->load_components();

sub find_or_create_by_name {
	my ($self, $category_name) = @_;

	$self->log()->debug("searching for category: $category_name");

	my $category = $self->find_or_create({
		name => $category_name
	}, { key => 'category_name' });

	$self->log()->debug("return from category: $category_name");

	return $category;
}

1;


	#my $category = $self->find_or_create({name => $category_name}, { key => 'category_name' });
