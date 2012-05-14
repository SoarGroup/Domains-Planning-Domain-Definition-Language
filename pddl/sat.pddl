
(define (domain sat)
  (:requirements :strips)
  (:predicates (is_clear ?x) (is_set ?x) (is_neg ?x ?y) (sat_clause ?x ?y ?z))

  (:action set_var
    :parameters (?var ?neg)
    :precondition (and (is_neg ?var ?neg) (is_clear ?var) (is_clear ?neg))
    :effect (and (is_set ?var) (not (is_clear ?var)) (not (is_clear ?neg))))

  (:action make_sat_x
    :parameters (?x ?y ?z)
    :precondition (is_set ?x)
    :effect (sat_clause ?x ?y ?z))

  (:action make_sat_y
    :parameters (?x ?y ?z)
    :precondition (is_set ?y)
    :effect (sat_clause ?x ?y ?z))

  (:action make_sat_z
    :parameters (?x ?y ?z)
    :precondition (is_set ?z)
    :effect (sat_clause ?x ?y ?z))
  )
