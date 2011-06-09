
package WardrobeModel::WardrobeORM;
use Moose;
use namespace::autoclean;
use base qw/DBIx::Class::Schema/;

use Wardrobe;
use Log::Log4perl qw(get_logger);

__PACKAGE__->load_namespaces;

my $log = Log::Log4perl->get_logger();

__PACKAGE__->config(
    connect_info => {
        dsn            => 'dbi:Pg:dbname=wardrobe',
        user           => 'username',
        password       => 'password',
        pg_enable_utf8 => 1
    }
);

1;
