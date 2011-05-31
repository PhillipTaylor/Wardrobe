package Wardrobe::Model::Outfit;
use Moose;
use namespace::autoclean;
use WardrobeORM;

extends 'Catalyst::Model';

sub get_all_outfits {
	return WardrobeORM->get_schema()->resultset('Outfit')->all();
}

sub get_outfit_by_id {
	my ($self, $outfit_id) = @_;

	return WardrobeORM->get_schema()->resultset('Outfit')->find($outfit_id);
}

# create_outfit( clothing_name );
sub create_outfit {
	my ($self, $outfit_name, $clothing_id) = @_;

	my $outfit = WardrobeORM->get_schema()->resultset("Outfit")->search({
		name => $outfit_name
	})->single;

	if (!defined($outfit)) {
		# create outfit here.
		$outfit = WardrobeORM->get_schema()->resultset('Outfit')->create({
			name => $outfit_name
		});
	}

	return $outfit;

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
