(define (domain taxi)
  (:requirements :strips :equality :typing :conditional-effects)

  (:types  taxi location person fuel)


  (:predicates
    (taxistate ?taxi1 - taxi)
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
       :parameters ( ?taxi - taxi ?location - location ?person - person)
       :precondition (and 
            (taxistate ?taxi)
            (tlocation ?taxi ?location)
            (insidetaxi ?person ?taxi)
            (plocation ?person ?location)
       )
       :effect (and 
            (not (insidetaxi ?person ?taxi))
            (outsidetaxi ?person)
        )
    )
  (:action getin
       :parameters ( ?taxi - taxi ?location - location ?person - person)
       :precondition (and 
            (taxistate ?taxi)
            (tlocation ?taxi ?location)
            (outsidetaxi ?person)
            (plocation ?person ?location)
       )
       :effect (and 
            (not (outsidetaxi ?person))
            (insidetaxi ?person ?taxi)
        )
    )
  (:action move
       :parameters ( ?taxi - taxi ?locationa - location ?fuela - fuel ?locationb - location ?fuelb - fuel)
       :precondition (and 
            (taxistate ?taxi)
            (tlocation ?taxi ?locationa)
            (tfuel ?taxi ?fuela)
            (connects ?locationa ?locationb)
            (usefuel ?fuela ?fuelb)
       )
       :effect (and 
            (not (tlocation ?taxi ?locationa))
            (not (tfuel ?taxi ?fuela))
            (tlocation ?taxi ?locationb)
            (tfuel ?taxi ?fuelb)
            (forall (?person - person)
              (when (and
                (insidetaxi ?person ?taxi)
                (plocation ?person ?locationa)
                (connects ?locationa ?locationb)
               )
              (and
                (not (plocation ?person ?locationa))
                (plocation ?person ?locationb)
               )))
        )
    )
  (:action fillfuel
       :parameters ( ?taxi - taxi ?locationa - location ?fuela - fuel ?fuelb - fuel)
       :precondition (and 
            (taxistate ?taxi)
            (tlocation ?taxi ?locationa)
            (tfuel ?taxi ?fuela)
            (fillupfuel ?fuela ?fuelb)
       )
       :effect (and 
            (not (tfuel ?taxi ?fuela))
            (tfuel ?taxi ?fuelb)
        )
    )
  )
