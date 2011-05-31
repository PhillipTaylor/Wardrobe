package Wardrobe;
use Moose;
use namespace::autoclean;
use WardrobeORM;

use Catalyst::Runtime 5.80;

use Catalyst::Log::Log4perl;

# Set flags and add plugins for the application.
#
# Note that ORDERING IS IMPORTANT here as plugins are initialized in order,
# therefore you almost certainly want to keep ConfigLoader at the head of the
# list if you're using it.
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
    -Debug
    ConfigLoader
    Static::Simple
    Unicode
/;

use Data::Dumper;

extends 'Catalyst';

our $VERSION = '0.01';

__PACKAGE__->config('Plugin::ConfigLoader' => { file => 'Wardrobe.conf'});

our $logger = Catalyst::Log::Log4perl->new();
#Util->set_logger($logger);
__PACKAGE__->log($logger);

# Start the application
__PACKAGE__->setup();


=head1 NAME

Wardrobe - Catalyst based application

=head1 SYNOPSIS

    script/Wardrobe_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<Wardrobe::Controller::Root>, L<Catalyst>

=head1 AUTHOR

PTaylor,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
