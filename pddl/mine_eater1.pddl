; It looks like this:
;
; m f m
; m e m
; f m f

(define (problem mine_eater1)
  (:domain mine_eater)
  (:objects x1 x2 x3 y1 y2 y3 - position
	    f1 f2 f3 - food
	    m1 m2 m3 m4 m5 - mine
	    dead h1 h2 - hp
	    eater - agent)
  (:init
   ; number ordering
   (inc x1 x2) (inc x2 x3)
   (inc y1 y2) (inc y2 y3)
   (inc dead h1) (inc h1 h2)
   
   ; positions
   (at eater x2 y2)
   (at f1 x2 y1)
   (at f2 x1 y3)
   (at f3 x3 y3)
   (at m1 x1 y1)
   (at m2 x3 y1)
   (at m3 x1 y2)
   (at m4 x3 y2)
   (at m5 x2 y3)

   ; health
   (health eater h2))

  (:goal
   (health eater dead)) ; this doesn't actually mean anything
)