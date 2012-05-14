(define (domain maze_blocks_world_hard)
  (:requirements :strips :adl)
  (:types agent position block)
  (:predicates
    ; predicates for maze
    (inc ?a ?b - position)
    (dec ?a ?b - position)
    (at ?a - agent ?x ?y - position)
    (wall ?x ?y - position)

    ; predicates for blocks world
    (on-table ?x - block)
    (on ?x ?y - block)
    (clear ?x - block)
    (above ?x ?y - block)
    )
  
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;
  ;; Actions for maze
  ;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (:action 
    move-up
    :parameters (?omf - agent)
    :precondition ()
    :effect (forall (?x ?y ?yn - position)
                    (when 
                      (and (at ?omf ?x ?y)
                           (dec ?y ?yn)
                           (not (wall ?x ?yn)))
                      (and (not (at ?omf ?x ?y))
                           (at ?omf ?x ?yn))
                      )
                    )
    )

  (:action 
    move-down
    :parameters (?omf - agent)
    :precondition ()
    :effect (forall (?x ?y ?yn - position)
                    (when 
                      (and (at ?omf ?x ?y)
                           (inc ?y ?yn)
                           (not (wall ?x ?yn)))
                      (and (not (at ?omf ?x ?y))
                           (at ?omf ?x ?yn))
                      )
                    )
    )

  (:action 
    move-right
    :parameters (?omf - agent)
    :precondition ()
    :effect (forall (?x ?y ?xn - position)
                    (when 
                      (and (at ?omf ?x ?y)
                           (inc ?x ?xn)
                           (not (wall ?xn ?y)))
                      (and (not (at ?omf ?x ?y))
                           (at ?omf ?xn ?y))
                      )
                    )
    )

  (:action 
    move-left
    :parameters (?omf - agent)
    :precondition ()
    :effect (forall (?x ?y ?xn - position)
                    (when 
                      (and (at ?omf ?x ?y)
                           (dec ?x ?xn)
                           (not (wall ?xn ?y)))
                      (and (not (at ?omf ?x ?y))
                           (at ?omf ?xn ?y))
                      )
                    )
    )

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;
  ;; Actions for blocks world
  ;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (:action MoveToTable
    :parameters (?omf - block ?a - agent) ; adding the agent to confound cue creation
    :precondition (and (clear ?omf) (not (on-table ?omf)))
    :effect (and (on-table ?omf) 
                 ; the block being moved is no longer on top of what it used to be
                 (forall (?right-below - block)
                     (when (on ?omf ?right-below) 
                           (and (not (on ?omf ?right-below))
                                (clear ?right-below))
                     )
                 )
                 ; everything that the block being moved was above, it no longer is
                 (forall (?lower - block)
                         (when (above ?omf ?lower)
                               (not (above ?omf ?lower))
                         )
                 )
            )
  )

  (:action MoveToBlock
    :parameters (?omf ?dest - block ?a - agent)
    :precondition (and (clear ?omf) (clear ?dest))
    :effect (and (on ?omf ?dest) 
                 (above ?omf ?dest)
                 (not (clear ?dest)) 
                 ; the block is no longer on the table, if it was in the first place
                 (when (on-table ?omf)
                       (not (on-table ?omf)))
                 ; the block being moved is no longer on top of what it used to be
                 (forall (?right-below - block)
                     (when (on ?omf ?right-below) 
                           (and (not (on ?omf ?right-below))
                                (clear ?right-below))
                     )
                 )
                 ; everything that the block being moved was above, it no longer is
                 (forall (?lower - block) 
                         (when (above ?omf ?lower)
                               (not (above ?omf ?lower))
                         )
                 )
                 ; block being moved is now above all blocks below the destination
                 (forall (?new-lower - block) 
                         (when (above ?dest ?new-lower)
                               (above ?omf ?new-lower)
                         )
                 )
            )
  )
)
