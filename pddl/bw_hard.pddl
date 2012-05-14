; Blocks world with both ontop and above relations
(define (domain blocks_world_hard)
  (:requirements :strips :adl)
  (:predicates (on-table ?x) (on ?x ?y) (clear ?x) (above ?x ?y))

  (:action MoveToTable
    :parameters (?omf)
    :precondition (and (clear ?omf) (not (on-table ?omf)))
    :effect (and (on-table ?omf) 
                 ; the block being moved is no longer on top of what it used to be
                 (forall (?right-below)
                     (when (on ?omf ?right-below) 
                           (and (not (on ?omf ?right-below))
                                (clear ?right-below))
                     )
                 )
                 ; everything that the block being moved was above, it no longer is
                 (forall (?lower) 
                         (when (above ?omf ?lower)
                               (not (above ?omf ?lower))
                         )
                 )
            )
  )

  (:action MoveToBlock
    :parameters (?omf ?dest)
    :precondition (and (clear ?omf) (clear ?dest))
    :effect (and (on ?omf ?dest) 
                 (above ?omf ?dest)
                 (not (clear ?dest)) 
                 ; the block is no longer on the table, if it was in the first place
                 (when (on-table ?omf)
                       (not (on-table ?omf)))
                 ; the block being moved is no longer on top of what it used to be
                 (forall (?right-below)
                     (when (on ?omf ?right-below) 
                           (and (not (on ?omf ?right-below))
                                (clear ?right-below))
                     )
                 )
                 ; everything that the block being moved was above, it no longer is
                 (forall (?lower) 
                         (when (above ?omf ?lower)
                               (not (above ?omf ?lower))
                         )
                 )
                 ; block being moved is now above all blocks below the destination
                 (forall (?new-lower) 
                         (when (above ?dest ?new-lower)
                               (above ?omf ?new-lower)
                         )
                 )
            )
  )
)
