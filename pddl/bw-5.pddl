(define (problem blocks_world5) 
  (:domain blocks_world)
  (:objects A B C D E)
  (:init 
   (on-table A) (clear A)
   (on-table B) (clear B)
   (on-table C) (clear C)
   (on-table D) (clear D)
   (on-table E) (clear E))
  (:goal (on A D)))

