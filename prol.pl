proj :-
    initial(I),
    writeln("M C ====> M C"),
    bfs([[I]], Side),
    maplist(writeln, Side),nl.

% Writing rules for number of missionaries and cannibals. Not more than 2 can travel at a time

safe_state(M, C) :-

% Actual rules    
    M = 2, C = 0 ;
    M = 1, C = 0 ;
    M = 1, C = 1 ;
    M = 0, C = 2 ;
    M = 0, C = 1 .

% Reversing the order of rules
%    M = 0, C = 2 ;
%    M = 0, C = 1 ;
%    M = 2, C = 0 ;
%    M = 1, C = 1 ;   
%    M = 1, C = 0 .

% breath-first search algorithm
bfs(Sides, Side) :-
    bfs1(Sides, Extra),
    (   member(Right, Extra),
        Right = [H|_],
        final(H),
        reverse(Right, Side)
    ;   bfs(Extra, Side)).

bfs1(Sides, Extra) :-
    findall([Q,H|R], (   member([H|R], Sides), move(H, Q), \+ member(Q, R)), Extra), Extra \= [].

%initializing starting condition
initial((3,3, ====> , 0,0)).

%initializing goal condition
final((0,0, <==== , 3,3)).

% values of F1 and F2 will be changed according to its direction of moving
direction(====>, -1, +1, <====).
direction(<====, +1, -1, ====>).

% apply a *valid* move
move((M1i,C1i, Bi, M2i,C2i), (M1j, C1j, Bj, M2j, C2j)) :-
    direction(Bi, F1, F2, Bj),
    safe_state(MM, CM),
    M1j is M1i + MM * F1, M1j >= 0,
    C1j is C1i + CM * F1, C1j >= 0,
    ( M1j >= C1j ; M1j == 0 ),
    M2j is M2i + MM * F2, M2j >= 0,
    C2j is C2i + CM * F2, C2j >= 0,
    ( M2j >= C2j ; M2j == 0 ).