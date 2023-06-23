#!/usr/bin/perl
# sample script to query ccminer API
use strict;
use warnings;
use Getopt::Long qw(GetOptions);

# default values
my $command = "summary";
my $address = "127.0.0.1";
my $port = "4068";

# get command line options
GetOptions('cmd=s' => \$command,
           'address=s' => \$address,
           'port=s' => \$port,
) or die "Usage: $0 --cmd COMMAND --address ADDRESS --port PORT\n";

# create socket
use Socket;

# create socket
use IO::Socket::INET;

# auto-flush on socket
my $sock = new IO::Socket::INET (
    PeerAddr => $address,
    PeerPort => $port,
    Proto => 'tcp',
    ReuseAddr => 1,
    Timeout => 2,
);


# send command
if ($sock) {
    print $sock $command;
    my $res = "";
    while(<$sock>) {
        $res .= $_;
    }
    close($sock);
    print("$res\n");
} else {
    print("No Connection\n");
}
