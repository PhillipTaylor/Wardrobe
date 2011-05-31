use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Wardrobe';
use Wardrobe::Controller::Clothes;

ok( request('/clothes')->is_success, 'Request should succeed' );
done_testing();
