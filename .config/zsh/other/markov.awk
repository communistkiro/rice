#!/bin/awk
BEGIN{
    if(!RS) { RS="[^[:alnum:]]+"; };
    if(!outlen) { outlen=100 };
    srand(systime())
    prevword = ""
}# form transition matrix
{
    nextwords[prevword]=nextwords[prevword]" "$0;
    prevword = $0;
    prevrt = RT # try to pick good initial words
}# choose an initial word
(rand() < 0.1) && !firstword && prevrt ~ /[!?.]|^/ { firstword=$0 }END {
    ORS=" "; # put spaces between words
    word = firstword
    for(i=outlen; i >= 0; --i) {
        print word;
        split(nextwords[word], potential_successors, " ");
        word = potential_successors[int(rand() * length(potential_successors))+1]
    }
    ORS="\n" # have a final newline
    print word
}