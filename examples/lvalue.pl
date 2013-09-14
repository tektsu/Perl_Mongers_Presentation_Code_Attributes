#!/usr/bin/perl 
use strict;
use warnings;

package MyClass;

sub new {
	my $class = shift;
	my $self = {
		value => 0,
	};

	bless $self, $class;
}

sub value : lvalue {
	my $self = shift;
	return $self->{value};
}

package main;

my $obj = MyClass->new;
print "Value: " . $obj->value . "\n";

$obj->value = 42;
print "Value: " . $obj->value . "\n";

