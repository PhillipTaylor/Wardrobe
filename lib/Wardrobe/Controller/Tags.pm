package Wardrobe::Controller::Tags;
use Moose;
use namespace::autoclean;
use Data::Dumper;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

Wardrobe::Controller::Tags - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

	my @outfits = Wardrobe->get_schema()->resultset('Outfit')->all();

	$c->stash(
		"template" => 'tags/list.tt',
		"outfits"  => \@outfits
	);
}

sub tag :Chained('/') :PathPart('tags/tag') :Args(2) {
	my ($self, $c, $outfit_id, $outfit_name) = @_;

	my $outfit = Wardrobe->get_schema()->resultset('Outfit')->find($outfit_id);

	$c->log->debug(Dumper($outfit));

	$c->stash(
		"template" => 'tags/tag.tt',
		"outfit"  => $outfit
	);
}

sub add :Local {
	my ( $self, $c ) = @_;

	if (lc $c->req->method ne 'post') {
		## forward to error page.
		$c->log->debug('not a post');
	}
	
	my $clothing_id = $c->req->params->{"clothing_id"};
	my $new_tag_name = $c->req->params->{"tag"};

	# see if tag exists or needs to be created.
	my $outfit = Wardrobe->get_schema()->resultset("Outfit")->search({
		name => $new_tag_name
	})->single;

	$c->log->debug("Before: $outfit");

	if (!defined($outfit)) {
		# create outfit here.
		$outfit = Wardrobe->get_schema()->resultset('Outfit')->create({
			name => $new_tag_name
		});
	}

	# add the clothes to the outfit.
	Wardrobe->get_schema()->resultset('TaggedClothing')->create({
		clothing_id => $clothing_id,
		outfit_id   => $outfit->outfit_id
	});

	$c->res->redirect("/tags/tag/" . $outfit->outfit_id . "/" . $outfit->name);

}


=head1 AUTHOR

PTaylor,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
