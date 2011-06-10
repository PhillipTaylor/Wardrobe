
package WardrobeModel::WardrobeORM::ResultSet::Category;
use base WardrobeModel::WardrobeORM::ResultSetBase;

use Log::Log4perl qw(get_logger);

__PACKAGE__->load_components();

my $log = Log::Log4perl->get_logger();

sub find_or_create_by_name {
	my ($self, $category_name) = @_;

	$log->info("find or create top level category: $category_name");

	my $category = $self->find_or_create({
		name => $category_name
	}, { key => 'category_name' });

	return $category;
}

1;


	#my $category = $self->find_or_create({name => $category_name}, { key => 'category_name' });
