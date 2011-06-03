
package WardrobeORM::ResultSet::Outfit;
use base WardrobeORM::ResultSet::Base;

__PACKAGE__->load_components();

sub find_or_create_by_name {
	my ($self, $outfit_name) = @_;

	my $outfit = $self->search({
		name => $outfit_name
	})->single;

	if (!$outfit) {
		$outfit = $self->create({
			name => $outfit_name
		});
	}

	return $outfit;

}

1;
