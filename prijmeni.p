#!/usr/bin/perl
while (<>) {
  s/\n$//;
  $flag='';
  $privlast='';
  $zenske=$_;
  if (
      ($pom=$_)=~s/mcová$/mec/) {
    $print=1;
    $muzske=$pom;
  } elsif (
      ($pom=$_)=~s/ďková$/děk/) {
    $print=1;
    $muzske=$pom;
  } elsif (
      ($pom=$_)=~s/ťková$/těk/) {
    $print=1;
    $muzske=$pom;
  } elsif (
      ($pom=$_)=~s/ňková$/něk/) {
    $print=1;
    $muzske=$pom;
  } elsif (
      ($pom=$_)=~s/([bcčdfghjlmnprřsštvzž])ková$/${1}ek/) {
    $print=1;
    $muzske=$pom;
  } elsif (
      ($pom=$_)=~s/ová$//) {
    $print=1;
    $muzske=$pom;
  } elsif (
      ($pom=$_)=~s/á$/ý/) {
    $print=1;
    $muzske=$pom;
  } elsif (
      ($pom=$_)=~s/e$//) {
    $print=1;
    $muzske="${pom}e";
    $zenske="${pom}ová";
  } elsif (
      ($pom=$_)=~s/ně$//) {
    $print=1;
    $muzske="${pom}ně";
    $zenske="${pom}ňová";
  } elsif (
      ($pom=$_)=~s/tě$//) {
    $print=1;
    $muzske="${pom}tě";
    $zenske="${pom}tětová";
  } else {
    $print=1;
    $muzske=$_;
    $zenske='';
  }
  if ($print) {
    if ($muzske=~/[cčjřsšžďťň]$/) {
      $flag='UV';
    } elsif ($muzske=~/ý$/) {
      $flag='Y';
      $zenske='';
      $privlast='';
    } elsif ($muzske=~/ů$/) {
      $flag='';
      $zenske='';
      $privlast='';
    } elsif ($muzske=~/tě$/) {
      $flag='';
    } else {
      $flag='PV';
    }
    if ($zenske) {
      if (
          ($pom=$zenske)=~s/ová$/ův\/Y/) {
        $privlast=$pom;
      }
      $zenske.='/Y';
    } else {
      if (
          ($zenske=$muzske)=~s/něk$/ňková\/Y/) {
      } elsif (
          ($zenske=$muzske)=~s/ek$/ková\/Y/) {
      } elsif (
          ($zenske=$muzske)=~s/ec$/cová\/Y/) {
      } elsif (
          ($zenske=$muzske)=~s/o$/ová\/Y/) {
      } elsif (
          ($zenske=$muzske)=~s/a$/ová\/Y/) {
      } elsif (
          $muzske=~/ý$/) {
          $privlast='';
      } elsif (
          $muzske=~/ů$/) {
          $privlast='';
      } else {
          $zenske=$muzske . "ová/Y";
      }
    }
    if (!$privlast) {
      if (
          ($privlast=$muzske)=~s/ec$/cův\/Y/) {
      } elsif (
          ($privlast=$muzske)=~s/něk$/ňkův\/Y/) {
      } elsif (
          ($privlast=$muzske)=~s/ek$/kův\/Y/) {
      } elsif (
          ($privlast=$muzske)=~s/o$/ův\/Y/) {
      } elsif (
          ($privlast=$muzske)=~s/a$/ův\/Y/) {
      } elsif (
          $muzske=~/ý$/) {
          $zenske='';
          $privlast='';
      } elsif (
          $muzske=~/ů$/) {
          $zenske='';
          $privlast='';
      } else {
          $privlast=$muzske . "ův/Y";
      }
    }
    print "$muzske";
    print "/$flag" if $flag;
    print " $privlast" if $privlast;
    print " $zenske" if $zenske;
    print "\n";
  }
}
