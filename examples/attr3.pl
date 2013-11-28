#!/bin/env perl 
use strict;
use warnings;
use Attribute::Handlers;
use Data::Dumper;

sub Baz:ATTR(CODE) {
	print "Parameters: " . Dumper(\@_);
}

sub doStuff : Baz(1, 'test') {
	print "Doing\n";
}

