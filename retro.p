#!/usr/bin/perl
while (<>) {
  s/\n$//;
  if (m#^([^/]+)(/.*)?$#) {
    $vystup=reverse($1);
    print $vystup, $2, "\n";
  } else {
    die "Cannot split: $_\n";
  }
}

