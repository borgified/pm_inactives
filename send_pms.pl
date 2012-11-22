#!/usr/bin/env perl

use CGI qw/:standard/;
use Alleg::Squadroster 1.03;


my @squads = Alleg::Squadroster::list_squads;
my $squad_radio_btn;

foreach my $squad (@squads){
	$squad_radio_btn=$squad_radio_btn."<input type='radio' name='squad' value='$squad'>$squad </input>";
}

print header,start_html;

print <<HTML;
<h1>Send PMs to pilots in your Squad's roster</h1>
<form action="pm_mech.pl" method="POST">
$squad_radio_btn<br>
<input type="checkbox" name="active" value="1">PM actives on Roster Page<br>
<input type="checkbox" name="inactive" value="1" checked>PM inactives on Roster Page<br>
<input type="checkbox" name="unlisted" value="1" >PM pilots NOT LISTED on Roster Page (not enabled by default) <i>talk to fwiffo if you want to use this feature for your squad</i><br>
forum username <input type="text" name="username"><br>
forum password <input type="text" name="password"><br>
<hr>
Message Subject: <input type="text" name="subject"><br>
your PM goes here:<br>
<textarea cols="80" rows="10" name="message"></textarea><br>
<input type="submit" value="Submit">
</form>
</html>
HTML
;


