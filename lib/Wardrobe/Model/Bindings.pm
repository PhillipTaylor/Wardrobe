
package Wardrobe::Model::Bindings;
use Moose;
extends 'Catalyst::Model';

__PACKAGE__->config (
    schema_class => 'WardrobeModel',
);
