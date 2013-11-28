#!/bin/env perl 
use strict;
use warnings;
use Attribute::Handlers;

sub Foo:ATTR(CODE) {
	print "foo!\n";
}

sub doSomethingUseful : Foo {
	print "Doing useful things\n";
}

sub doSomethingElseUseful : Foo {
	print "Doing more useful things\n";
}

doSomethingUseful;
doSomethingElseUseful;
doSomethingElseUseful;

