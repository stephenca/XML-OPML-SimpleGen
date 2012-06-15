# NAME

XML::OPML::SimpleGen - create OPML using XML::Simple

# VERSION

version 0.06

# SYNOPSIS

    require XML::OPML::SimpleGen;

    my $opml = new XML::OPML::SimpleGen();

    $opml->head(
             title => 'FIFFS Subscriptions',
           );

    $opml->insert_outline(
        group => 'news',  # groups will be auto generated
        text =>  'some feed',
        xmlUrl => 'http://www.somepage.org/feed.xml',
    );

    # insert_outline and add_outline are the same

     $opml->add_group( text => 'myGroup' ); # explicitly create groups
    

    print $opml->to_string;

    $opml->save('somefile.opml');

    $opml->xml_options( $hashref ); # XML::Simple compatible options

    # See XML::OPML's synopsis for more knowledge

# DESCRIPTION

XML::OPML::SimpleGen lets you simply generate OPML documents
without having too much to worry about. 
It is a drop-in replacement for XML::OPML
in regards of generation. 
As this module uses XML::Simple it is rather
generous in regards of attribute or element names.

# NAME

XML::OPML::SimpleGen - create OPML using XML::Simple

# COMMON METHODS

- new( key => value )

Creates a new XML::OPML::SimpleGen instance. All key values will be
used as attributes for the <atom> element. The only thing you might
want to use here is the version => '1.1', which is default anyway.

- head( key => value ) 

XML::OPML compatible head method to change header values. 

- id ( )

Returns (and increments) a counter.

- add\_group ( text => 'name' )

Method to explicitly create a group which can hold multiple outline
elements.

- insert\_outline ( key => value )

XML::OPML compatible method to add an outline element. See
[XML::OPML](http://search.cpan.org/perldoc?XML::OPML) for details. The group key is used to put elements in a
certain group. Non existent groups will be created automagically. 

- add\_outline ( key => value )

Alias to insert\_outline for XML::OPML compatibility.

- as\_string 

Returns the given OPML XML data as a string

- save ( $filename )

Saves the OPML data to a file

# ADVANCED METHODS

- xml\_options ( $hashref ) 

$hashref may contain any XML::Simple options.

- outline ( $hashref )

The outline method defines the 'template' for any new outline
element. You can preset key value pairs here to be used
in all outline elements that will be generated by XML::OPML::SimpleGen.

- group ( $hashref )

This method is similar to outline, it defines the template for a
grouping outline element. 

# MAINTAINER 

Stephen Cardie `<stephenca@cpan.org>`

# REPOSITORY

[https://github.com/stephenca/XML-OPML-SimpleGen](https://github.com/stephenca/XML-OPML-SimpleGen)

# CONTRIBUTORS

- KAPPA `<kappa@cpan.org>` contributed a patch to close RT51000
[https://rt.cpan.org/Public/Bug/Display.html?id=51000](https://rt.cpan.org/Public/Bug/Display.html?id=51000)
- gregoa@debian.org contributed a patch to close RT77725
[https://rt.cpan.org/Public/Bug/Display.html?id=77725](https://rt.cpan.org/Public/Bug/Display.html?id=77725)

# REPO

    The git repository for this module is at
  L<https://github.com/stephenca/XML-OPML-SimpleGen>

# BUGS

Please report any bugs or feature requests to
`bug-xml-opml-simlegen@rt.cpan.org`, or through the web interface at
[http://rt.cpan.org/NoAuth/ReportBug.html?Queue=XML-OPML-SimleGen](http://rt.cpan.org/NoAuth/ReportBug.html?Queue=XML-OPML-SimleGen).
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

# SEE ALSO

[XML::OPML](http://search.cpan.org/perldoc?XML::OPML) [XML::Simple](http://search.cpan.org/perldoc?XML::Simple)

# AUTHOR

Marcus Theisen <marcus@thiesen.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Marcus Thiesen.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
