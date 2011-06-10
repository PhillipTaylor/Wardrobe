package Wardrobe::Controller::Root;
use Moose;
use namespace::autoclean;

use Wardrobe::Util::TemplateUtil;
use Wardrobe::Util::Breadcrumbs;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=head1 NAME

Wardrobe::Controller::Root - Root Controller for Wardrobe

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub root :Chained('/') :PathPart('') :CaptureArgs(0) {
	my ($self, $c) = @_;

	$c->log->debug('BEGIN OF ROOT::root()');

	# register template util functions
	Wardrobe::Util::TemplateUtil->init($c);

	my $breadcrumbs = Wardrobe::Util::Breadcrumbs->new();
	$c->stash->{'breadcrumb'} = $breadcrumbs;
	$breadcrumbs->push('home', '');
	
	$c->log->debug('END OF ROOT::root()');

}

sub index :Chained('root') :PathPart('') :Args(0) {
    my ( $self, $c ) = @_;

    $c->stash(
		template        => 'index.tt',
	);
}

=head2 default

Standard 404 error page

=cut

sub default :Chained('root') :Args(0) {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

sub csv_upload :Chained('root') :Args(0) {
	my ( $self, $c) = @_;
	
	$c->log->debug('breadcrumb later = ' . join(', ', keys %{ $c->stash }));

	my @results = ();
	my $upload = $c->req->upload('csv_file');

	if (!defined($upload)) {
		$c->res->redirect($c->uri_for(''));
		return;
	}

	# assume header record for website
	$c->log->debug('enter the function');
	my ($rows, $bad, $dupes) = $c->model('Bindings')->create_from_csv_file($upload->tempname, 1);
	$c->log->debug('return from function');

	$c->stash(
		template        => 'index.tt',
		upload_complete => 1,
		rows            => $rows,
		bad             => $bad,
		dupes           => $dupes
	);

}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {
	my ($self, $c) = @_;

	# URI's ending with .json served up as JSON
	if ($c->request->path =~ /.json$/) {
		$c->stash->{current_view} = 'JSON';
	}
}

=head1 AUTHOR

PTaylor,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
