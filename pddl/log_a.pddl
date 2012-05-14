(define (problem log_a) 
   (:domain logistics)
   (:objects o1 o2 o3 o4 o5 o6 o7 o8  ;; objects
             tbos tpgh tla            ;; trucks
	     p1 p2                    ;; airplanes
             abos apgh ala            ;; airports
	     lbos lpgh lla            ;; locations
             cpgh cbos cla)           ;; cities
   (:init (object o1) (object o2) (object o3) (object o4)
	  (object o5) (object o6) (object o7) (object o8)
	  (truck tbos) (truck tpgh) (truck tla) (airplane p1)
	  (airplane p2) (vehicle tbos) (vehicle tpgh) (vehicle tla)
	  (vehicle p1) (vehicle p2)
	  (airport abos) (airport apgh) (airport ala) (location abos)
	  (location apgh) (location ala) (location lbos) (location lpgh)
	  (location lla) (city cbos) (city cpgh) (city cla)
	  (loc lpgh cpgh) (loc lbos cbos) (loc lla cla) (loc apgh cpgh)
	  (loc abos cbos) (loc ala cla)
	  (at o1 lpgh) (at o2 lpgh) (at o3 lpgh) (at o4 lpgh) (at o5 lbos)
          (at o6 lbos) (at o7 lbos) (at o8 lla ) (at p1 apgh) (at p2 apgh)
          (at tbos lbos) (at tpgh lpgh) (at tla lla))
   (:goal (and (at o1 lbos) (at o2 abos) (at o3 lla) (at o4 ala)
	       (at o5 lpgh) (at o6 apgh) (at o7 lpgh) (at o8 lpgh)))
   )
