
;; The "Springer Game" is a chess puzzle (an implementation of the game
;; came along with the -99 Springer Verlag CD-ROM catalogue).
;; The objective is to step exactly once on each square of a chess board,
;; using the moves of a knight (?) ("springer", in german, I guess). The
;; choice of initial position is free (though it might as well be fixed,
;; since there's (supposedly, I haven't checked) exactly one solution for
;; each initial position).

;; The predicate "at" encodes the piece's current position, while "clear"
;; and "mark" keep track of visited squares. The "inc" and "dec" predicates
;; encode addition and subtraction.

;; There are four problem instance files:
;;  - springer1.pddl is the vanilla version.
;;  - springer1x.pddl uses separate objects for x and y coordinates, since
;;    some planners seem to require different objects for each parameter of
;;    an operator (which seems like a silly thing).
;;  - springer2.pddl has a fixed initial position (upper left corner).
;;  - springer2x.pddl is the same but using x/y objects.

;; This seems to be a very hard problem; I've not found any planner that
;; can solve it yet.

(define (domain springer_game)
  (:requirements :strips)
  (:predicates (ready) (at ?x ?y) (clear ?x ?y) (mark ?x ?y)
	       (inc ?p ?pp) (dec ?p ?pp))

  (:action start
    :parameters (?px ?py)
    :precondition (ready)
    :effect (and (not (ready)) (at ?px ?py) (not (clear ?px ?py))
		 (mark ?px ?py)))

  (:action RRD ; right-right-down
    :parameters (?px ?py ?fx ?fy ?ix)
    :precondition (and (at ?px ?py) (clear ?fx ?fy)
		       (inc ?px ?ix) (inc ?ix ?fx) (inc ?py ?fy))
    :effect (and (not (at ?px ?py)) (not (clear ?fx ?fy))
		 (at ?fx ?fy) (mark ?fx ?fy)))

  (:action RRU ; right-right-up
    :parameters (?px ?py ?fx ?fy ?ix)
    :precondition (and (at ?px ?py) (clear ?fx ?fy)
		       (inc ?px ?ix) (inc ?ix ?fx) (dec ?py ?fy))
    :effect (and (not (at ?px ?py)) (not (clear ?fx ?fy))
		 (at ?fx ?fy) (mark ?fx ?fy)))

  (:action LLD ; left-left-down
    :parameters (?px ?py ?fx ?fy ?ix)
    :precondition (and (at ?px ?py) (clear ?fx ?fy)
		       (dec ?px ?ix) (dec ?ix ?fx) (inc ?py ?fy))
    :effect (and (not (at ?px ?py)) (not (clear ?fx ?fy))
		 (at ?fx ?fy) (mark ?fx ?fy)))

  (:action LLU ; left-left-up
    :parameters (?px ?py ?fx ?fy ?ix)
    :precondition (and (at ?px ?py) (clear ?fx ?fy)
		       (dec ?px ?ix) (dec ?ix ?fx) (dec ?py ?fy))
    :effect (and (not (at ?px ?py)) (not (clear ?fx ?fy))
		 (at ?fx ?fy) (mark ?fx ?fy)))

  (:action RDD ; right-down-down
    :parameters (?px ?py ?fx ?fy ?iy)
    :precondition (and (at ?px ?py) (clear ?fx ?fy)
		       (inc ?px ?fx) (inc ?py ?iy) (inc ?iy ?fy))
    :effect (and (not (at ?px ?py)) (not (clear ?fx ?fy))
		 (at ?fx ?fy) (mark ?fx ?fy)))

  (:action RUU ; right-up-up
    :parameters (?px ?py ?fx ?fy ?iy)
    :precondition (and (at ?px ?py) (clear ?fx ?fy)
		       (inc ?px ?fx) (dec ?py ?iy) (dec ?iy ?fy))
    :effect (and (not (at ?px ?py)) (not (clear ?fx ?fy))
		 (at ?fx ?fy) (mark ?fx ?fy)))

  (:action LDD ; left-down-down
    :parameters (?px ?py ?fx ?fy ?iy)
    :precondition (and (at ?px ?py) (clear ?fx ?fy)
		       (dec ?px ?fx) (inc ?py ?iy) (inc ?iy ?fy))
    :effect (and (not (at ?px ?py)) (not (clear ?fx ?fy))
		 (at ?fx ?fy) (mark ?fx ?fy)))

  (:action LUU ; left-up-up
    :parameters (?px ?py ?fx ?fy ?iy)
    :precondition (and (at ?px ?py) (clear ?fx ?fy)
		       (dec ?px ?fx) (dec ?py ?iy) (dec ?iy ?fy))
    :effect (and (not (at ?px ?py)) (not (clear ?fx ?fy))
		 (at ?fx ?fy) (mark ?fx ?fy)))
  )
