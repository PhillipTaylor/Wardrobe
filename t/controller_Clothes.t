use strict;
use warnings;
use Test::More;


use Catalyst::Test 'wardrobe';
use wardrobe::Controller::Clothes;

ok( request('/clothes')->is_success, 'Request should succeed' );
done_testing();
