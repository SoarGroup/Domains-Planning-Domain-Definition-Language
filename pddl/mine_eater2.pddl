; It looks like this:
;   1 2 3
; 1 m e m 
; 2 m   m
; 3 m   m
; 4 m   m
; 5 f   f 

(define (problem mine_eater2)
  (:domain mine_eater)
  (:objects x1 x2 x3 y1 y2 y3 y4 y5 - position
	    f1 f2 - food
	    m0 m1 m2 m3 m4 m5 m6 m7 - mine
	    dead h1 h2 h3 h4 - hp
	    eater - agent)
  (:init
   ; number ordering
   (inc x1 x2) (inc x2 x3)
   (inc y1 y2) (inc y2 y3) (inc y3 y4) (inc y4 y5)
   (inc dead h1) (inc h1 h2) (inc h2 h3) (inc h3 h4)
   
   ; positions
   (at eater x2 y1)
   (at m0 x1 y1)
   (at m1 x1 y2)
   (at m2 x1 y3)
   (at m3 x1 y4)
   (at m4 x3 y1)
   (at m5 x3 y2)
   (at m6 x3 y3)
   (at m7 x3 y4)
   (at f1 x1 y5)
   (at f2 x3 y5)

   ; health
   (health eater h4))

  (:goal
   (health eater dead)) ; this doesn't actually mean anything
)