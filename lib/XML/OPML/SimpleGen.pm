########################################################################
#  
#    XML::OPML::SimpleGen
#
#    Copyright 2005, Marcus Thiesen (marcus@thiesen.org)  All rights reserved.
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of either:
#
#    a) the GNU General Public License as published by the Free Software
#    Foundation; either version 1, or (at your option) any later
#       version, or
#
#    b) the "Artistic License" which comes with Perl.
#
#    On Debian GNU/Linux systems, the complete text of the GNU General
#    Public License can be found in `/usr/share/common-licenses/GPL' and
#    the Artistic Licence in `/usr/share/common-licenses/Artistic'.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
#
########################################################################

package XML::OPML::SimpleGen;

use strict;
use warnings;

use base 'Class::Accessor';
use POSIX qw(strftime);

__PACKAGE__->mk_accessors(qw|groups xml_options outline group xml_head xml_outlines xml|);

our $VERSION;
use version; $VERSION = version->new(0.04);

sub new {
    my $class = shift;
    my @args = @_;

    my $args = {
	    groups  => {},

	    xml     => {
	        version     => '1.1',
	        @args,
	        },			

	    # XML::Simple options
	    xml_options => {
	        RootName    => 'opml', 
	        XMLDecl     => '<?xml version="1.0" encoding="utf-8" ?>',
	        AttrIndent  => 1,
	    },

	    # default values for nodes
	    outline => {
	        type        => 'rss',
	        version     => 'RSS',
	        text        => '',
	        title       => '',
	        description => '',
	    },

	    group => {
	        isOpen      => 'true',
	    },

	    xml_head        => {},
	    xml_outlines    => [],

	    id              => 1,
    };

    my $self = bless $args, $class;

    $self->head(
        title => '',
        dateCreated  => strftime( "%a, %e %b %Y %H:%M:%S %z", localtime ),
        dateModified => strftime( "%a, %e %b %Y %H:%M:%S %z", localtime ),
    );

    return $self;
}

sub id {
    my $self = shift;
    
    return $self->{id}++;
}

sub head {
    my $self = shift;
    my $data = {@_};

    #this is necessary, otherwise XML::Simple will just generate attributes
    while (my ($key,$value) = each %{ $data }) {
	    $self->xml_head->{$key} = [ $value ];
    }
}

sub add_group {
    my $self = shift;
    my %defaults = %{$self->group};
    my $data = {
        id => $self->id,
        %defaults,
        @_ };
 
    die "Need to define 'text' attribute" unless defined $data->{text};

    $data->{outline} = [];

    push @{$self->xml_outlines}, $data;
    $self->groups->{$data->{text}} = $data->{outline};
}

sub insert_outline {
    my $self = shift;
    my %defaults = %{$self->outline};
    my $data = {
        id => $self->id,
        %defaults,
        @_};

    my $parent = $self->xml_outlines;

    if (exists $data->{group}) {
	    if (exists $self->groups->{$data->{group}}) {
	        $parent = $self->groups->{$data->{group}};
	        delete($data->{group});
	    }
        else {
	        $self->add_group('text' => $data->{group});
	        $self->insert_outline(%$data);
	        return;
	    }
    }

    push @{$parent}, $data;
}

sub add_outline {
    my $self = shift;
    $self->insert_outline(@_);
}

sub as_string {
    my $self = shift;

    require XML::Simple;
    my $xs = new XML::Simple();

    return $xs->XMLout( $self->_mk_hashref, %{$self->xml_options} );
}

sub _mk_hashref {
    my $self = shift;

    my $hashref =  {
	    %{$self->xml},
	    head => $self->xml_head,
	    body => { outline => $self->xml_outlines },
    };

    return $hashref;
}

sub save {
    my $self = shift;
    my $filename = shift;

    require XML::Simple;
    my $xs = new XML::Simple();

    $xs->XMLout( $self->_mk_hashref, %{$self->xml_options}, OutputFile => $filename );
}

1;

=pod

=head1 NAME

XML::OPML::SimpleGen - create OPML using XML::Simple

=head1 SYNOPSIS

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


=head1 DESCRIPTION

XML::OPML::SimpleGen lets you simply generate OPML documents
without having too much to worry about. 
It is a drop-in replacement for XML::OPML
in regards of generation. 
As this module uses XML::Simple it is rather
generous in regards of attribute or element names.

=head1 COMMON METHODS

=over

=item new( key => value )

Creates a new XML::OPML::SimpleGen instance. All key values will be
used as attributes for the <atom> element. The only thing you might
want to use here is the version => '1.1', which is default anyway.

=item head( key => value ) 

XML::OPML compatible head method to change header values. 

=item id ( )

Returns (and increments) a counter.

=item add_group ( text => 'name' )

Method to explicitly create a group which can hold multiple outline
elements.

=item insert_outline ( key => value )

XML::OPML compatible method to add an outline element. See
L<XML::OPML> for details. The group key is used to put elements in a
certain group. Non existent groups will be created automagically. 

=item add_outline ( key => value )

Alias to insert_outline for XML::OPML compatibility.

=item as_string 

Returns the given OPML XML data as a string

=item save ( $filename )

Saves the OPML data to a file

=back

=head1 ADVANCED METHODS

=over

=item xml_options ( $hashref ) 

$hashref may contain any XML::Simple options.

=item outline ( $hashref )

The outline method defines the 'template' for any new outline
element. You can preset key value pairs here to be used
in all outline elements that will be generated by XML::OPML::SimpleGen.

=item group ( $hashref )

This method is similar to outline, it defines the template for a
grouping outline element. 

=back

=head1 AUTHOR

Marcus Thiesen, C<< <marcus@thiesen.org> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-xml-opml-simlegen@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=XML-OPML-SimleGen>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SEE ALSO

L<XML::OPML> L<XML::Simple>

=head1 COPYRIGHT & LICENSE

Copyright 2005-2007 Marcus Thiesen, All Rights Reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 CVS

$Id: SimpleGen.pm,v 1.9 2008/02/08 10:33:43 stephenca Exp $

=cut
