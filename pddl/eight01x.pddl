
;; Eight puzzle problems:
;; Hard1 and Hard2 are the two "hardest" instances of the puzzle,
;; i.e. having longest solutions (31 steps, see a paper by Reinefeld,
;; IJCAI -95 or -97).

;; This version uses different sets of objects for x and y coordinates.

(define (problem hard1)
  (:domain strips-sliding-tile)
  (:objects t1 t2 t3 t4 t5 t6 t7 t8 x1 x2 x3 y1 y2 y3)
  (:init
   (tile t1) (tile t2) (tile t3) (tile t4) (tile t5) (tile t6)
   (tile t7) (tile t8)
   (position x1) (position x2) (position x3)
   (position y1) (position y2) (position y3)
   (inc x1 x2) (inc x2 x3) (dec x3 x2) (dec x2 x1)
   (inc y1 y2) (inc y2 y3) (dec y3 y2) (dec y2 y1)
   (blank x1 y1) (at t1 x2 y1) (at t2 x3 y1) (at t3 x1 y2)
   (at t4 x2 y2) (at t5 x3 y2) (at t6 x1 y3) (at t7 x2 y3)
   (at t8 x3 y3))
  (:goal
   (and (at t8 x1 y1) (at t7 x2 y1) (at t6 x3 y1)
	(at t4 x2 y2) (at t1 x3 y2)
	(at t2 x1 y3) (at t5 x2 y3) (at t3 x3 y3)))
  )
