
package Wardrobe::TemplateUtil;

# register all these functions
sub init {
	my ($self, $c) = @_;

	$c->stash->{'cln'} = \&cln;
}


# cln function. Cleans names going into uris

# turn name strings like
#	"i am clothing name<script>roar</script>"
# into
#	"i-am-clothing-name<script>roar<script>"
sub cln {
	my $input = shift;

	$input =~ s/\///g;
	$input =~ s/\s+/-/g;

	return $input;
}

1;
