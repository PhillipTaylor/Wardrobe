
package Wardrobe::Model::Main;
use base qw/DBIx::Class::Schema/;
__PACKAGE__->load_namespaces;

# TODO: Only creates it if it doesn't already exist.
sub create_clothing_and_category {
	my ($self, $clothing_name, $category_name) = @_;
	Wardrobe->log->debug("Parsed: Clothing Name: $clothing_name| Category Name: $category_name");

	my $clothing_item = Wardrobe->get_schema()->resultset('Clothing')->search({
		name => $clothing_name
	})->single;

	if ($clothing_item) {
		Wardrobe->log->warn('Existing clothing item found. skipped');
		return;
	}

	my $category = Wardrobe->get_schema()->resultset('Category')->find_or_create({
		name => $category_name
	}, { key => 'category_name' });

	Wardrobe->log->info("creating new clothing: $clothing_name (category already exists: $category->in_storage)");
	$clothing_item = Wardrobe->get_schema()->resultset('Clothing')->create({
		name => $clothing_name,
		category => $category
	});
	
}

1;
