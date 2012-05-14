;; original name logistics.easy
;; (:length (:parallel 9))
;; optimal
;;

(define (problem log001)
    (:domain logistics-strips)
    (:objects
        package1
        package2
        package3

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

        pgh-central
        bos-central
        la-central

        pgh-airport
        bos-airport
        la-airport
    )
    (:init
        (OBJ package1)
        (OBJ package2)
        (OBJ package3)

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

        (LOCATION bos-central)
        (LOCATION la-central)
        (LOCATION pgh-central)

        (AIRPORT bos-airport)
        (LOCATION bos-airport)
        (AIRPORT pgh-airport)
        (LOCATION pgh-airport)
        (AIRPORT la-airport)
        (LOCATION la-airport)

        (in-city pgh-po pgh)
        (in-city pgh-airport pgh)
        (in-city pgh-central pgh)

        (in-city bos-po bos)
        (in-city bos-airport bos)
        (in-city bos-central bos)

        (in-city la-po la)
        (in-city la-airport la)
        (in-city la-central la)

        (at package1 pgh-po)
        (at package2 pgh-po)
        (at package3 pgh-po)

        (at airplane1 pgh-airport)
        (at airplane2 pgh-airport)

        (at bos-truck bos-po)
        (at pgh-truck pgh-po)
        (at la-truck la-po)

    )
    (:goal (and
        (at package1 bos-po)
        (at package2 la-po)
        (at package3 bos-po)
    ))
)

