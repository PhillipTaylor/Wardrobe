
package WardrobeModel::WardrobeORM;
use Moose;
use namespace::autoclean;
use Text::CSV::Encoded;
use WardrobeModel::CSVResults;
use base qw/DBIx::Class::Schema/;

use Log::Log4perl qw(get_logger);

__PACKAGE__->load_namespaces;

my $log = Log::Log4perl->get_logger();

sub get_all_categories {
	my $self = shift;

	my $category_rs = $self->resultset('Category');
	return $category_rs->all();
}

sub get_clothes_by_category {
	my ($self, $category_id) = @_;

	my $clothing_rs = $self->resultset('Clothing');
	return $clothing_rs->search_by_category($category_id);
}

sub get_all_clothes {
	my $self = shift;

	my $clothing_rs = $self->resultset('Clothing');
	return $clothing_rs->all();
}

sub get_clothes_by_name {
	my ($self, $search_qry) = @_;

	my $clothing_rs = $self->resultset('Clothing');
	return $clothing_rs->search_by_name_query($search_qry);
}

sub get_clothing_by_id {
	my ($self, $clothing_id) = @_;

	my $clothing_rs = $self->resultset('Clothing');
	return $clothing_rs->find_by_id($clothing_id);

}

# create_from_csv_file (str filename, bool header_record);
sub create_from_csv_file {
	my ($self, $csv_filename, $header_record) = @_;

	my $parser = Text::CSV::Encoded->new({
		encoding_in      => "utf8",
		encoding_out     => "utf8",
		escape_char      => '"',
		sep_char         => ',',
		allow_whitespace => 1
	});

	my $results = WardrobeModel::CSVResults->new();
	my $first_row = 0;

	open my $fh, "<", $csv_filename;

	while (my $raw_line = $parser->getline($fh)) {
		my $line = $parser->string($raw_line);
		chomp($line);

		if (!$parser->parse($line)) {
			$results->mark_broken($line);
			next;
		}

		if ($first_row == 0 && $header_record) {
			$first_row = 1;
			next;
		} 
		
		my @cols = $parser->fields($line);

		if (@cols < 2) {
			$results->mark_broken($line);
			next;
		}

		(my $clothing_name, my $category_name) = @cols;

		if ($clothing_name eq '' || $category_name eq '') {
			$results->mark_broken($line);
			next;
		}

		my $is_new = $self->_create_clothing_and_category($clothing_name, $category_name);

		if ($is_new) {
			$results->mark_ok($line);			
		} else {
			$results->mark_dupe($line);
		}
	}

	close $fh;

	return $results;
}

sub _create_clothing_and_category {
	my ($self, $clothing_name, $category_name) = @_;

	my $clothing_rs = $self->resultset('Clothing');
	return $clothing_rs->create_with_category($clothing_name, $category_name);

}

sub get_all_outfits {
	my $self = shift;

	my $outfit_rs = $self->resultset("Outfit");
	return $outfit_rs->all();

}

sub get_outfit_by_id {
	my ($self, $outfit_id) = @_;

	my $outfit_rs = $self->resultset("Outfit");
	return $outfit_rs->find_by_id($outfit_id);

}

# create_outfit( clothing_name );
sub find_or_create_outfit {
	my ($self, $outfit_name, $clothing_id) = @_;

	my $outfit_rs = $self->resultset("Outfit");
	return $outfit_rs->find_or_create_by_name($outfit_name);

}

sub tag_clothing_to_outfit {
	my ($self, $outfit_id, $clothing_id) = @_;

	# add the clothes to the outfit.
	my $tagged_clothing = $self->resultset('TaggedClothing')->find_or_create({
		clothing_id => $clothing_id,
		outfit_id   => $outfit_id
	});

	return $tagged_clothing;
}

__PACKAGE__->meta->make_immutable;


1;
