; blocks world where you can try to move any block, not just the ones
; without anything on top. If you try to move a block with other
; blocks on top, the ones on top fall and break.

(define (domain bw_break)
  (:requirements :strips :adl)
  (:predicates 
   (on-table ?x) 
   (on ?x ?y) 
   (clear ?x) 
   (above ?x ?y)
   (broken ?x))

  (:action MoveToTable
    :parameters (?omf)
    :precondition (and (not (on-table ?omf))
		       (not (broken ?omf)))
    :effect (and (on-table ?omf)
		 ; every block above the block is now broken
		 (forall (?above-block)
			 (when (above ?above-block ?omf)
			   (and (forall (?below)
					(and (when (above ?above-block ?below) (not (above ?above-block ?below)))
					     (when (on ?above-block ?below) (not (on ?above-block ?below)))))
				(when (clear ?above-block) (not (clear ?above-block)))
				(broken ?above-block))))
		 (when (not (clear ?omf)) (clear ?omf)) ; everything above fell, so this block is clear now

                 ; the block being moved is no longer on top of what it used to be
                 (forall (?right-below)
			 (when (on ?omf ?right-below)
                           (and (not (on ?omf ?right-below))
                                (clear ?right-below))
			   )
			 )
                 ; everything that the block being moved was above, it no longer is
                 (forall (?lower) 
                         (when (above ?omf ?lower) (not (above ?omf ?lower)))
			 )
            )
  )

  (:action MoveToBlock
    :parameters (?omf ?dest)
    :precondition (and (clear ?dest)
		       (not (above ?dest ?omf))
		       (not (broken ?omf))
		       (not (broken ?dest)))
    :effect (and 
	     ; every block above the block is now broken
	     (forall (?above-block)
		     (when (above ?above-block ?omf)
		       (and (forall (?below)
				    (and (when (above ?above-block ?below) (not (above ?above-block ?below)))
					 (when (on ?above-block ?below) (not (on ?above-block ?below)))))
			    (when (clear ?above-block) (not (clear ?above-block)))
			    (broken ?above-block))))
	     (when (not (clear ?omf)) (clear ?omf)) ; everything above fell, so this block is clear now

	     (on ?omf ?dest) 
	     (above ?omf ?dest)
	     (not (clear ?dest)) 
	     ; the block is no longer on the table, if it was in the first place
	     (when (on-table ?omf) (not (on-table ?omf)))
	     ; the block being moved is no longer on top of what it used to be
	     (forall (?right-below)
                     (when (on ?omf ?right-below) 
		       (and (not (on ?omf ?right-below))
			    (clear ?right-below))
		       )
		     )
             ; the block being moved is no longer above anything it was above before
	     (forall (?lower) 
		     (when (above ?omf ?lower) (not (above ?omf ?lower)))
		     )
             ; block being moved is now above all blocks below the destination
	     (forall (?new-lower) 
		     (when (above ?dest ?new-lower) (above ?omf ?new-lower))
		     )
	     )
  )
)
