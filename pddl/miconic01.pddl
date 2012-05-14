

(define (problem mixed-f5-p5-u0-v5-d0-a0-n0-A0-B0-N0-F0)
   (:domain miconic)
   (:objects p0 p1 p2 p3 p4 - passenger
             f0 f1 f2 f3 f4 - floor)


(:init
(above f0 f1)
(above f0 f2)
(above f0 f3)
(above f0 f4)

(above f1 f2)
(above f1 f3)
(above f1 f4)

(above f2 f3)
(above f2 f4)

(above f3 f4)



(origin p0 f4)
(destin p0 f1)

(origin p1 f3)
(destin p1 f1)

(origin p2 f3)
(destin p2 f0)

(origin p3 f3)
(destin p3 f2)

(origin p4 f1)
(destin p4 f0)






(lift-at f0)
)


(:goal (forall (?p - passenger) (served ?p)))
)
