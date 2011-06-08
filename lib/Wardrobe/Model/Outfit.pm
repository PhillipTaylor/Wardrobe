package Wardrobe::Model::Outfit;
use Moose;
use namespace::autoclean;
use WardrobeORM;

extends 'Catalyst::Model::DBIC::Schema';
use base 'Catalyst::Model';

__PACKAGE__->config(
    schema_class => 'WardrobeORM',
    
    connect_info => {
        dsn => 'dbi:Pg:dbname=wardrobe',
        user => 'username',
        password => 'password',
		pg_enable_utf8 => 1
    }
);

sub get_all_outfits {
	my $self = shift;

	my $outfit_rs = $self->resultset("Outfit");
	return $outfit_rs->all();

}

sub get_outfit_by_id {
	my ($self, $outfit_id) = @_;

	my $outfit_rs = $self->resultset("Outfit");
	return $outfit_rs->find_by_id($outfit_id);

}

# create_outfit( clothing_name );
sub find_or_create_outfit {
	my ($self, $outfit_name, $clothing_id) = @_;

	my $outfit_rs = $self->resultset("Outfit");
	return $outfit_rs->find_or_create_by_name($outfit_name);

}

sub tag_clothing_to_outfit {
	my ($self, $outfit_id, $clothing_id) = @_;

	# add the clothes to the outfit.
	my $tagged_clothing = $self->resultset('TaggedClothing')->find_or_create({
		clothing_id => $clothing_id,
		outfit_id   => $outfit_id
	});

	return $tagged_clothing;
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
