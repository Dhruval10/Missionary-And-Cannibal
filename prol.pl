proj :-
    initial(I),
    writeln("Missionary Cannible"),
    bfs([[I]], Side),
    maplist(writeln, Side),nl.

% valid placements on boat
safe_state(M, C) :-
    M = 0, C = 2 ;
    M = 0, C = 1 ;
    M = 2, C = 0 ;
    M = 1, C = 1 ;
    M = 1, C = 1 .

bfs(Sides, Side) :-
    bfs1(Sides, Extra),
    (   member(Right, Extra),
        Right = [H|_],
        final(H),
        reverse(Right, Side)
    ;   bfs(Extra, Side)).

bfs1(Sides, Extra) :-
    findall([Q,H|R], (   member([H|R], Sides), move(H, Q), \+ member(Q, R)), Extra), Extra \= [].

initial((3,3, ====> , 0,0)).
final((0,0, <==== , 3,3)).

direction(====>, -1, +1, <====).
direction(<====, +1, -1, ====>).\

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

#-----------------------------------------------------------------------------------------------------

# bfs_new(Sides, Side) :-
#     bfs1_new(Sides, Extra),
#     (   member(Right, Extra),
#         Right = [H|_],
#         final(H),
#         reverse(Right, Side)
#     ;   bfs_new(Extra, Side)
#     ).

# bfs1_new(Sides, Extra) :-
#     findall([Q,H|R], (   member([H|R], Sides), move(H, Q), \+ member(Q, R)), Extra), Extra \= [].

# initial((3,3, ====> , 0,0)).
# final((0,0, <==== , 3,3)).

# direction(====>, -1, +1, <====).
# direction(<====, +1, -1, ====>).

# % apply a *valid* move
# move((M1j, C1j, Bj, M2j, C2j),(M1i,C1i, Bi, M2i,C2i),) :-
#     direction(Bi, F1, F2, Bj),
#     safe_state(MM, CM),
#     M1j is M1i + MM * F1, M1j >= 0,
#     C1j is C1i + CM * F1, C1j >= 0,
#     ( M1j >= C1j ; M1j == 0 ),
#     M2j is M2i + MM * F2, M2j >= 0,
#     C2j is C2i + CM * F2, C2j >= 0,
#     ( M2j >= C2j ; M2j == 0 ).