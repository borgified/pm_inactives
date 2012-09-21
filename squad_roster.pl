#!/usr/bin/env perl

use warnings;
use strict;

use LWP::Simple;

my $roster_content = get 'http://asgs.alleg.net/asgsweb/squads.aspx';

my $token='<TD valign=\'top\' nowrap><B><U>';

#my $token='valign';

my @squads= split(/$token/,$roster_content);

shift(@squads);

foreach my $squad (@squads){

#gotta remove all <b> </b> because when it shows up, it doesnt leave a space behind the
#callsign which i use for pattern matching
	$squad =~ s/<b>//gi;
	$squad =~ s/<\/b>//gi;

	$squad=~/^(.*?)&nbsp;.*\(\@(.*?)\)/;

	my $squad_name=$1;
	my $tag=$2;
	print "--------------------------\n";
	print $squad_name," ",$tag,"\n";


#identify squad leadership
	my @squad_leadership;
	my @pilots=split(/<br>/i,$squad);
	foreach my $pilot (@pilots){
		if($pilot =~ /[\*\+\^](.*?) /){
			push(@squad_leadership,$1);
		}
	}
	print "squad leadership: @squad_leadership\n";

#inactives (>30 days)
	my @inactives = split(/<strike>/,$squad);
	my @grey;

	foreach my $inactive (@inactives){
		if($inactive =~/[\*\+\^]?(.*)\s<\/strike> /){
			#print "grey: $1\n";
			push(@grey,$1);
		}
	}
	print "grey: @grey\n";
#reds (>21 days)
	my @red; #sorry for the confusing naming convention...
	my @reds = split(/<font color="red">/,$squad);
	shift(@reds);
	foreach my $red (@reds){
		if($red =~/[\*\+\^]?(.*?)\s<\/strike><\/font>/){
			#print "red: $1\n";
			push(@red,$1);
		}
	}
	print "red: @red\n";
}
