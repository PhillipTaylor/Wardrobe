
package WardrobeORM;
use Moose;
use namespace::autoclean;
use base qw/DBIx::Class::Schema/;

use Wardrobe;
use Log::Log4perl qw(get_logger);

__PACKAGE__->load_namespaces;

my $log = Log::Log4perl->get_logger();

1;
