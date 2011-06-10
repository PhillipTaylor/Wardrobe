
package WardrobeModel::WardrobeORM::ResultSet::Outfit;
use base WardrobeModel::WardrobeORM::ResultSetBase;

__PACKAGE__->load_components();

sub find_or_create_by_name {
	my ($self, $outfit_name) = @_;

	
	$self->log->debug('before outfit');

	my $outfit = $self->search({
		name => $outfit_name
	})->single;

	$self->log->debug('wcafterbefore outfit');

	if (!$outfit) {
		$outfit = $self->create({
			name => $outfit_name
		});
	}

	return $outfit;

}

1;
