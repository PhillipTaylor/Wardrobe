package Wardrobe::Model::Outfit;
use Moose;
use namespace::autoclean;
use WardrobeORM;

extends 'Catalyst::Model';

sub get_all_outfits {

	my $outfit_rs = WardrobeORM->get_schema()->resultset("Outfit");
	return $outfit_rs->all();

}

sub get_outfit_by_id {
	my ($self, $outfit_id) = @_;

	my $outfit_rs = WardrobeORM->get_schema()->resultset("Outfit");
	return $outfit_rs->find_by_id($outfit_id);

}

# create_outfit( clothing_name );
sub find_or_create_outfit {
	my ($self, $outfit_name, $clothing_id) = @_;

	my $outfit_rs = WardrobeORM->get_schema()->resultset("Outfit");
	return $outfit_rs->find_or_create_by_name($outfit_name);

}

sub tag_clothing_to_outfit {
	my ($self, $outfit_id, $clothing_id) = @_;

	# add the clothes to the outfit.
	WardrobeORM->get_schema()->resultset('TaggedClothing')->create({
		clothing_id => $clothing_id,
		outfit_id   => $outfit_id
	});

}

=head1 NAME

Wardrobe::Model::Outfit - Catalyst Model

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
