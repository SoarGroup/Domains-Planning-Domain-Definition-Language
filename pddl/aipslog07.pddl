;; original name logistics.d
;; (:length (:parallel 14))
;; optimal
;;

(define (problem log007)
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
        package9

        airplane1
        airplane2

        pgh
        bos
        la
        ny
        sf

        pgh-truck
        bos-truck
        la-truck
        ny-truck
        sf-truck

        pgh-po
        bos-po
        la-po
        ny-po
        sf-po

        pgh-central
        bos-central
        la-central
        ny-central
        sf-central

        pgh-airport
        bos-airport
        la-airport
        ny-airport
        sf-airport
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
        (OBJ package9)

        (AIRPLANE airplane1)
        (AIRPLANE airplane2)

        (CITY pgh)
        (CITY bos)
        (CITY la)
        (CITY ny)
        (CITY sf)

        (TRUCK pgh-truck)
        (TRUCK bos-truck)
        (TRUCK la-truck)
        (TRUCK ny-truck)
        (TRUCK sf-truck)

        (LOCATION bos-po)
        (LOCATION la-po)
        (LOCATION pgh-po)
        (LOCATION ny-po)
        (LOCATION sf-po)

        (LOCATION bos-central)
        (LOCATION la-central)
        (LOCATION pgh-central)
        (LOCATION ny-central)
        (LOCATION sf-central)

        (AIRPORT bos-airport)
        (LOCATION bos-airport)
        (AIRPORT pgh-airport)
        (LOCATION pgh-airport)
        (AIRPORT la-airport)
        (LOCATION la-airport)
        (AIRPORT ny-airport)
        (LOCATION ny-airport)
        (AIRPORT sf-airport)
        (LOCATION sf-airport)

        (in-city pgh-po pgh)
        (in-city pgh-airport pgh)
        (in-city pgh-central pgh)

        (in-city bos-po bos)
        (in-city bos-airport bos)
        (in-city bos-central bos)

        (in-city la-po la)
        (in-city la-airport la)
        (in-city la-central la)

        (in-city ny-po ny)
        (in-city ny-airport ny)
        (in-city ny-central ny)

        (in-city sf-po sf)
        (in-city sf-airport sf)
        (in-city sf-central sf)

        (at package1 pgh-po)
        (at package2 pgh-central)
        (at package3 pgh-central)
        (at package4 ny-po)
        (at package5 bos-po)
        (at package6 bos-po)
        (at package7 ny-po)
        (at package8 sf-airport)
        (at package9 sf-central)

        (at airplane1 pgh-airport)
        (at airplane2 pgh-airport)

        (at bos-truck bos-po)
        (at pgh-truck pgh-airport)
        (at la-truck la-po)
        (at ny-truck ny-central)
        (at sf-truck sf-airport)
    )
    (:goal (and
       (at package1 bos-po)
       (at package2 ny-po)
       (at package3 la-central)
       (at package4 la-airport)
       (at package5 pgh-po)
       (at package6 ny-central)
       (at package7 pgh-po)
       (at package8 ny-central)
       (at package9 sf-po)
    ))
)
