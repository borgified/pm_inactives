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
$input{'message'}=param('message');

print header;

#check that all fields are completely filled
foreach my $field (keys %input){
	if(($input{$field} eq '') or !(defined($input{$field}))){
		print "$field is empty<br>\n";
		print "need to enter all information before submitting.\n";
		exit;
	}
}

#check if $username belongs to squad leadership, if not, exit with a message
my $leaders = Squadroster::list_leadership("$input{'squad'}");

my $authorized=0;

foreach my $pilot (@$leaders){
	if($input{'username'} =~ /\b$pilot\b/i){
		$authorized=1;
	}
}

#uncomment following 3 lines backdoor for testing w/ fwiffo
#if($input{'username'} =~ /\bfwiffo\b/i){
#	$authorized=1;
#}

unless($authorized){
	print "you must be part of your squad's leadership to use this app.<br>";
	print "these are your leaders: @$leaders\n";
	exit;
}

#determine who the recipients are
my @recipients;

my $a=Squadroster::list_inactive($input{'squad'});
if(!defined($a)){
	print "there are no inactive pilots in your squad.\n";
	exit;
}else{
	@recipients=@$a;
}

$input{'to'}=\@recipients;

#uncomment following 2 lines for testing with fwiffo
#my @testing=("fwiffo","fwiffo");
#$input{'to'}=\@testing;

$input{'message'}=param('message');
$input{'subject'}=param('subject');
PM::send_pm(\%input);

