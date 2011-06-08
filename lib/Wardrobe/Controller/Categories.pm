package Wardrobe::Controller::Categories;
use Moose;
use namespace::autoclean;

use Wardrobe::Model::Categories;
use Wardrobe::Model::Clothing;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

Wardrobe::Controller::Categories - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub cat_root :Chained('/root') :PathPart('categories') :CaptureArgs(0) {
	my ($self, $c) = @_;
	
	my $breadcrumbs = $c->stash->{'breadcrumb'};
	$breadcrumbs->push('categories', 'categories');
	
}

sub index :Chained('cat_root') :PathPart('') :Args(0) {
	my ($self, $c) = @_;

	my @categories = $c->model('Categories')->get_all_categories();

	$c->log->debug("There are " . scalar @categories . " categories: " . join(@categories,', '));

	$c->stash(
		template   => 'categories/list.tt',
		categories => \@categories
	);

}

sub category :Chained('cat_root') :PathPart('category') :Args(2) {
	my ($self, $c, $category_id, $category_name) = @_;

	my @clothes = $c->model('Clothing')->get_clothes_by_category($category_id);

	my $breadcrumb = $c->stash->{'breadcrumb'};
	$breadcrumb->push('category',"category/$category_id/$category_name");

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
