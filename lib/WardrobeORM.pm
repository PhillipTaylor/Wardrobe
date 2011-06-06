
package WardrobeORM;
use base qw/DBIx::Class::Schema/;

use Wardrobe;
use Text::CSV::Encoded;
use Log::Log4perl qw(get_logger);

__PACKAGE__->load_namespaces();

my $log = Log::Log4perl->get_logger();

# singleton for accessing the DBIx Schema.
our $schema = undef;

sub get_schema {

	if (!$schema) {
		my $db_connection = Wardrobe->config->{'db_connection_string'};
		my $db_username   = Wardrobe->config->{'db_username'};
		my $db_password   = Wardrobe->config->{'db_password'};
		$log->info("connecting to database...\n");
		$schema = WardrobeORM->connect($db_connection, $db_username, $db_password);
	}

	return $schema;
}

1;
