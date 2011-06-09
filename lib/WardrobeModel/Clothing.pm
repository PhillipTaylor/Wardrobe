package WardrobeModel::Clothing;
use Moose;
use namespace::autoclean;

extends 'Catalyst::Model::DBIC::Schema';
use base 'Catalyst::Model';

sub get_clothes_by_category {
	my ($self, $category_id) = @_;

	my $clothing_rs = $self->resultset('Clothing');
	return $clothing_rs->search_by_category($category_id);
}

sub get_all_clothes {
	my $self = shift;

	my $clothing_rs = $self->resultset('Clothing');
	return $clothing_rs->all();
}

sub get_clothes_by_name {
	my ($self, $search_qry) = @_;

	my $clothing_rs = $self->resultset('Clothing');
	return $clothing_rs->search_by_name_query($search_qry);
}

sub get_clothing_by_id {
	my ($self, $clothing_id) = @_;

	my $clothing_rs = $self->resultset('Clothing');
	return $clothing_rs->find_by_id($clothing_id);

}

__PACKAGE__->meta->make_immutable;

1;
