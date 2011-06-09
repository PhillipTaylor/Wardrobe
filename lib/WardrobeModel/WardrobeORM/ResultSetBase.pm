package WardrobeORM::ResultSetBase;
use base qw/DBIx::Class::ResultSet/;

use Log::Log4perl qw(get_logger);

__PACKAGE__->load_components();

our $logger = get_logger();

sub log {
	return $logger;
}

sub find_by_name {
	my ($self, $name) = @_;
	
	return $self->search({
		name => $name
	})->single;
}

sub find_by_id {
	my ($self, $id) = @_;

	return $self->find($id);
}

1;
