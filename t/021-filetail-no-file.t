#!/usr/bin/env perl

use 5.12.0;
use strict;
use warnings;

use Devel::Comments;
use File::Temp qw/ tempdir /;
use Test::More;
use Test::Warnings;

use App::PerlWatcher::Levels;
use App::PerlWatcher::Watcher::FileTail;

my $tmpdir = tempdir( CLEANUP => 1 );
my $filename = "$tmpdir/sample.log";

my $received_status;

my $callback_handler = sub {
    $received_status = shift;
};

my $watcher = App::PerlWatcher::Watcher::FileTail->new(
    file            => $filename,
    lines_number    => 5,
    engine_config   => {},
    callback        => $callback_handler,
);

ok defined($watcher), "watcher was created";
$watcher->start;
is $received_status->level, LEVEL_ANY;

done_testing;
