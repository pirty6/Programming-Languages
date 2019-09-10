;; ITESM QRO
;; Mariana Perez Garcia A01206747
;; Lab 1

#lang racket

;; triangle-area : number -> number
;; Function to calculate the area of a triangle given the base and height of it
(define (triangle-area b h)
  (/ (* b h) 2))
;; Example: (triangle-area 5 8) = 2 

;; a: number -> number
;; Function to calculate the result from (x² + 10)
(define (a n)
  (+ (expt n 2) 10))
;; Example: (a 12) = 154

;; b: number -> number
;; Function to calculate the result from (1/2 * x² + 20)
(define (b n)
  (+ (* (/ 1 2) (expt n 2)) 20))
;; Example: (b 12) = 92

;; c: number -> number
;; Function to calculate the result from (2 - 1/n)
(define (c n)
  (- 2 (/ 1 n)))
;; Example: (c 12) = 1(11/12)


;; solutions: number number number -> string
;; function that returns the number of possible solutions of a quadatic equation
(define (solutions a b c)
  (cond
    [( > (expt b 2) (* 4 a c)) 2]
    [( = (expt b 2) (* 4 a c)) 1]
    [else 0]))
;; Example (solutions 2 5 1) = 2

;; Test Cases
"Triangle Area"
(triangle-area 5 8)

"Function a"
(a 12)

"Function b"
(b 12)

"Function c"
(c 12)

"Number of solutions to a quadratic equation"
(solutions 2 5 1)
(solutions 2 4 2)
(solutions 5 1 3)