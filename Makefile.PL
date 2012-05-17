use strict;
use warnings;
use ExtUtils::MakeMaker;
require 5.006;

WriteMakefile(
    NAME                => 'XML::OPML::SimpleGen',
    AUTHOR              => 'Marcus Thiesen <marcus@thiesen.org>',
    VERSION_FROM        => 'lib/XML/OPML/SimpleGen.pm',
    ABSTRACT_FROM       => 'lib/XML/OPML/SimpleGen.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'version'      => 0,
        'Test::More'   => 0,
        'XML::Simple'  => 0,
        'Class::Accessor' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'XML-OPML-SimpleGen-*' },
);
