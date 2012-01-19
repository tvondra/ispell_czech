#!/usr/bin/perl
while (<>) {
  s/\n$//;
  s/\|//g;
  while (s/^[-\s]*([^- ]+)[-\s]*//) {
    $word=$1;
    if ($word=~/^([^{]*){([^{}]+)}(.*)$/) {
      $start=$1;
      $list=$2;
      $end=$3;
      foreach $elem (split(/,/, $list)) {
        print "$start$elem$end\n";
      }
    } else {
      $word=~s/[{}\.]//g;
      print "$word\n";
    }
  }
}
