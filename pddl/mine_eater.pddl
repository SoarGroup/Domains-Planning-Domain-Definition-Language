(define (domain mine_eater)
  (:types position agent food mine hp)
  (:predicates
   (inc ?a ?b - position)
   (at ?obj ?x ?y)
   (health ?a ?h))

  (:action
   move_up
   :parameters (?omf - agent)
   :precondition ()
   :effect (forall (?x ?y ?yn - position)
		   (when (and (at ?omf ?x ?y)
			      (inc ?yn ?y))
		     (and 
		      ; change the location of the agent
		      (not (at ?omf ?x ?y))
		      (at ?omf ?x ?yn)
		      ; food at the new position is "eaten"
		      (forall (?f - food)
			      (when (at ?f ?x ?y)
				(not (at ?f ?x ?y))))
		      ; a mine at the new position explodes and hurts the player
		      (forall (?m - mine)
			      (when (at ?m ?x ?y)
				(and (not (at ?m ?x ?y))
				     (forall (?h ?hn - hp)
					     (when (and (health ?omf ?h)
							(inc ?hn ?h))
					       (and (not (health ?omf ?h))
						    (health ?omf ?hn)))))))
		      )))
   )

  (:action
   move_down
   :parameters (?omf - agent)
   :precondition ()
   :effect (forall (?x ?y ?yn - position)
		   (when (and (at ?omf ?x ?y)
			      (inc ?y ?yn))
		     (and 
		      ; change the location of the agent
		      (not (at ?omf ?x ?y))
		      (at ?omf ?x ?yn)
		      ; food at the new position is "eaten"
		      (forall (?f - food)
			      (when (at ?f ?x ?y)
				(not (at ?f ?x ?y))))
		      ; a mine at the new position explodes and hurts the player
		      (forall (?m - mine)
			      (when (at ?m ?x ?y)
				(and (not (at ?m ?x ?y))
				     (forall (?h ?hn - hp)
					     (when (and (health ?omf ?h)
							(inc ?hn ?h))
					       (and (not (health ?omf ?h))
						    (health ?omf ?hn)))))))
		      )))
   )

 (:action
   move_left
   :parameters (?omf - agent)
   :precondition ()
   :effect (forall (?x ?y ?xn - position)
		   (when (and (at ?omf ?x ?y)
			      (inc ?xn ?x))
		     (and 
		      ; change the location of the agent
		      (not (at ?omf ?x ?y))
		      (at ?omf ?xn ?y)
		      ; food at the new position is "eaten"
		      (forall (?f - food)
			      (when (at ?f ?x ?y)
				(not (at ?f ?x ?y))))
		      ; a mine at the new position explodes and hurts the player
		      (forall (?m - mine)
			      (when (at ?m ?x ?y)
				(and (not (at ?m ?x ?y))
				     (forall (?h ?hn - hp)
					     (when (and (health ?omf ?h)
							(inc ?hn ?h))
					       (and (not (health ?omf ?h))
						    (health ?omf ?hn)))))))
		      )))
   )

 (:action
   move_right
   :parameters (?omf - agent)
   :precondition ()
   :effect (forall (?x ?y ?xn - position)
		   (when (and (at ?omf ?x ?y)
			      (inc ?x ?xn))
		     (and 
		      ; change the location of the agent
		      (not (at ?omf ?x ?y))
		      (at ?omf ?xn ?y)
		      ; food at the new position is "eaten"
		      (forall (?f - food)
			      (when (at ?f ?x ?y)
				(not (at ?f ?x ?y))))
		      ; a mine at the new position explodes and hurts the player
		      (forall (?m - mine)
			      (when (at ?m ?x ?y)
				(and (not (at ?m ?x ?y))
				     (forall (?h ?hn - hp)
					     (when (and (health ?omf ?h)
							(inc ?hn ?h))
					       (and (not (health ?omf ?h))
						    (health ?omf ?hn)))))))
		      )))
   )
)