
sub good_way(@map, $h, $l, $rule)
{
    my $hrand = (1..$h-2).rand.Int;
    my $ypath = 1;
    my $xpath = $hrand;
    my $drand;
    my $max = 2;
    my $xtemp = $xpath;
    if $rule == 1 {       
       $max = 1;
    };
    while ($ypath != $l - $max) {
	$drand = (1..4).rand.Int;
	given $drand {
	    when 1 {
		if $xpath != 1 {
		    $xpath-- ;
		    @map[$xpath][$ypath] = ' ' ;
		};
	    }
	    when 2 {
		$ypath++;
		@map[$xpath][$ypath] = ' ';
	    }
	    when 3 {
		if $xpath != $h - 2 {
		    $xpath++;
		    @map[$xpath][$ypath] = ' ';
		};
	    }
	    
	}
    }
    if $rule == 1 {
	@map[$xpath][$ypath] = 'X';
	@map[$xtemp][1] = 'P';
    };
}

sub create_map($h, $l)
{
    my @map = [ '@' xx $h ] xx $l;
    good_way(@map, $h, $l, 0);
    good_way(@map, $h, $l, 0);
    good_way(@map, $h, $l, 0);
    good_way(@map, $h, $l, 1);
    return @map;
}

sub aff_map(@map = [ '@' xx 10 ] xx 10)
{
    for @map -> @ligne {
	for @ligne -> $case {
	    print $case;
	}
	say "";
    }
}

sub get-posx (@map) {     
    my $i = 0;
    for @map -> @ligne {
	for @ligne -> $case {
	    if $case eq 'P' {
		return $i;
	    }
	}
	$i++;
    }
}

sub get-posy (@map) {     
    for @map -> @ligne {
	my $i = 0;
	for @ligne -> $case {
	    if $case eq 'P' {
		return $i;
	    }
	    $i++;
	}
    }
}

sub cmd (@map){
    loop {
	aff_map(@map);
    	my $cmd = prompt "Où voulez-vous aller ?\n";
        given $cmd {
	    my $posx = get-posx(@map);
	    my $posy = get-posy(@map);
    	      when 'exit' {
	      	   last;
	      }
	      when 'w' {
	      	  say "Vous allez en haut" ;
		    if (@map[$posx - 1][$posy] eq '@') {
			say "Vous etes mort";
			last;
		    }
		    elsif (@map[$posx - 1][$posy] eq 'X') {
			say "Vous avez gagnez !";
			last;
		    }
		    else {
			@map[$posx - 1][$posy] = 'P';
			@map[$posx][$posy] = ' ';
		    }
	      }
	      when 's' {
	      	   say "Vous allez en bas" ;
		   if (@map[$posx + 1][$posy] eq '@') {
			say "Vous etes mort";
			last;
		   }
		   elsif (@map[$posx + 1][$posy] eq 'X') {
		       say "Vous avez gagnez !";
		       last;
		   }
		    else {
			@map[$posx + 1][$posy] = 'P';
			@map[$posx][$posy] = ' ';
		    }
	      }
	      when 'a' {
	      	    say "Vous allez a gauche" ;
		    if (@map[$posx][$posy - 1] eq '@') {
			say "Vous etes mort";
			last;
		    }
		    elsif (@map[$posx][$posy - 1] eq 'X') {
			say "Vous avez gagnez !";
			last;
		    }
		    else {
			@map[$posx][$posy - 1] = 'P';
			@map[$posx][$posy] = ' ';
		    }
	      }
	      when 'd' {
	      	   say "Vous allez a droite" ;
		   if (@map[$posx][$posy + 1] eq '@') {
		       say "Vous etes mort";
		       last;
		   }
		   elsif (@map[$posx][$posy + 1] eq 'X') {
		       say "Vous avez gagnez !";
		       last;
		   }
		    else {
			@map[$posx][$posy + 1] = 'P';
			@map[$posx][$posy] = ' ';
		    }
	      }
	      default {
		  say "Commande non reconnu";
		  redo;
	      }
        }
    }
}

my @map = create_map(15, 15);
cmd(@map);
