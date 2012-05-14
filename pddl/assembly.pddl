;; Assembly domain in ADL (from the SGP distribution).

(define (domain assembly)
   (:requirements :adl)
   (:types assembly resource)  ;; individual parts are atomic assemblies
   (:predicates (available ?x - (either resource assembly))
		(complete ?a - assembly)
		(requires ?a - assembly ?r - resource)
		(committed ?r - resource ?a - assembly)
		(incorporated ?part ?whole - assembly)
		(part-of ?part ?whole - assembly)
		(to-be-removed ?part ?whole - assembly)
		(assemble-order ?part1 ?part2 ?whole - assembly)
		(transient-part ?part ?whole - assembly)
		;; after ?part1 is included, ?part2 must be removed
		;; for the ?whole to be complete:
		(remove-order ?part1 ?part2 ?whole - assembly))

   (:action commit
      :parameters (?res - resource ?as - assembly)
      :precondition (available ?res)
      :effect (and (not (available ?res))
		   (committed ?res ?as)))

   (:action release
      :parameters (?res - resource ?as - assembly)
      :precondition (committed ?res ?as)
      :effect (and (not (committed ?res ?as))
		   (available ?res)))

   (:action assemble
      :parameters (?part ?whole - assembly)
      :precondition (and (forall (?res - resource)
			    (imply (requires ?whole ?res)
				   (committed ?res ?whole)))
			 (or (part-of ?part ?whole)
			     (transient-part ?part ?whole))
			 (available ?part)
			 (forall (?prev - assembly)
			    (imply (assemble-order ?prev ?part ?whole)
				   (incorporated ?prev ?whole))))
      :effect (and (incorporated ?part ?whole)
		   (not (available ?part))
		   (when (and (not (exists (?p - assembly)
				      (and (part-of ?p ?whole)
	                                   (not (= ?p ?part))
					   (not (incorporated ?p ?whole)))))
			      (not (exists (?tp - assembly)
				      (and (transient-part ?tp ?whole)
					   (incorporated ?tp ?whole)))))
			 (and (complete ?whole)
			      (available ?whole)))))

   ;; you can remove the last part added, or a cleanup part at the
   ;; end.
   (:action remove
      :parameters (?part ?whole - assembly)
      :precondition (and (forall (?res - resource)
			    (imply (requires ?whole ?res)
				   (committed ?res ?whole)))
			 (incorporated ?part ?whole)
			 (or (and (transient-part ?part ?whole)
				  (forall (?prev1 - assembly)
				     (imply
				        (remove-order ?prev1 ?part ?whole)
					(incorporated ?prev1 ?whole))))
			     (and (part-of ?part ?whole)
				  (not (exists (?prev2 - assembly)
					  (and (assemble-order
						  ?prev2 ?part ?whole)
					       (incorporated
						  ?prev2 ?whole)))))))
      :effect (and (not (incorporated ?part ?whole))
		               (available ?part)
                   (when (and (not (exists (?p - assembly)
                                           (and (part-of ?p ?whole)
                                                (not (incorporated ?p ?whole))
                                           )
                                   )
                              )
                              (not (exists (?tp - assembly)
                                           (and (transient-part ?tp ?whole)
                                                (not (= ?tp ?part))
                                                (incorporated ?tp ?whole))
                                   )
                              )
                         )
                         (and (complete ?whole)
                              (available ?whole))
                   )
              ))
   )

