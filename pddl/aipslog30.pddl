;; a logistics problem instance
;; name: log030
;; #packages: 9        #cities: 5  #planes: 2
;; #locs_per_city: 3   #trucks_per_city: 1
;; #goals: 9           seed: 85419287

(define (problem log030)
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
        plane1
        plane2
        truck1-1
        loc1-1
        loc1-2
        loc1-3
        city1
        truck2-1
        loc2-1
        loc2-2
        loc2-3
        city2
        truck3-1
        loc3-1
        loc3-2
        loc3-3
        city3
        truck4-1
        loc4-1
        loc4-2
        loc4-3
        city4
        truck5-1
        loc5-1
        loc5-2
        loc5-3
        city5
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
        (AIRPLANE plane1)
        (AIRPLANE plane2)
        (TRUCK truck1-1)
        (LOCATION loc1-1)
        (LOCATION loc1-2)
        (LOCATION loc1-3)
        (CITY city1)
        (AIRPORT loc1-1)
        (TRUCK truck2-1)
        (LOCATION loc2-1)
        (LOCATION loc2-2)
        (LOCATION loc2-3)
        (CITY city2)
        (AIRPORT loc2-1)
        (TRUCK truck3-1)
        (LOCATION loc3-1)
        (LOCATION loc3-2)
        (LOCATION loc3-3)
        (CITY city3)
        (AIRPORT loc3-1)
        (TRUCK truck4-1)
        (LOCATION loc4-1)
        (LOCATION loc4-2)
        (LOCATION loc4-3)
        (CITY city4)
        (AIRPORT loc4-1)
        (TRUCK truck5-1)
        (LOCATION loc5-1)
        (LOCATION loc5-2)
        (LOCATION loc5-3)
        (CITY city5)
        (AIRPORT loc5-1)
        (in-city loc1-1 city1)
        (in-city loc1-2 city1)
        (in-city loc1-3 city1)
        (in-city loc2-1 city2)
        (in-city loc2-2 city2)
        (in-city loc2-3 city2)
        (in-city loc3-1 city3)
        (in-city loc3-2 city3)
        (in-city loc3-3 city3)
        (in-city loc4-1 city4)
        (in-city loc4-2 city4)
        (in-city loc4-3 city4)
        (in-city loc5-1 city5)
        (in-city loc5-2 city5)
        (in-city loc5-3 city5)
        (at plane1 loc1-1)
        (at plane2 loc3-1)
        (at truck1-1 loc1-1)
        (at truck2-1 loc2-1)
        (at truck3-1 loc3-1)
        (at truck4-1 loc4-1)
        (at truck5-1 loc5-1)
        (at package1 loc4-2)
        (at package2 loc5-3)
        (at package3 loc5-1)
        (at package4 loc5-2)
        (at package5 loc5-2)
        (at package6 loc4-3)
        (at package7 loc3-3)
        (at package8 loc2-3)
        (at package9 loc3-1)
    )
    (:goal (and
        (at package1 loc5-2)
        (at package2 loc2-2)
        (at package3 loc1-3)
        (at package4 loc1-2)
        (at package5 loc5-2)
        (at package6 loc4-1)
        (at package7 loc5-2)
        (at package8 loc2-3)
        (at package9 loc3-1)
    ))
)
