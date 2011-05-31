
package WardrobeORM;
use base qw/DBIx::Class::Schema/;
use Wardrobe;
use Text::CSV::Encoded;
__PACKAGE__->load_namespaces;

# singleton for accessing the DBIx Schema.
our $schema = undef;

sub get_schema {

	if (!$schema) {
		my $db_connection = Wardrobe->config->{'db_connection_string'};
		my $db_username   = Wardrobe->config->{'db_username'};
		my $db_password   = Wardrobe->config->{'db_password'};
		#Util->logger()->info("connecting to database...\n");
		$schema = WardrobeORM->connect($db_connection, $db_username, $db_password);
	}

	return $schema;
}

1;
