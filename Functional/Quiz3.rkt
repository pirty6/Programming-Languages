#lang racket
(define (leaf? node)
  (cond
    [(empty? (rest node)) #t]
    [else #f]))

(define (leafs tree)
  (cond
    [(empty? tree) '()]
    [(leaf? tree) (cons (first tree) '())]
    [else (leafs-branch(rest tree) '())]))

(define (leafs-branch branch l)
  (cond
    [(empty? branch) l]
    [else (leafs-branch (rest branch) (append l (leafs (first branch))))]))             

(define (append lA lB)
  (cond
    [(empty? lA) lB]
    [else (cons (first lA) (append(rest lA) lB))]))



(define t'(8(5(2)(7))(11(9))))
(leafs t)

(leafs '(8(5(2)(7))))
(leafs '(8(5(2)(7))(11(9)(61))))
(leafs '())
(leafs '(1))

