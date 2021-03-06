
package WardrobeModel::WardrobeORM::ResultSet::Clothing;
use base WardrobeModel::WardrobeORM::ResultSetBase;

use Log::Log4perl qw(get_logger);

__PACKAGE__->load_components();

my $log = Log::Log4perl->get_logger();

sub create_with_category {
	my ($self, $clothing_name, $category_name) = @_;

	my $clothing_item = $self->search({
		name => $clothing_name
	})->single;

	my $is_new = 0;

	if (!$clothing_item) {
		my $category_rs = $self->result_source->schema->resultset('Category');
		my $category = $category_rs->find_or_create_by_name($category_name);

		$self->create({
			name     => $clothing_name,
			category => $category
		});

		$is_new = 1;
	}

	return $is_new;

}

sub search_by_category {
	my ($self, $category_id) = @_;
	
	return $self->search({
		'category_id' => $category_id
	});
}


# Case insensitive name search
sub search_by_name_query {
	my ($self, $search_qry) = @_;

	return $self->search({
			name => { 'ilike', '%' . $search_qry . '%' }
		},
		{
			'join'     => 'tagged_clothing',
			'prefetch' => 'tagged_clothing'
		}
	);
}

1;
