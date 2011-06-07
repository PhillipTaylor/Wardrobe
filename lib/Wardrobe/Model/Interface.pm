package Wardrobe::Model::Interface;
use Moose;
use namespace::autoclean;
use WardrobeORM;
use WardrobeORM::ResultSet::Clothing;
use Text::CSV::Encoded;
use Log::Log4perl qw(get_logger);

extends 'Catalyst::Model';

my $log = Log::Log4perl->get_logger();

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

	open my $fh, "<", $csv_filename;

	my $line_no   = 0;
	my $bad       = 0;
	my $dupes     = 0;

	while (my $raw_line = $parser->getline($fh)) {
		my $line = $parser->string($raw_line);
		chomp($line);

		if (!$parser->parse($line)) {
			$bad++;
			$log->debug("LINE: $line - BAD");
		} else {

			if ($line_no == 0 && $header_record) {
				$line_no++;
				$log->debug("LINE: $line - HEADER RECORD");
				next;
			} else {
				my @cols = $parser->fields($line);

				if (@cols < 2) {
					$bad++;
					$line_no++;
					$log->debug("LINE: $line - MISSING FIELDS");
					next;
				}

				(my $clothing_name, my $category_name) = @cols;

				if ($clothing_name eq '' || $category_name eq '') {
					$bad++;
					$line_no++;
					$log->debug("LINE: $line - EMPTY STRING FIELD");
					next;
				}

				my $is_new = create_clothing_and_category($clothing_name, $category_name);

				if ($is_new) {
					$log->debug("LINE: $line - ADDED");
				} else {
					$log->debug("LINE: $line - DUPE");
					$dupes++;
				}

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
	
	my $clothing_rs = WardrobeORM->get_schema()->resultset('Clothing');
	return $clothing_rs->create_with_category($clothing_name, $category_name);

}

__PACKAGE__->meta->make_immutable;

1;
