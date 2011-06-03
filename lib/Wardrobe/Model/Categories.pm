package Wardrobe::Model::Categories;
use Moose;
use namespace::autoclean;
use WardrobeORM;

extends 'Catalyst::Model';

sub get_all_categories {

	my $category_rs = WardrobeORM->get_schema()->resultset('Category');
	return $category_rs->all();
}

=head1 NAME

Wardrobe::Model::Category - Catalyst Model

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
