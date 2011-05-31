package Wardrobe::Model::Clothing;
use Moose;
use namespace::autoclean;
use WardrobeORM;

extends 'Catalyst::Model';

sub get_clothes_by_category {
	my ($self, $category_id) = @_;

	return WardrobeORM->get_schema()->resultset('Clothing')->search({
		'category_id' => $category_id
	});
}

sub get_all_clothes {
	return WardrobeORM->get_schema()->resultset('Clothing')->all();
}

sub get_clothes_by_name {
	my ($self, $search_qry) = @_;

	return WardrobeORM->get_schema()->resultset('Clothing')->search(
		{ 'name' => { 'ilike', '%' . $search_qry . '%' } },
		{
			'join'     => 'tagged_clothing',
			'prefetch' => 'tagged_clothing'
		}
	);

}

sub get_clothing_by_id {
	my ($self, $clothing_id) = @_;

	return WardrobeORM->get_schema()->resultset('Clothing')->find($clothing_id);
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
