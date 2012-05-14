;; a logistics problem instance
;; name: log029
;; #packages: 10        #cities: 6  #planes: 3
;; #locs_per_city: 3   #trucks_per_city: 1
;; #goals: 10           seed: 3967928

(define (problem log029)
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
        package10
        plane1
        plane2
        plane3
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
        truck6-1
        loc6-1
        loc6-2
        loc6-3
        city6
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
        (OBJ package10)
        (AIRPLANE plane1)
        (AIRPLANE plane2)
        (AIRPLANE plane3)
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
        (TRUCK truck6-1)
        (LOCATION loc6-1)
        (LOCATION loc6-2)
        (LOCATION loc6-3)
        (CITY city6)
        (AIRPORT loc6-1)
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
        (in-city loc6-1 city6)
        (in-city loc6-2 city6)
        (in-city loc6-3 city6)
        (at plane1 loc4-1)
        (at plane2 loc4-1)
        (at plane3 loc5-1)
        (at truck1-1 loc1-1)
        (at truck2-1 loc2-3)
        (at truck3-1 loc3-3)
        (at truck4-1 loc4-1)
        (at truck5-1 loc5-1)
        (at truck6-1 loc6-3)
        (at package1 loc3-3)
        (at package2 loc1-3)
        (at package3 loc6-1)
        (at package4 loc3-2)
        (at package5 loc6-1)
        (at package6 loc3-2)
        (at package7 loc6-1)
        (at package8 loc1-1)
        (at package9 loc4-1)
        (at package10 loc3-1)
    )
    (:goal (and
        (at package1 loc3-3)
        (at package2 loc1-3)
        (at package3 loc5-2)
        (at package4 loc1-1)
        (at package5 loc6-2)
        (at package6 loc4-3)
        (at package7 loc5-2)
        (at package8 loc6-1)
        (at package9 loc2-3)
        (at package10 loc3-3)
    ))
)
