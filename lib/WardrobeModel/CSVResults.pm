
package WardrobeModel::CSVResults;
use Moose;

use Log::Log4perl qw(get_logger);

my $log = Log::Log4perl->get_logger();

has 'dupes',
	is  => 'rw',
	isa => 'ArrayRef[Str]',
	builder => '_init_empty_dupes';

has 'ok',
	is  => 'rw',
	isa => 'ArrayRef[Str]',
	builder => '_init_empty_ok';

has 'broken',
	is  => 'rw',
	isa => 'ArrayRef[Str]',
	builder => '_init_empty_broken';

sub _init_empty_dupes {
	my $self = shift;
	$self->dupes([]);
}

sub _init_empty_ok {
	my $self = shift;
	$self->ok([]);
}

sub _init_empty_broken {
	my $self = shift;
	$self->broken([]);
}

sub mark_dupe {
	my ($self, $line) = @_;
	push(@{ $self->dupes }, $line);
	$line = $self->get_total_count() . ': ' . $line;
	$log->debug(join('DUPE LINE: ', $self->get_total_count(), ', reads: ', $line, ' [', $self->get_dupe_count(), ' / ', $self->get_total_count(), ']'));
}

sub mark_ok {
	my ($self, $line) = @_;
	push(@{ $self->ok }, $line);
	$line = $self->get_total_count() . ': ' . $line;
	$log->debug(join('OK LINE: ', $self->get_total_count(), ', reads: ', $line, ' [', $self->get_ok_count(), ' / ', $self->get_total_count(), ']'));
}

sub mark_broken {
	my ($self, $line) = @_;
	push(@{ $self->broken }, $line);
	$line = $self->get_total_count() . ': ' . $line;
	$log->debug(join('BROKEN LINE: ', $self->get_total_count(), ', reads: ', $line, ' [', $self->get_broken_count(), ' / ', $self->get_total_count(), ']'));
}

sub get_dupe_count {
	my $self = shift;
	return scalar @{ $self->dupes };
}

sub get_ok_count {
	my $self = shift;
	return scalar @{ $self->ok };
}

sub get_broken_count {
	my $self = shift;
	return scalar @{ $self->broken };
}

sub get_total_count {
	my $self = shift;
	return (
		  $self->get_broken_count()
		+ $self->get_ok_count()
		+ $self->get_dupe_count()
	);
}

1;
