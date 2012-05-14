(define (problem log_c) 
   (:domain logistics)
   (:objects o1 o2 o3 o4 o5 o6 o7     ;; objects
             tbos tpgh tla tny        ;; trucks
	     p1 p2                    ;; airplanes
             abos apgh ala any        ;; airports
	     lbos lpgh lla lny        ;; locations
             cpgh cbos cla cny)       ;; cities
   (:init (object o1) (object o2) (object o3) (object o4) (object o5)
	  (object o6) (object o7) (truck tbos) (truck tpgh) (truck tla)
	  (truck tny) (airplane p1) (airplane p2) (vehicle tbos)
	  (vehicle tpgh) (vehicle tla) (vehicle tny) (vehicle p1)
	  (vehicle p2)
	  (airport abos) (airport apgh) (airport ala) (airport any)
	  (location abos) (location apgh) (location ala) (location any)
	  (location lbos) (location lpgh) (location lla) (location lny)
	  (city cbos) (city cpgh) (city cla) (city cny)
	  (loc lpgh cpgh) (loc lbos cbos) (loc lla cla) (loc lny cny)
	  (loc apgh cpgh) (loc abos cbos) (loc ala cla) (loc any cny)
	  (at o1 lpgh) (at o2 lpgh) (at o3 lpgh) (at o4 lny) (at o5 lbos)
	  (at o6 lbos) (at o7 lny) (at p1 apgh) (at p2 apgh) (at tbos lbos)
 	  (at tpgh lpgh) (at tla lla) (at tny lny))
   (:goal (and (at o1 lbos) (at o2 lny) (at o3 lla) (at o4 ala)
	       (at o5 lpgh) (at o6 any) (at o7 lpgh)))
   )
