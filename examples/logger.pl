#!/bin/env perl 
use strict;
use warnings;
use Attribute::Handlers;

sub SayWhen : ATTR(CODE) {
	my ($package, $sym, $code, $name, $data) = @_;

	no warnings 'redefine';
	my $fullname   = "${package}::" . *{$sym}{NAME};
	my $prefix = $data->[0] || '>';
	*{$sym} = sub {
		print "$prefix Entering $fullname\n";
		my @results = $code->(@_);
		print "$prefix Exiting $fullname\n";
		return @results;
	};
}

sub foo : SayWhen {
	my $flavor = shift;
	print "Doing $flavor foo stuff\n";
}

sub bar : SayWhen('***') {
	my $flavor = shift;
	foo($flavor);
	print "Doing $flavor bar stuff\n";
}

foo('sweet');
bar('savory');
