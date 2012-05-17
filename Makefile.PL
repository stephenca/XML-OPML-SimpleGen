use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'XML::OPML::SimpleGen',
    AUTHOR              => 'Marcus Thiesen <marcus@thiesen.org>',
    VERSION_FROM        => 'lib/XML/OPML/SimpleGen.pm',
    ABSTRACT_FROM       => 'lib/XML/OPML/SimpleGen.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
	'DateTime'   => 0,
	'DateTime::Format::Mail' => 0,
	'XML::Simple' => 0,

    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'XML-OPML-SimpleGen-*' },
);
