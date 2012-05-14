
(define (domain blocks_world)
  (:requirements :strips)
  (:predicates (on-table ?x) (on ?x ?y) (clear ?x))

  (:action MoveToTable
    :parameters (?omf ?lower)
    :precondition (and (clear ?omf) (on ?omf ?lower))
    :effect (and (clear ?lower) (on-table ?omf) (not (on ?omf ?lower))))

  (:action MoveToBlock1
    :parameters (?omf ?lower ?dest)
    :precondition (and (clear ?omf) (clear ?dest) (on ?omf ?lower))
    :effect (and (clear ?lower) (on ?omf ?dest) (not (clear ?dest)) (not (on ?omf ?lower))))

  (:action MoveToBlock2
    :parameters (?omf ?dest)
    :precondition (and (clear ?omf) (clear ?dest) (on-table ?omf))
    :effect (and (on ?omf ?dest) (not (clear ?dest)) (not (on-table ?omf))))
  )
