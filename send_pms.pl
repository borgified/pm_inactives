#!/usr/bin/env perl

use CGI qw/:standard/;

print header,start_html;

print <<HTML;
<h1>Recall inactive pilots back into active duty</h1>
<form action="pm_mech.pl" method="POST">
<input type="checkbox" name="grey" value="1"> grey inactives <br>
<input type="checkbox" name="red" value="1"> red inactives <br>
forum username <input type="text" name="username"><br>
forum password <input type="text" name="password"><br>
<textarea cols="80" rows="10" name="message"></textarea><br>
<input type="submit" value="Submit">
</form>
</html>
HTML
;


