#!/bin/env perl 
use strict;
use warnings;
use Sub::Attribute;

sub create_test_account {
	print "Create Test Account\n";
}

sub create_test_server {
	print "Create Test Server\n";
}

sub execute_in_transaction {
	my $code = shift;
	print "Start database transaction\n";
	$code->(@_);
	print "Roll back database transaction\n";
}

sub DB:ATTR_SUB {
	my ($package, $symbol, $ref, $attr, $data) = @_;
	my $name   = *{$symbol}{NAME};
	my $fqname = "${package}::$name";

	$data ||= '';
	my $args = eval <<DATA;
	no warnings;
	no strict;
	{$data}
DATA
	$args ||= {};
	$args->{needs} ||= [];

	my @needs;
	for my $need (@{$args->{needs}}) {
		if ($need eq 'test_account') {
			push @needs, \&create_test_account;
			next;
		}
		if ($need eq 'test_server') {
			push @needs, \&create_test_server;
			next;
		}
	}

	no warnings 'redefine';
	no strict 'refs';
	*{$fqname} = sub {
		my $sub = sub {
			for my $need (@needs) {
				$need->();
			}
			$ref->(@_);
		};
		execute_in_transaction($sub, @_);
	};
}

sub test0 {
	print "In test0, args: " . join(', ', @_) . "\n";
}

sub test1 : DB {
	print "In test1, args: " . join(', ', @_) . "\n";
}

sub test2 : DB(needs => ['test_server']) {
	print "In test2, args: " . join(', ', @_) . "\n";
}

sub test3 : DB(needs => ['test_server', 'test_account']) {
	print "In test3, args: " . join(', ', @_) . "\n";
}

test0(1, 2);
test1('foo', 'bar');
test2(1, 'foo');
test3('raxacoricofallapatorius');



