package WardrobeModel::Categories;
use Moose;
use namespace::autoclean;

extends 'Catalyst::Model::DBIC::Schema';
use base 'Catalyst::Model';

sub get_all_categories {
	my $self = shift;

	my $category_rs = $self->resultset('Category');
	return $category_rs->all();
}

__PACKAGE__->meta->make_immutable;

1;
