package WardrobeModel::WardrobeORM::ResultSetBase;
use base qw/DBIx::Class::ResultSet/;

__PACKAGE__->load_components();

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
