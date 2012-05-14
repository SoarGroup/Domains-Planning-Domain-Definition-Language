; It looks like this:
;
;   0 1 2 3 4 5 6 7 8 9
;
;0  J . . . . . . . . .
;1  . W W W W W W W . .
;2  . . . . . . . . W .
;3  . W W W W W . . . W
;4  . . . . . . W . . .
;5  . . . . . . . W . .
;6  W W W W W W . . W .
;7  . . . . . . . . W .
;8  W W W W W W W W . .
;9  G . . . . . . . . .

(define (problem maze10)
  (:domain maze)
  (:objects x0 x1 x2 x3 x4 x5 x6 x7 x8 x9
            y0 y1 y2 y3 y4 y5 y6 y7 y8 y9 - position 
            joseph - agent)
  (:init
    (inc x0 x1) (inc x1 x2) (inc x2 x3) (inc x3 x4) (inc x4 x5) (inc x5 x6) (inc x6 x7) (inc x7 x8) (inc x8 x9)
    (inc y0 y1) (inc y1 y2) (inc y2 y3) (inc y3 y4) (inc y4 y5) (inc y5 y6) (inc y6 y7) (inc y7 y8) (inc y8 y9)

    (dec x9 x8) (dec x8 x7) (dec x7 x6) (dec x6 x5) (dec x5 x4) (dec x4 x3) (dec x3 x2) (dec x2 x1) (dec x1 x0)
    (dec y9 y8) (dec y8 y7) (dec y7 y6) (dec y6 y5) (dec y5 y4) (dec y4 y3) (dec y3 y2) (dec y2 y1) (dec y1 y0)

    (wall x1 y1) (wall x2 y1) (wall x3 y1) (wall x4 y1) (wall x5 y1) (wall x6 y1) (wall x7 y1)
    (wall x8 y2)
    (wall x1 y3) (wall x2 y3) (wall x3 y3) (wall x4 y3) (wall x5 y3) (wall x9 y3)
    (wall x6 y4)
    (wall x7 y5)
    (wall x0 y6) (wall x1 y6) (wall x2 y6) (wall x3 y6) (wall x4 y6) (wall x5 y6) (wall x8 y6)
    (wall x8 y7)
    (wall x0 y8) (wall x1 y8) (wall x2 y8) (wall x3 y8) (wall x4 y8) (wall x5 y8) (wall x6 y8) (wall x7 y8)

    (at joseph x0 y0))
  (:goal
    (at joseph x0 y9))
  )
