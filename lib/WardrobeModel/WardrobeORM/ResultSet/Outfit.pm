
package WardrobeModel::WardrobeORM::ResultSet::Outfit;
use base WardrobeModel::WardrobeORM::ResultSetBase;

use Log::Log4perl qw(get_logger);

__PACKAGE__->load_components();

my $log = Log::Log4perl->get_logger();

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
