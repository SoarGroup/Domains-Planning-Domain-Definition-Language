;; No solution, endless recursion (in UCPOP, maybe).

(define (problem run-jack-run)
  (:domain travel)
  (:objects jack KI rockwell)
  (:init (at jack rockwell)
	 (road rockwell KI) (road KI rockwell))
  (:goal (and (at jack KI) (at jack rockwell)))
  )
