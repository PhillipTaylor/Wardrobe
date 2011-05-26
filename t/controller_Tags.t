use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Wardrobe';
use Wardrobe::Controller::Tags;

ok( request('/tags')->is_success, 'Request should succeed' );
done_testing();
