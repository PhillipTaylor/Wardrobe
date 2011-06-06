
use Data::Dump 'pp';
use Log::Log4perl qw(get_logger);

{
	package Breadcrumbs;
	use Moose;

	has 'log',
		is      => 'ro',
		lazy_build => 0,
		default => sub { return Log::Log4perl->get_logger(); };

	has 'breadcrumbs',
		is      => 'rw',
		isa     => 'ArrayRef[HashRef]',
		builder => '_init_breadcrumbs',
		lazy_build => 1;
	#   writer  => accessor_method
	#   default => 'text'

	sub _init_breadcrumbs {
		my $self = shift;

		$self->log->debug("Breadcrumb Initialised");
		$self->breadcrumbs([]);
	}

	sub push {
		my ($self, $name, $url) = @_;

		my $full_url = $self->extend_href($url);

		$self->log->debug("Breadcrumb Pushed: $name ($url expanded to $full_url). New length: "
			. $self->get_depth()
		);

		push(@{ $self->breadcrumbs }, { name => $name, href => $full_url });
		return 1;

	}

	sub get_depth {
		my $self = shift;

		return scalar @{ $self->breadcrumbs };
	}

	sub extend_href {
		my ($self, $additional_url) = @_;

		my $parent = $self->get_parent();
		my $full_url = undef;

		if (!defined($parent) && $additional_url eq "") {
			return '/';
		}

		$full_url = $parent->{'href'} . $additional_url . '/';
		return $full_url;
	}

	sub get_parent {
		my $self = shift;

		my $len = $self->get_depth();

		$len = $len - 1 unless ($len - 1 < 0);

		return @{ $self->breadcrumbs }[ $len ];
	}

}

1;
