%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% parse chart for language %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sentence(VP) --> noun_phrase(Actor), verb_phrase(Actor,VP).

noun_phrase(NP) --> proper_noun(NP).

verb_phrase(Actor,VP) --> intrans_verb(Actor,VP).
verb_phrase(Actor,VP) --> trans_verb(Actor,Y,VP), noun_phrase(Y).

intrans_verb(Actor, hostname(Actor)) --> [hostname].
intrans_verb(Actor, domain(Actor)) --> [domain].
intrans_verb(Actor, wins(Actor)) --> [wins].
intrans_verb(Actor, fails(Actor)) --> [fails].

trans_verb(X,Y, belongs(X,Y)) --> [belongs].
trans_verb(X,Y, loves(X,Y)) --> [loves].

proper_noun(X) --> [X].
