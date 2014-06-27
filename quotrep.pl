#!/usr/bin/perl
use strict;
use warnings;

my $username=$ARGV[0] or die " Error: Please supply a username.\n Usage: $0 [username] \n";
my $file = "/home/" . $username . "/Maildir/maildirsize";
my $line= 0; ## Line count
my $size = 0; ## Current usage
my $nummsgs=0; ## Number of messages

open(FILE, "< $file") or die "Error: $file does not exist.\n";
my @lines = <FILE>;
close(FILE);

	## Make sure the first line isn't empty or "0S"
	## The latter can happen after the file has been
	## deleted but has not been fully recreated yet.
	##
        if (length($lines[0]) <5) {
                die "Something's wrong with $file \n";
        }

print "\nQUOTREP for $username \n";
print "==========================================\n";
 
my @quota = split (/S/, $lines[0]);
 
	do {
        	$line++;
        		(my $msgsize, my $msgcount) = split(" ", $lines[$line]);
        	$size+=$msgsize; $nummsgs+=$msgcount;
	} 


	while ($line < $#lines); if ($size > $quota[0]) {
        	print "$username is OVER quota:\n";
	} else {
        	print "$username is under quota:\n";
	}

                print "Quota: ";
                printf("%.0f", $quota[0] / 1024 /1024 /1024);

                print "GB | Current size: ";
                printf ("%.3f", $size / 1024 /1024 /1024);
                print "GB | msgs: $nummsgs\n";

print "\n";
exit 0;

