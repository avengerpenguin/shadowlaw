%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%
% split/3
% split(+OldString,+Pattern,-ListStrings)
%
% Examples: string:split("a b c"," ",ListStrings).
%  ListStrings = ["a","b","c"]
split(OldString,Pattern,ListStrings):-
	  split(OldString,Pattern,[],ListStrings).
% split(+OldString,+Pattern,+PartialStart,-ListStrings).
split([],_Pattern,[],[]):-
	  !.
split([],_Pattern,PartialStart,[PartialStart]):-
	  !.
split(OldString,Pattern,[],[RestStrings]):-
	  startsWith(OldString,Pattern,Rest),
	    !,
	      split(Rest,Pattern,[],RestStrings).
split(OldString,Pattern,PartialStart,[PartialStart|RestStrings]):-
	  startsWith(OldString,Pattern,Rest),
	    !,
	      split(Rest,Pattern,[],RestStrings).
split([H|T],Pattern,PartialStart,RestStrings):-
	  !,
	    append(PartialStart,[H],PartialStartTemp),
	      split(T,Pattern,PartialStartTemp,RestStrings).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%
% startsWith/3
% startsWith(OldString,Pattern,Rest)
%
% Examples: startsWith(" aaa"," ",Rest)
% Rest = "aaa"
startsWith(OldString,[],OldString):-
	  !.
startsWith([H|TOldString],[H|T],Rest):-
	  !,
	    startsWith(TOldString,T,Rest).


atomise([],[]).
atomise([String|T1],[Atom|T2]) :-
	atom_codes(Atom,String),
	atomise(T1,T2).
