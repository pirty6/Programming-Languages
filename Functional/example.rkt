#lang racket
(define get-letter (lambda (name i)
                     (cond
                       [(= 1 i) (first name)]
                       [else (get-letter (rest name)(- i 1))])))

(get-letter (cons 'j(cons 'i(cons 'z(cons 'z(cons 'z  empty))))) 5)

(define (fib number)
            (cond
              [(= number 1) 1]
              [(= number 2) 1]
              [else (+ (fib (- number 2)) (fib(- number 1)))]))

(define (fibt number)
  (define (helper number a b)
    (cond
      [(= number 1) a]
      [(= number 2) b]
      [else (helper (- number 1) b (+ a b))]
  ))
  (helper number 1 1))

(fib 4)
(fibt 4)

