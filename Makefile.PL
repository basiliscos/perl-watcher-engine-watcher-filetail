
use strict;
use warnings;

use 5.012;

use ExtUtils::MakeMaker 6.72;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Inotify-based file tail watcher",
  "AUTHOR" => "Ivan Baidakou <dmol\@gmx.com>",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.72"
  },
  "DISTNAME" => "App-PerlWatcher-Watcher-FileTail",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "App::PerlWatcher::Watcher::FileTail",
  "PREREQ_PM" => {
    "AnyEvent" => "7.04",
    "App::PerlWatcher::Engine" => "0.19",
    "Devel::Comments" => "v1.1.4",
    "File::ReadBackwards" => "1.05",
    "Linux::Inotify2" => "1.22",
    "List::MoreUtils" => "0.33",
    "Moo" => "1.003000",
    "Path::Class" => "0.32",
    "aliased" => "0.31"
  },
  "TEST_REQUIRES" => {
    "Path::Tiny" => "0.051",
    "Test::More" => "0.98",
    "Test::Warnings" => "0.013"
  },
  "VERSION" => "0.18",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "AnyEvent" => "7.04",
  "App::PerlWatcher::Engine" => "0.19",
  "Devel::Comments" => "v1.1.4",
  "File::ReadBackwards" => "1.05",
  "Linux::Inotify2" => "1.22",
  "List::MoreUtils" => "0.33",
  "Moo" => "1.003000",
  "Path::Class" => "0.32",
  "Path::Tiny" => "0.051",
  "Test::More" => "0.98",
  "Test::Warnings" => "0.013",
  "aliased" => "0.31"
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



