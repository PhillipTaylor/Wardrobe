package Wardrobe;
use Moose;
use namespace::autoclean;
use Wardrobe::Model::Main;

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
/;

extends 'Catalyst';

our $VERSION = '0.01';

# Configure the application.
#
# Note that settings in Wardrobe.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
    name => 'Wardrobe',
    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,
);

our $logger = Catalyst::Log::Log4perl->new();

__PACKAGE__->log($logger);

our $schema = Wardrobe::Model::Main->connect('dbi:Pg:dbname=wardrobe', 'username', 'password');

sub get_schema {
	return $schema;
}

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
