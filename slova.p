#!/usr/bin/perl
use locale;

while (<>) {
  chomp;
  while ($_=~s/^\W*(\w+)\W*//) {
    $word=$1;
    if ($word) {
      print $word, "\n";
    }
  }
}
