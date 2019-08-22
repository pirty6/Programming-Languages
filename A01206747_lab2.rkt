#lang racket
(define (power-head b e)
  (cond
    [(= 0 e) 1]
    [else ( * b (power-head b (- e 1)))]))

(define (tail-head b e)
  (define (helper e t)
    (cond
      [(= 0 e) t]
      [else (helper (- e 1) (* t b))]))
  (helper e 1))

(define (third list)
  (first (rest (rest list))))

(define (just-two? list)
  (define (helper list i)
    (cond
      [(empty? list)
       (cond
         [(= i 2) true]
         [else false])]
      [else (helper (rest list) (+ i 1))]))
  (helper list 0))


(define (how-many-x? list n)
  (define (helper list n t)
    (cond
      [(empty? list) t]
      [else (helper(rest list) n
         (cond
              [(= n (first list)) (+ t 1)]
              [else t]))]))
  (helper list n 0))

(define (all-x list)
  (define (helper list n)
    (cond
      [(empty? list) true]
      [else (and (= n (first list)) (boolean? (helper(rest list) n)))]))
  (helper list (first list)))

(power-head 4 3)

(tail-head 4 3)

(third (cons 1(cons 2(cons 3(cons 4(cons 5 empty))))))

(just-two? (cons 1 empty))
(just-two? (cons 1(cons 4 empty)))
(just-two? (cons 1(cons 4 (cons 5 empty))))

(define list1 (cons 1(cons 2 (cons 3 (cons 4 (cons 3 empty))))))
(how-many-x? list1 3)

(all-x list1)