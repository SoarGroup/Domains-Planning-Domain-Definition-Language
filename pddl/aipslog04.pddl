;; original name logistics.a
;; extended version of logistics_facts7h
;; (:length (:parallel 11))
;; optimal
;; #actions 54 #states 10^11
;;
;; note: by going to a non-typed representation
;;       of the problems, the instances become (somewhat)
;;       harder to solve.
;;       (larger propositional representation)
;;

(define (problem log004)
    (:domain logistics-strips)
    (:objects
        package1
        package2
        package3
        package4
        package5
        package6
        package7
        package8

        airplane1
        airplane2

        pgh
        bos
        la

        pgh-truck
        bos-truck
        la-truck

        pgh-po
        bos-po
        la-po

        pgh-airport
        bos-airport
        la-airport
    )
    (:init
        (OBJ package1)
        (OBJ package2)
        (OBJ package3)
        (OBJ package4)
        (OBJ package5)
        (OBJ package6)
        (OBJ package7)
        (OBJ package8)

        (AIRPLANE airplane1)
        (AIRPLANE airplane2)

        (CITY pgh)
        (CITY bos)
        (CITY la)

        (TRUCK pgh-truck)
        (TRUCK bos-truck)
        (TRUCK la-truck)

        (LOCATION bos-po)
        (LOCATION la-po)
        (LOCATION pgh-po)

        (AIRPORT bos-airport)
        (LOCATION bos-airport)
        (AIRPORT pgh-airport)
        (LOCATION pgh-airport)
        (AIRPORT la-airport)
        (LOCATION la-airport)

        (in-city pgh-po pgh)
        (in-city pgh-airport pgh)

        (in-city bos-po bos)
        (in-city bos-airport bos)

        (in-city la-po la)
        (in-city la-airport la)

        (at package1 pgh-po)
        (at package2 pgh-po)
        (at package3 pgh-po)
        (at package4 pgh-po)
        (at package5 bos-po)
        (at package6 bos-po)
        (at package7 bos-po)
        (at package8 la-po)

        (at airplane1 pgh-airport)
        (at airplane2 pgh-airport)
       
        (at bos-truck bos-po)
        (at pgh-truck pgh-po)
        (at la-truck la-po)
    )
    (:goal (and
        (at package1 bos-po)
        (at package2 bos-airport)
        (at package3 la-po)
        (at package4 la-airport)
        (at package5 pgh-po)
        (at package6 pgh-airport)
        (at package7 pgh-po)
        (at package8 pgh-po)
    ))
)
