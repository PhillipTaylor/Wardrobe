package wardrobe::Controller::Clothes;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

wardrobe::Controller::Clothes - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

	$self->list($c);
}

sub list :Path :Args(0) {
	my ( $self, $c ) = @_;

	my @shirts = (
		"Calvin Klein Medium Plain Shirt",
		"Micheal Smith Polo Shirt",
		"Nike football Shirt"
	);

	my %clothes = (
		"shirts" => \@shirts,
		"shoes"  => \@shirts
	);


	$c->stash(
		template   => 'clothes/list.tt',
		clothes    => \%clothes
	);
}

sub clothing :Chained('/') :PathPart('clothes/clothing') :Args(1) {
	my ($self, $c, $clothing_name) = @_;

	my %item = (
		"clothing_name" => "Nice Shirt",
		"category"      => "Shirt",
		"colour"        => "Red"
	);

	$c->stash(
		template => 'clothes/clothing.tt',
		item     => \%item
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
