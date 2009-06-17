#!/usr/bin/perl

package Sling::URL;

=head1 NAME

URL - useful utility functions for manipulating URLs.

=head1 ABSTRACT

Utility library providing useful URL functions for general Rest functionality.

=cut

#{{{imports
use strict;
use lib qw ( .. );
#}}}

#{{{sub add_leading_slash

=pod

=head2 add_leading_slash

Function to add a leading slash to a string if one does not exist.

=cut

sub add_leading_slash {
    my ( $value ) = @_;
    if ( defined $value ) {
        if ( $value !~ /^\// ) {
            $value = "/$value";
        }
    }
    return ( $value );
}
#}}}

#{{{sub strip_leading_slash

=pod

=head2 strip_leading_slash

Function to remove any leading slashes from a string.

=cut

sub strip_leading_slash {
    my ( $value ) = @_;
    if ( defined $value ) {
        $value =~ s/^\///;
    }
    return ( $value );
}
#}}}

#{{{sub properties_array_to_string

=pod

=head2 properties_array_to_string

Function to convert an array of a property values to a suitable string
representation.

=cut

sub properties_array_to_string {
    my ( $properties ) = @_;
    my $property_post_vars;
    foreach my $property ( @{ $properties } ) {
        $property =~ /^([^=]*)=(.*)/;
	if ( defined $1 && defined $2 ) {
            $property_post_vars .= "'$1','$2',";
	}
    }
    $property_post_vars =~ s/,$//;
    return $property_post_vars;
}
#}}}

#{{{sub urlencode

=pod

=head2 urlencode

Function to encode a string so it is suitable for use in urls.

=cut

sub urlencode {
    my ( $value ) = @_;
    $value =~ s/([^a-zA-Z_0-9 ])/"%" . uc(sprintf "%lx" , unpack("C", $1))/eg;
    $value =~ tr/ /+/;
    return ($value);
}
#}}}

#{{{sub url_to_realm

=pod

=head2 url_to_realm

Function to convert an url to a realm - Strips away the http or https and any
query string or trailing path. Adds a port number definition.

=cut

sub url_to_realm {
    my ( $url ) = @_;
    my $realm = $url;
    # Strip any query string:
    $realm =~ s/(.*)\?.*?$/$1/;
    # Strip everything after a first slash - including the slash:
    $realm =~ s#(https?://|)([^/]*).*#$1$2#;
    # Test if port is defined:
    if ( $realm !~ /:[0-9]+$/ ) {
        # No port specified yet, need to add one:
        $realm = ( $realm =~ /^http:/ ? "$realm:80" : "$realm:443" );
    }
    # Strip the protocol for the realm:
    $realm =~ s#https?://(.*)#$1#;
    return $realm;
}
#}}}

1;
