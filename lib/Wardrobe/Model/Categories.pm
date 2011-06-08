package Wardrobe::Model::Categories;
use Wardrobe;
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

sub get_all_categories {
	my $self = shift;

	#$self->log->debug('helo');

	use Data::Dump 'pp';
	pp $self;

	my $category_rs = $self->resultset('Category');
	return $category_rs->all();
}

=head1 NAME

Wardrobe::Model::Category - Catalyst Model

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
