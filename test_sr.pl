#!/usr/bin/env perl

use strict;
use warnings;
use squad_roster;

my @squads=Squadroster::list_squads;

print "squads: @squads\n";

my $grey_sysx = Squadroster::list_grey("SysX");

print "@$grey_sysx";
