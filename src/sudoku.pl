:- use_module(library(clpfd)).
:- use_module(library(lists)).

sudoku(Rows) :-
	length(Rows, 9),
	maplist(same_length(Rows), Rows),
	append(Rows, Ns),
	Ns ins 1..9, % Check all numbers are in the domain 1-9
	maplist(all_distinct, Rows),
	transpose(Rows, Cols),
	maplist(all_distinct, Cols),
	Rows = [A, B, C, D, E, F, G, H, I],
	check_square(A, B, C),
	check_square(D, E, F),
	check_square(G, H, I).

check_square([], [], []).
check_square([N1, N2, N3 | Tail1], [N4, N5, N6 | Tail2], [N7, N8, N9 | Tail3]) :-
	all_distinct([N1, N2, N3, N4, N5, N6, N7, N8, N9]),
	check_square(Tail1, Tail2, Tail3).

pretty(Solution) :-
	maplist(labeling([ff]), Solution),
	maplist(portray_clause, Solution).
