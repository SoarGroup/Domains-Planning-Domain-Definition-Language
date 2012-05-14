;; original name rocket_ext.b
;; (:length (:parallel 7))
;; optimal
;;

(define (problem log003)
  (:domain logistics-strips)
  (:objects mxf
	    avrim
	    alex
	    jason	
	    pencil
	    paper
	    april
	    michelle
	    betty
	    lisa
	    airplane1 
	    airplane2
	    lon-airport  
	    par-airport 
	    jfk-airport 
	    bos-airport
	    lon 
	    par 
	    jfk 
	    bos)
  (:init (OBJ mxf)
	 (OBJ avrim)
	 (OBJ alex)
	 (OBJ jason)
	 (OBJ pencil)
	 (OBJ paper)
	 (OBJ april)
	 (OBJ michelle)
	 (OBJ betty)
	 (OBJ lisa)
	 (AIRPLANE airplane1)
	 (AIRPLANE airplane2)
	 (LOCATION lon-airport  )
	 (AIRPORT lon-airport  )
	 (LOCATION par-airport )
	 (AIRPORT par-airport )
	 (LOCATION jfk-airport )
	 (AIRPORT jfk-airport )
	 (LOCATION bos-airport)
	 (AIRPORT bos-airport)
	 (CITY lon)
	 (CITY par)
	 (CITY jfk)
	 (CITY bos)
	 (in-city lon-airport lon)
	 (in-city bos-airport bos)
	 (in-city jfk-airport jfk)
	 (in-city par-airport par)
	 (at airplane1 jfk-airport)
	 (at airplane2 par-airport)
	 (at mxf jfk-airport)
	 (at avrim par-airport)
	 (at alex bos-airport)
	 (at jason jfk-airport)
	 (at pencil par-airport)
	 (at paper lon-airport)
	 (at michelle bos-airport)
	 (at april par-airport)
	 (at betty lon-airport)
	 (at lisa lon-airport)
	 )
  (:goal (and 
	  (at mxf bos-airport)
	  (at avrim jfk-airport)
	  (at pencil bos-airport)
	  (at alex jfk-airport)
	  (at april bos-airport)
	  (at lisa par-airport)
	  (at michelle jfk-airport)
	  (at jason bos-airport)
	  (at paper par-airport)
	  (at betty jfk-airport)
	  )
	 )
  )
