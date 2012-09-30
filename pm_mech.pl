#!/usr/bin/env perl

use warnings;
use strict;

use Alleg::PM;
use Alleg::Squadroster;
use CGI ':standard';

my %input;

$input{'username'}=param('username');
$input{'password'}=param('password');
$input{'squad'}=param('squad');
$input{'messaage'}=param('messaage');

print header;

#check if $username belongs to squad leadership, if not, exit with a message
my $leaders = Squadroster::list_leadership($input{'squad'});

my $authorized=0;

foreach my $pilot (@$leaders){
	if($input{'username'} =~ /\b$pilot\b/i){
		$authorized=1;
	}
}

unless($authorized){
	print "you must be part of your squad's leadership to use this app.<br>";
	print "these are your leaders: @$leaders\n";
	exit;
}

#PM::send_pm(\%input);

print "grey: ",param('grey'),"\n";
print "red: ",param('red'),"\n";
print "radio: ",param('squad'),"\n";
print "username: ",param('username'),"\n";
print "password: ",param('password'),"\n";
print "textarea: ",param('message'),"\n";
