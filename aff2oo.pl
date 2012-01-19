#!/usr/bin/perl

#
# .aff -> Open Office afix file convertor; not tested!!!
# Using:
#      perl aff2oo.pl czech.aff
#

use locale;

$number='';
while (<>) {
  if (/^prefixes/) {
    $affixtype='PFX';
  } elsif (/^suffixes/) {
    $affixtype='SFX';
  } else {
    next if (!$affixtype);
    if (/^flag (\*?)(.):/) {
      if ($number ne '') {
        $out=shift(@OUT);
        print "$out $number\n";
        print @OUT;
        print "\n";
      }
      $flag=$2;
      $combined=($1 eq '')? 'N' : 'Y';
      @OUT=("$affixtype $flag $combined");
      $number=0;
    } else {
      s/\n$//;
      s/\s*\#.*$//;
      s/^\s*//;
#print "Line: `$_'\n";
      if (/^([^\>]*)>(.*)/) {
        $cond=$1;
        $rest=$2;
#print "\$cond: `$cond'\n";
#print "\$rest: `$rest'\n";
        $cond=~s/^\s*//;
        $cond=~s/\s*$//;
        $rest=~s/^\s*//;
        $rest=~s/\s*$//;
#print "\$cond: `$cond'\n";
#print "\$rest: `$rest'\n";
        if ($rest=~/-(.*),(.*)/) {
          $remove=$1;
          $add=$2;
        } else {
          $remove='0';
          $add=$rest;
        }
        $remove=~s/\s*$//;
        $add=~s/^\s*//;
        $cond=~s/ //g;
        $remove=lc($remove);
        $add=lc($add);
        $cond=lc($cond);
        push(@OUT, "$affixtype $flag $remove $add $cond\n");
        $number++;
      }
    }
  }
}
      if ($number ne '') {
        $out=shift(@OUT);
        print "$out $number\n";
        print @OUT;
        print "\n";
      }
