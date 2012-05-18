#!/usr/bin/env perl -T
use strict;
use warnings;

use Test::More tests => 2;
use POSIX qw/setlocale LC_ALL/;

BEGIN {
	use_ok( 'XML::OPML::SimpleGen' );
}

setlocale(LC_ALL, "ru_RU.utf8");

my $data = XML::OPML::SimpleGen->new()->as_string;

like($data, qr/<dateCreated>[a-z]{3}, \d+ [a-z]{3} \d{4} \d\d:\d\d:\d\d/i);
#was <dateCreated>Сбт, 31 Окт 2009 15:51:22 +0300</dateCreated>
