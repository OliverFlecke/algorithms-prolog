/**
* Program to solve Sudokus using Prolog.
* the sudoku/1 predicate takes a list of list (Rows)
* and find the valid solutions for the given problem.
* See 'samples/sudoku/' for examples.
*
* Use the read_problem/2 utility to read in a problem from a
* text file.
* Example:
* 	read_problem('samples/sudoku/1.txt', P), sudoku(P), pretty(P).
*
* pretty/1 will output the solution with each row on its own line.
*/

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
check_square([N11, N12, N13 | Tail1], [N21, N22, N23 | Tail2], [N31, N32, N33 | Tail3]) :-
	all_distinct([N11, N12, N13, N21, N22, N23, N31, N32, N33]),
	check_square(Tail1, Tail2, Tail3).

pretty(Solution) :-
	maplist(labeling([ff]), Solution),
	maplist(portray_clause, Solution).

read_problem(Filename, Problem) :-
	open(Filename, read, Str),
	read(Str, Problem),
	close(Str).
