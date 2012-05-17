#!/usr/bin/perl -T
use strict;
use warnings;
use Test::More;

eval "use Test::Pod::Coverage 1.04";
if($@) {
    plan skip_all => 
    "Test::Pod::Coverage 1.04 required for testing POD coverage";
}
else {
    plan tests => 1;
}

my(@tests) = (
    [ 'XML::OPML::SimpleGen' => 'Cvs::Simple is covered' ],
);

for my $t (@tests) {
    pod_coverage_ok(@{$t});
}

exit;
