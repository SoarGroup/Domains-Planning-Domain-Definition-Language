;; The Traveling Salesman problem, STRIPS version.
;; The predicate "connected" defines the graph; it doesn't have to
;; be made symmetric, since there're actions for going both "along"
;; and "against" the direction of an arc.

(define (domain tsp-strips)
  (:requirements :strips)
  (:predicates (in ?x) (visited ?x) (not-visited ?x)
	       (starting ?x) (complete) (not-complete)
	       (connected ?x ?y))

  (:action go-along
    :parameters (?x ?y)
    :precondition (and (in ?x) (not-visited ?y) (not-complete)
		       (connected ?x ?y))
    :effect (and (not (in ?x)) (in ?y) (visited ?y) (not (not-visited ?y))))

  (:action go-against
    :parameters (?x ?y)
    :precondition (and (in ?x) (not-visited ?y) (not-complete)
		       (connected ?y ?x))
    :effect (and (not (in ?x)) (in ?y) (visited ?y) (not (not-visited ?y))))

  ;; The "return" actions have to used to take the last step of the tour,
  ;; since this involves returning to a city allready visited (the starting
  ;; city).
  (:action return-along
    :parameters (?x ?y)
    :precondition (and (in ?x) (starting ?y) (not-complete)
		       (connected ?x ?y))
    :effect (and (not (in ?x)) (in ?y) (not (not-complete)) (complete)))

  (:action return-against
    :parameters (?x ?y)
    :precondition (and (in ?x) (not-visited ?y) (not-complete)
		       (connected ?y ?x))
    :effect (and (not (in ?x)) (in ?y) (not (not-complete)) (complete)))
 )
