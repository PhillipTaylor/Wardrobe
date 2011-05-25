package Wardrobe::Controller::Clothes;
use Moose;
use namespace::autoclean;
use Data::Dumper;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

Wardrobe::Controller::Clothes - Catalyst Controller

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

	my %clothes_by_cat = ();
	my %categories = ();
	my @clothes = ();
	my $qry = '';

	$c->log->debug("method = $c->req->method");
	if (lc $c->req->method eq 'post') {
		$qry = $c->req->params->{"name_filter"};
		$c->log->debug("filter: $qry.");
		@clothes = Wardrobe->get_schema()->resultset('Clothing')->search({
			name => { 'like', '%' . $qry . '%' }
		});
	} else {
		@clothes = Wardrobe->get_schema()->resultset('Clothing')->all();
	}
	
	$c->log->debug("There are " . scalar @clothes . " clothing items: " . join(@clothes,', '));

	# Possibly replaceable with DBIx::Class grouping function?
	my $result_count = 0;

	foreach my $item (@clothes) {
		if (exists $clothes_by_cat{$item->category_id}) {
			push(@{ $clothes_by_cat{$item->category_id} }, $item);
			$c->log->debug("$item->name pushed into category $item->category_id");
		} else {
			$clothes_by_cat{$item->category_id} = [ $item ];
			$categories{$item->category_id} = $item->category->name;
			$c->log->debug("$item->name pushed into NEW category $item->category_id");
		}
		$result_count++;
	}

	#$c->log->debug(Dumper(\%clothes_by_cat));

	$c->log->debug("There are " . scalar %categories . " items.");
	$c->log->debug("qry = $qry");

	$c->stash(
		template    => 'clothes/list.tt',
		clothes     => \%clothes_by_cat,
		categories  => \%categories,
		rs_count    => $result_count,
		name_filter => $qry
	);
}

sub clothing :Chained('/') :PathPart('clothes/clothing') :Args(2) {
	my ($self, $c, $clothing_id, $clothing_name) = @_;

	my $item = Wardrobe->get_schema()->resultset('Clothing')->find($clothing_id);

	$c->stash(
		'template' => 'clothes/clothing.tt',
		'item'     => $item
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
