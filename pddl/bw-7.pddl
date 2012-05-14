(define (problem blocks_world7)
  (:domain blocks_world)
  (:objects A B C D E F G)
  (:init 
   (on-table A) (clear A)
   (on-table B) (clear B)
   (on-table C) (clear C)
   (on-table D) (clear D)
   (on-table E) (clear E)
   (on-table F) (clear F)
   (on-table G) (clear G))
  (:goal (on A D)))

