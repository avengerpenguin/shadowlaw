%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% parse chart for language %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sentence(fact(Subj,Verb,Objs,Opts)) --> noun_phrase(Subj), verb_phrase(Verb,Objs,Opts).

noun_phrase(getByName(Subj)) --> proper_noun(Subj).

noun_phrase(getUser) --> [me].
proper_noun(ross) --> [ross].




verb_phrase(Verb,[],[]) --> intrans_verb(Verb).

intrans_verb(farts) --> [farts].