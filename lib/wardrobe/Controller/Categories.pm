package wardrobe::Controller::Categories;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

wardrobe::Controller::Categories - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

	#default action is to list categories
	$self->list($c);
}

sub list :Local {
	my ($self, $c) = @_;

	my @categories = ("shoes", "shirt", "shorts", "ties", "handbags", "accessories");

	$c->stash(
		template   => 'categories/list.tt',
		categories => \@categories
	);
}

sub category :Chained('/') :PathPart('categories/category') :Args(1) {
	my ($self, $c, $category_name) = @_;

	#print "looking up information on $category_name (resultset currently hardcoded to shirts)";

	my @clothes = ("Calvin Klein Medium Plain Shirt", "Micheal Smith Polo Shirt", "Nike football Shirt");

	$c->stash(
		template      => 'categories/category.tt',
		category_name => $category_name,
		clothes       => \@clothes
	);

}


=head1 AUTHOR

PTaylor,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
