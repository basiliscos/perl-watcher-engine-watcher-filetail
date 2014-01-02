#!/usr/bin/env perl

use 5.12.0;
use strict;
use warnings;

use AnyEvent;
use Carp;
use Devel::Comments;
use File::Basename;
use File::Temp qw/ tempdir /;
use Path::Tiny;
use Test::More;
use Test::Warnings;

use App::PerlWatcher::Watcher::FileTail;


my $end_var = AE::cv;

my $callback_handler = sub {
    my $status = shift;
    my $items = $status->items->();
    my $items_count = @$items;
    if($items_count == 3) {
        is $items->[0]->content, "3rd line";
        is $items->[1]->content, "2nd line";
        is $items->[2]->content, "1st line";
        $end_var->send(1);
    }
};

my $tmpdir = tempdir( CLEANUP => 1 );
my $sample = path("$tmpdir/sample.log");
my $content = <<CONTENT;
1st line
2nd line
3rd line
CONTENT
$sample->spew($content);

my $watcher = App::PerlWatcher::Watcher::FileTail->new(
    file            => "$sample",
    lines_number    => 5,
    engine_config   => {},
    callback        => $callback_handler,
    poll_callback   => sub { },
    reverse         => 1,
);

ok defined($watcher), "watcher was created";
like "$watcher", qr/FileTail/, "has overloaded toString";

$watcher->start;
ok $end_var->recv;

done_testing;
