;; The D1S1 domain, STRIPS version (adapted from the SGP distribution).

(define (domain D1S1)
  (:requirements :strips)
  (:predicates
   (I0) (I1) (I2) (I3) (I4) (I5) (I6) (I7) (I8) (I9)
   (I10) (I11) (I12) (I13) (I14) (I15) (I16) (I17) (I18) (I19) (I20)
   (G1) (G2) (G3) (G4) (G5) (G6) (G7) (G8) (G9)
   (G10) (G11) (G12) (G13) (G14) (G15) (G16) (G17) (G18) (G19) (G20))

  (:action A20
	   :parameters ()
	   :precondition (I20) 
	   :effect (and (not (I19)) (G20)))

  (:action A19
	   :parameters ()
	   :precondition (I19) 
	   :effect (and (not (I18)) (G19)))

  (:action A18
	   :parameters ()
	   :precondition (I18)
	   :effect (and (not (I17)) (G18)))

  (:action A17
	   :parameters ()
	   :precondition (I17)
	   :effect (and (not (I16)) (G17)))

  (:action A16
	   :parameters () 
	   :precondition (I16) 
	   :effect (and (not (I15)) (G16)))

  (:action A15
	   :parameters () 
	   :precondition (I15) 
	   :effect (and (not (I14)) (G15)))

  (:action A14
	   :parameters () 
	   :precondition (I14) 
	   :effect (and (not (I13)) (G14)))

  (:action A13
	   :parameters () 
	   :precondition (I13) 
	   :effect (and (not (I12)) (G13)))

  (:action A12
	   :parameters () 
	   :precondition (I12) 
	   :effect (and (not (I11)) (G12)))

  (:action A11
	   :parameters () 
	   :precondition (I11) 
	   :effect (and (not (I10)) (G11)))

  (:action A10
	   :parameters () 
	   :precondition (I10) 
	   :effect (and (not (I9)) (G10)))

  (:action A9
	   :parameters () 
	   :precondition (I9) 
	   :effect (and (not (I8)) (G9)))

  (:action A8
	   :parameters () 
	   :precondition (I8) 
	   :effect (and (not (I7)) (G8)))

  (:action A7
	   :parameters () 
	   :precondition (I7) 
	   :effect (and (not (I6)) (G7)))

  (:action A6
	   :parameters () 
	   :precondition (I6) 
	   :effect (and (not (I5)) (G6)))

  (:action A5
	   :parameters () 
	   :precondition (I5) 
	   :effect (and (not (I4)) (G5)))

  (:action A4
	   :parameters () 
	   :precondition (I4) 
	   :effect (and (not (I3)) (G4)))

  (:action A3
	   :parameters () 
	   :precondition (I3) 
	   :effect (and (not (I2)) (G3)))

  (:action A2
	   :parameters () 
	   :precondition (I2) 
	   :effect (and (not (I1)) (G2)))

  (:action A1
	   :parameters () 
	   :precondition (I1) 
	   :effect (and (not (I0)) (G1)))
  )
