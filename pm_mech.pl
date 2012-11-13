#!/usr/bin/env perl

use warnings;
use strict;

use Alleg::PM 1.03;
use Alleg::Squadroster 1.03;
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
my $leaders = Alleg::Squadroster::list_leadership("$input{'squad'}");

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

#check that at least one active or inactive checkbox was checked
unless(param('active') or param('inactive') or param('unlisted')){
	print "check at least one of active, inactive or unlisted.\n";
	exit;
}


#determine who the recipients are
my @recipients;

if(param('active')){
	my $a=Alleg::Squadroster::list_active($input{'squad'});
	if(defined($a)){
		@recipients=(@recipients,@$a);
	}
}

if(param('inactive')){
	my $a=Alleg::Squadroster::list_inactive($input{'squad'});
	if(defined($a)){
		@recipients=(@recipients,@$a);
	}
}

if(param('unlisted')){
	my $a=Alleg::Squadroster::list_unlisted($input{'squad'});
	if(defined($a)){
		@recipients=(@recipients,@$a);
	}
}

my $num_of_recipients = @recipients;
if($num_of_recipients == 0){
	print "there's nobody to send PMs to.\n";
	exit;
}

$input{'to'}=\@recipients;

#uncomment following 2 lines for testing with fwiffo
#my @testing=("fwiffoa","fwiffob");
#$input{'to'}=\@testing;

$input{'message'}=param('message');
$input{'subject'}=param('subject');
Alleg::PM::send_pm(\%input);

