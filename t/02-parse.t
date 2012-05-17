#!perl -T
use Test::More ;

BEGIN {
	use_ok( 'XML::OPML::SimpleGen' );
}

eval "use XML::OPML";
plan skip_all => "XML::OPML required for parse tests" if ($@);
plan tests => 1;

my $obj = new XML::OPML::SimpleGen;
$obj->insert_outline(text => 'test');
my $data = $obj->as_string;

my $opml = new XML::OPML;


$opml->parse($data);


isa_ok($opml, 'XML::OPML');


