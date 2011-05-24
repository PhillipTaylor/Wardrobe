use strict;
use warnings;
use Test::More;


use Catalyst::Test 'wardrobe';
use wardrobe::Controller::Categories;

ok( request('/categories')->is_success, 'Request should succeed' );
done_testing();
