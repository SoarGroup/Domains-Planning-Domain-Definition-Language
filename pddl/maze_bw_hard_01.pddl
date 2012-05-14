; The maze looks like this:
;
; J . W X
; . . W .
; . . W .
; . . . .

(define (problem maze_bw_hard_01)
  (:domain maze_blocks_world_hard)
  (:objects x1 x2 x3 x4 y1 y2 y3 y4 - position joseph - agent
            A B C D - block)
  (:init
    ;; maze init
    (wall x3 y1) (wall x3 y2) (wall x3 y3)
    (inc x1 x2) (inc x2 x3) (inc x3 x4)
    (inc y1 y2) (inc y2 y3) (inc y3 y4)
    (dec x4 x3) (dec x3 x2) (dec x2 x1)
    (dec y4 y3) (dec y3 y2) (dec y2 y1)
    (at joseph x1 y1)

    ;; blocks init
    (on-table A)
    (on D A)
    (above D A)
    (on C D)
    (above C D)
    (above C A)
    (on B C)
    (above B C)
    (above B D)
    (above B A)
    (clear B)
  )
  (:goal
    (and (at joseph x4 y1)
         (clear A)
         (on A B)
         (above A B)
         (above A C)
         (above A D)
         (on B C)
         (above B C)
         (above B D)
         (on C D)
         (above C D)
         (on-table D)
    )
  )
)
