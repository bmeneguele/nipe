#!/usr/bin/env perl

package Nipe::Functions;

use Nipe::Device;

sub help {
	print "
		\r\Core Commands
		\r==============
		\r\tCommand       Description
		\r\t-------       -----------
		\r\tinstall       Install dependencies
		\r\t  -f          Overwrite Tor config file in /etc/tor/torrc
		\r\tstart         Start routing
		\r\tstop          Stop routing
		\r\trestart       Restart the Nipe process
		\r\tstatus        See status

		\rCopyright (c) 2015 - 2020 | Heitor Gouvêa\n\n";

	return true;
}

sub install {
	shift; # ignore class name
	my $force_cfg = shift;
	my $operationalSystem = Nipe::Device -> getSystem();

	if ($operationalSystem eq "debian") {
		system ("sudo apt-get install tor iptables");
	}
	
	elsif ($operationalSystem eq "fedora") {
		system ("sudo dnf install tor iptables");
	}

	elsif ($operationalSystem eq "centos") {
		system ("sudo yum install epel-release tor iptables");
	}

	else {
		system ("sudo pacman -S tor iptables");
	}

	if (defined($force_cfg)) {
		print "[.] Overwriting system Tor's config file\n";
		print "[.]   .configs/$operationalSystem-torrc -> /etc/tor/torrc\n";
		system ("sudo cp .configs/$operationalSystem-torrc /etc/tor/torrc");
		system ("sudo chmod 644 /etc/tor/torrc");
	}

	else {
		print "[.] Refer to our custom Tor config files in project home\n";
	}

	if (-e "/etc/init.d/tor") {
		system ("sudo /etc/init.d/tor stop > /dev/null");
	}

	else {
		system ("sudo systemctl stop tor");
	}

	return true;
}

1;