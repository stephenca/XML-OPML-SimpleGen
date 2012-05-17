use Test::More tests => 2;

use File::Spec::Functions;
use lib catdir('..', 'lib');

BEGIN {
	use_ok( 'XML::OPML::SimpleGen' );
}

use XML::OPML;

my $obj = new XML::OPML::SimpleGen;
$obj->insert_outline(text => 'test');
my $data = $obj->as_string;

my $opml = new XML::OPML;


$opml->parse($data);


isa_ok($opml, 'XML::OPML');


