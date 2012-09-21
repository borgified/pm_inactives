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
	foreach my $inactive (@inactives){
		if($inactive =~/(.*)<\/strike> /){
			print "grey: $1\n";
		}
	}
#reds (>21 days)
	my @reds = split(/<font color="red">/,$squad);
	shift(@reds);
	foreach my $red (@reds){
		if($red =~/(.*?) <\/strike><\/font>/){
			print "red: $1\n";
		}
	}
}
