package Wardrobe::Controller::Tags;
use Moose;
use namespace::autoclean;

use Wardrobe::Util::TemplateUtil (qw/cln/);

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

Wardrobe::Controller::Tags - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub tag_root :Chained('/root') :PathPart('tags') :CaptureArgs(0) {
	my ($self, $c) = @_;
	
	my $breadcrumbs = $c->stash->{'breadcrumb'};
	$breadcrumbs->push('tags', 'tags');
}

sub index :Chained('tag_root') :PathPart('') :Args(0) {
    my ( $self, $c ) = @_;

	my @outfits = $c->model('Bindings')->get_all_outfits();

	$c->stash(
		"template" => 'tags/list.tt',
		"outfits"  => \@outfits
	);
}

sub tag :Chained('tag_root') :PathPart('tag') :Args(2) {
	my ($self, $c, $outfit_id, $outfit_name) = @_;

	my $outfit = $c->model('Bindings')->get_outfit_by_id($outfit_id);

	my $breadcrumbs = $c->stash->{'breadcrumb'};
	$breadcrumbs->push('tag', "tag/$outfit_id/$outfit_name");

	$c->stash(
		"template" => 'tags/tag.tt',
		"outfit"  => $outfit
	);
}

sub add :Chained('tag_root') :PathPart('add') :Args(0) {
	my ( $self, $c ) = @_;

	if (lc $c->req->method ne 'post') {
		## forward to error page.
		$c->log->debug('not a post');
	}
	
	my $clothing_id = $c->req->params->{"clothing_id"};
	my $outfit_name = $c->req->params->{"tag"};

	if ($outfit_name eq '') {
		$c->log->warn('User attempted to tag against an empty string');
		$c->res->redirect($c->uri_for($c->controller('Clothes')->action_for('clothing'), $clothing_id, 'x'));
		return;
	}

	my $outfit = $c->model('Bindings')->find_or_create_outfit($outfit_name);
	$c->model('Bindings')->tag_clothing_to_outfit($outfit->outfit_id, $clothing_id);

	my $cln_name = Wardrobe::Util::TemplateUtil::cln($outfit_name);
	$c->res->redirect($c->uri_for('tag', $outfit->outfit_id, $cln_name));

}


=head1 AUTHOR

PTaylor,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
