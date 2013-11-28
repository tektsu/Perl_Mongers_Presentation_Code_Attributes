#!/bin/env perl 
use strict;
use warnings;
use attributes;
use Scalar::Util qw|refaddr|;

BEGIN {
	our $attributes = {};
}

our $attributes;

sub MODIFY_CODE_ATTRIBUTES {
	my ($class, $code, @attributeList) = @_;
	$attributes->{refaddr $code} = \@attributeList;
	return;
}

sub FETCH_CODE_ATTRIBUTES {
	my ($class, $code) = @_;
	return @{ $attributes->{refaddr $code} };
}

sub cat : Calico : Female : Underfoot {}

sub dog : Collie : Female : LikesSquirrels {}

print "Cat: ", join(', ', attributes::get(\&cat)), "\n";
print "Dog: ", join(', ', attributes::get(\&dog)), "\n";




