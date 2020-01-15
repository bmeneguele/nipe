#!/usr/bin/env perl

use 5.018;
use Switch;
use lib "./lib/";
use Nipe::Stop;
use Nipe::Start;
use Nipe::CheckIp;
use Nipe::Functions;

sub main {
	my $command = $ARGV[0];

	switch ($command) {
		case "stop" {
			Nipe::Stop -> new();
		}
		case "start" {
			Nipe::Start -> new();
		}
		case "status" {
			Nipe::CheckIp -> new();
		}
		case "restart" {
			Nipe::Stop -> new();
			Nipe::Start -> new();
		}
		case "install" {
			my $force_cfg = undef;

			if ($ARGV[1] eq "-f") {
				$force_cfg = 1;
			}

			Nipe::Functions -> install($force_cfg);
		}

		Nipe::Functions -> help();
	}
}

main();
exit;