(define (domain taxi_hard)
  (:requirements :strips :typing :conditional-effects)

  (:types  taxi location person fuel)


  (:predicates
    (tlocation ?taxi1 - taxi ?location1 - location)
    (insidetaxi ?person1 - person ?taxi1 - taxi)
    (plocation ?person1 - person ?location1 - location)
    (outsidetaxi ?person1 - person)
    (connects ?location1 - location ?location2 - location)
    (usefuel ?fuel1 - fuel ?fuel2 - fuel)
    (fillupfuel ?fuel1 - fuel ?fuel2 - fuel)
    (tfuel ?taxi1 - taxi ?fuel1 - fuel)
  )
  (:action getout
       :parameters ( ?omf - taxi ?location - location ?person - person)
       :precondition (and 
            (tlocation ?omf ?location)
            (insidetaxi ?person ?omf)
            (plocation ?person ?location)
       )
       :effect (and 
            (not (insidetaxi ?person ?omf))
            (outsidetaxi ?person)
        )
    )
  (:action getin
       :parameters ( ?omf - taxi ?location - location ?person - person)
       :precondition (and 
            (tlocation ?omf ?location)
            (outsidetaxi ?person)
            (plocation ?person ?location)
       )
       :effect (and 
            (not (outsidetaxi ?person))
            (insidetaxi ?person ?omf)
        )
    )
  (:action move
       :parameters ( ?omf - taxi ?dest - location )
       :precondition (and 
            ; taxi is in a location that is connected to the destination
            (exists (?currloc - location)
                    (and (tlocation ?omf ?currloc)
                         (connects ?currloc ?dest)))
            ; taxi still has fuel
            (exists (?currfuel ?nextfuel - fuel)
                    (and (tfuel ?omf ?currfuel)
                         (usefuel ?currfuel ?nextfuel)))
       )
       :effect (and 
            ; taxi no longer at old location
            (forall (?oldloc - location)
                    (when (and (tlocation ?omf ?oldloc)
                               (connects ?oldloc ?dest))
                          (and (not (tlocation ?omf ?oldloc))
                               (forall (?person - person)
                                       (when (insidetaxi ?person ?omf)
                                             (and (not (plocation ?person ?oldloc))
                                                  (plocation ?person ?dest))
                                       )
                               )
                          )
                    )
            )
            ; taxi has less fuel
            (forall (?oldfuel ?newfuel - fuel)
                    (when (and (tfuel ?omf ?oldfuel)
                               (usefuel ?oldfuel ?newfuel))
                          (and (not (tfuel ?omf ?oldfuel))
                               (tfuel ?omf ?newfuel))
                    )
            )
            (tlocation ?omf ?dest)
        )
    )
  (:action fillfuel
       :parameters ( ?omf - taxi ?fuela - fuel ?fuelb - fuel)
       :precondition (and 
            (tfuel ?omf ?fuela)
            (fillupfuel ?fuela ?fuelb)
       )
       :effect (and 
            (not (tfuel ?omf ?fuela))
            (tfuel ?omf ?fuelb)
        )
    )
  )
