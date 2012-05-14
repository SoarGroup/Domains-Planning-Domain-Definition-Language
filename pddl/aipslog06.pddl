;; original name logistics.c
;; (:length (:parallel 13))
;; optimal
;; #actions 63 #states 10^10
;;

(define (problem log006)
    (:domain logistics-strips)
    (:objects
        package1
        package2
        package3
        package4
        package5
        package6
        package7

        airplane1
        airplane2

        pgh
        bos
        la
        ny

        pgh-truck
        bos-truck
        la-truck
        ny-truck

        pgh-po
        bos-po
        la-po
        ny-po

        pgh-airport
        bos-airport
        la-airport
        ny-airport
    )
    (:init
        (OBJ package1)
        (OBJ package2)
        (OBJ package3)
        (OBJ package4)
        (OBJ package5)
        (OBJ package6)
        (OBJ package7)

        (AIRPLANE airplane1)
        (AIRPLANE airplane2)

        (CITY pgh)
        (CITY bos)
        (CITY la)
        (CITY ny)

        (TRUCK pgh-truck)
        (TRUCK bos-truck)
        (TRUCK la-truck)
        (TRUCK ny-truck)

        (LOCATION bos-po)
        (LOCATION la-po)
        (LOCATION pgh-po)
        (LOCATION ny-po)

        (AIRPORT bos-airport)
        (LOCATION bos-airport)
        (AIRPORT pgh-airport)
        (LOCATION pgh-airport)
        (AIRPORT la-airport)
        (LOCATION la-airport)
        (AIRPORT ny-airport)
        (LOCATION ny-airport)

        (in-city pgh-po pgh)
        (in-city pgh-airport pgh)

        (in-city bos-po bos)
        (in-city bos-airport bos)

        (in-city la-po la)
        (in-city la-airport la)

        (in-city ny-po ny)
        (in-city ny-airport ny)

        (at package1 pgh-po)
        (at package2 pgh-po)
        (at package3 pgh-po)
        (at package4 ny-po)
        (at package5 bos-po)
        (at package6 bos-po)
        (at package7 ny-po)

        (at airplane1 pgh-airport)
        (at airplane2 pgh-airport)

        (at bos-truck bos-po)
        (at pgh-truck pgh-po)
        (at la-truck la-po)
        (at ny-truck ny-po)

    )
    (:goal (and
        (at package1 bos-po)
        (at package2 ny-po)
        (at package3 la-po)
        (at package4 la-airport)
        (at package5 pgh-po)
        (at package6 ny-airport)
        (at package7 pgh-po)
    ))
)
