package Wardrobe::Model::Interface;
use Moose;
use namespace::autoclean;
use WardrobeORM;

extends 'Catalyst::Model';

=head1 NAME

Wardrobe::Model::Wardrobe - Catalyst Model

=head1 DESCRIPTION

Catalyst Model.

=head1 AUTHOR

PTaylor,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

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

	#Wardrobe->log->info("loading in new data from $csv_filename");

	open my $fh, "<", $csv_filename;

	my $line_no   = 0;
	my $bad       = 0;
	my $dupes     = 0;

	foreach my $line (<$fh>) {
		
		if (!$parser->parse($line)) {
			#Wardrobe->log->warn("Skipped line $line_no - broken");
			$bad++;
		} else {

			if ($line_no == 0 && $header_record) {
				$line_no++;
				next;
			} else {
				(my $clothing_name, my $category_name) = $parser->fields();
				my $added = create_clothing_and_category($clothing_name, $category_name);

				$dupes++ unless $added;
			}
		}

		$line_no++;
	}

	close $fh;

	# ensure record count is accurate.
	$line_no-- unless !$header_record;

	return ($line_no, $bad, $dupes);
}

sub create_clothing_and_category {
	my ($clothing_name, $category_name) = @_;
	#Wardrobe->log->debug("Parsed: Clothing Name: $clothing_name| Category Name: $category_name");

	my $clothing_item = WardrobeORM->get_schema()->resultset('Clothing')->search({
		name => $clothing_name
	})->single;

	if ($clothing_item) {
	#	Wardrobe->log->warn('Existing clothing item found. skipped');
		return 0;
	}

	my $category = Category->find_or_create_category($category_name);

	#Wardrobe->log->info("creating new clothing: $clothing_name (category already exists: $category->in_storage)");
	$clothing_item = WardrobeORM->get_schema()->resultset('Clothing')->create({
		name => $clothing_name,
		category => $category
	});

	return 1;
}

__PACKAGE__->meta->make_immutable;

1;
