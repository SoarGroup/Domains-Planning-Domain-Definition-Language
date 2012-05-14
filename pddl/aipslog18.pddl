;; a logistics problem instance
;; name: log018
;; #packages: 8        #cities: 6  #planes: 2
;; #locs_per_city: 3   #trucks_per_city: 2
;; #goals: 8           seed: 112000697

(define (problem log018)
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
        plane1
        plane2
        truck1-1
        truck1-2
        loc1-1
        loc1-2
        loc1-3
        city1
        truck2-1
        truck2-2
        loc2-1
        loc2-2
        loc2-3
        city2
        truck3-1
        truck3-2
        loc3-1
        loc3-2
        loc3-3
        city3
        truck4-1
        truck4-2
        loc4-1
        loc4-2
        loc4-3
        city4
        truck5-1
        truck5-2
        loc5-1
        loc5-2
        loc5-3
        city5
        truck6-1
        truck6-2
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
        (AIRPLANE plane1)
        (AIRPLANE plane2)
        (TRUCK truck1-1)
        (TRUCK truck1-2)
        (LOCATION loc1-1)
        (LOCATION loc1-2)
        (LOCATION loc1-3)
        (CITY city1)
        (AIRPORT loc1-1)
        (TRUCK truck2-1)
        (TRUCK truck2-2)
        (LOCATION loc2-1)
        (LOCATION loc2-2)
        (LOCATION loc2-3)
        (CITY city2)
        (AIRPORT loc2-1)
        (TRUCK truck3-1)
        (TRUCK truck3-2)
        (LOCATION loc3-1)
        (LOCATION loc3-2)
        (LOCATION loc3-3)
        (CITY city3)
        (AIRPORT loc3-1)
        (TRUCK truck4-1)
        (TRUCK truck4-2)
        (LOCATION loc4-1)
        (LOCATION loc4-2)
        (LOCATION loc4-3)
        (CITY city4)
        (AIRPORT loc4-1)
        (TRUCK truck5-1)
        (TRUCK truck5-2)
        (LOCATION loc5-1)
        (LOCATION loc5-2)
        (LOCATION loc5-3)
        (CITY city5)
        (AIRPORT loc5-1)
        (TRUCK truck6-1)
        (TRUCK truck6-2)
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
        (at plane1 loc2-1)
        (at plane2 loc3-1)
        (at truck1-1 loc1-1)
        (at truck1-2 loc1-1)
        (at truck2-1 loc2-1)
        (at truck2-2 loc2-1)
        (at truck3-1 loc3-3)
        (at truck3-2 loc3-2)
        (at truck4-1 loc4-2)
        (at truck4-2 loc4-3)
        (at truck5-1 loc5-2)
        (at truck5-2 loc5-1)
        (at truck6-1 loc6-3)
        (at truck6-2 loc6-2)
        (at package1 loc2-3)
        (at package2 loc4-2)
        (at package3 loc5-3)
        (at package4 loc1-2)
        (at package5 loc5-1)
        (at package6 loc4-2)
        (at package7 loc2-1)
        (at package8 loc1-2)
    )
    (:goal (and
        (at package1 loc5-3)
        (at package2 loc4-3)
        (at package3 loc5-3)
        (at package4 loc4-1)
        (at package5 loc1-2)
        (at package6 loc1-3)
        (at package7 loc2-3)
        (at package8 loc2-3)
    ))
)
