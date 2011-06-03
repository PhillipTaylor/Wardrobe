package Wardrobe::Model::Clothing;
use Moose;
use namespace::autoclean;
use WardrobeORM;

extends 'Catalyst::Model';

sub get_clothes_by_category {
	my ($self, $category_id) = @_;

	my $clothing_rs = WardrobeORM->get_schema()->resultset('Clothing');
	return $clothing_rs->search_by_category($category_id);
}

sub get_all_clothes {
	my $clothing_rs = WardrobeORM->get_schema()->resultset('Clothing');
	return $clothing_rs->all();
}

sub get_clothes_by_name {
	my ($self, $search_qry) = @_;

	my $clothing_rs = WardrobeORM->get_schema()->resultset('Clothing');
	return $clothing_rs->search_by_name_query($search_qry);

}

sub get_clothing_by_id {
	my ($self, $clothing_id) = @_;

	my $clothing_rs = WardrobeORM->get_schema()->resultset('Clothing');
	return $clothing_rs->find_by_id($clothing_id);

}


=head1 NAME

Wardrobe::Model::Clothing - Catalyst Model

=head1 DESCRIPTION

Catalyst Model.

=head1 AUTHOR

PTaylor,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
