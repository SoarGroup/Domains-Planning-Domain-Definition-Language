;   1 2 3 4 5
; 1 R .|T . G
; 2 . .|. . .
; 3 . . . . .
; 4 .|. .|. .
; 5 Y|. .|B .


(define (problem taxi_grid_mod1)
  (:domain taxi_grid_mod)
  (:objects 
   taxi1 - taxi
   x1 x2 x3 x4 x5 y1 y2 y3 y4 y5 - position
   joseph - person
   full threequarter half_full onequarter empty - fuel)

  (:init
   (inc x1 x2) (inc x2 x3) (inc x3 x4) (inc x4 x5)
   (inc y1 y2) (inc y2 y3) (inc y3 y4) (inc y4 y5)
   ;(edge x1) (edge x5) (edge y1) (edge y5)

   (usefuel full threequarter)
   (usefuel threequarter half_full)
   (usefuel half_full onequarter)
   (usefuel onequarter empty)
   (fillupfuel empty full)

   (eastwall x1 y4)
   (eastwall x1 y5)
   (eastwall x2 y1)
   (eastwall x2 y2)
   (eastwall x3 y4)
   (eastwall x3 y5)

   (tlocation taxi1 x3 y1)
   (tfuel taxi1 full)
   (plocation joseph x5 y1)
   (outsidetaxi joseph)
   (dest joseph x4 y5)
   )

  (:goal
   (and (plocation joseph x4 y5)
	(outsidetaxi joseph)))
  )
