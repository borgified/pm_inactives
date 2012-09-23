#!/usr/bin/env perl


#need a check for failed pm sending due to wrong recipient name

use warnings;
use strict;


use Alleg::PM;
use Alleg::Squadroster;
use CGI ':standard';

#my %config = do "/secret/alleg.config";

my $username=param('username');
my $password=param('password');

my %input;

$input{'username'}=param('username');
$input{'password'}=param('password');


PM::send_pm(\%input);

print header;
print "grey: ",param('grey'),"\n";
print "red: ",param('red'),"\n";
