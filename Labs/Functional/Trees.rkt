#lang racket

(define (leaf? tree)
  (cond
    [(empty? (cdr tree)) #t]
    [else #f]))

;; Function which receives a list containing other lists and an element x. The function
;; returns true if every single element in the list of lists is x. Otherwise it returns false
(define (deep-all-x? dl x)
  (cond
    [(empty? dl) #f]
    [else (list-all-x? dl x)]))

(define (list-all-x? l x)
  (cond
    [(empty? l) #f]
    [(eq? (first l) x) (list-all-x? (rest l) x)]
    [(list? (first l)) (and (list-all-x? (first l) x) (list-all-x? (rest l) x))]
    [else #f]))

(deep-all-x? '(a(b(c)(d))(f(g)(h))) 'a)

;; Function that return the max value in a binary tree
(define (max tree)
  (cond
    [(empty? tree) -1]
    [(leaf? tree) (first tree)]
    [else(iterate (rest tree) (first tree))]))

(define (iterate branch val)
  (cond
    [(empty? branch) val]
    [else (diff val (diff (max(first branch)) (iterate (rest branch) val)))]))

(define (diff x y)
  (cond
    [(> x y) x]
    [else y]))


;; Function to return the sum of all nodes
(define (total-sum tree)
  (cond
    [(empty? tree) 0]
    [(leaf? tree) (first tree)]
    [else (sum (rest tree) (first tree))]))

(define (sum branch curr_sum)
  (cond
    [(empty? branch) curr_sum]
    [else (sum (rest branch) (+ curr_sum (total-sum(first branch))))]))

;; Function to count the number of leaf
(define (count-leaves tree)
  (cond
    [(empty? tree) 0]
    [(leaf? tree) 1]
    [else (count-leaves-in-branch (rest tree))]))

(define (count-leaves-in-branch branch)
  (cond
    [(null? branch) 0]
    [else (+ (count-leaves (first branch)) (count-leaves-in-branch (rest branch)))]))

;; Function to sum all the values in all the leaves
(define (sum-leaves tree)
  (cond
    [(empty? tree) 0]
    [(leaf? tree) (first tree)]
    [else (sum-leaves-branch (rest tree))]))

(define (sum-leaves-branch branch)
  (cond
    [(empty? branch) 0]
    [else (+ (sum-leaves (first branch)) (sum-leaves-branch (rest branch)))]))


;; Function to get the depth of a tree
(define (get-depth tree)
  (cond
    [(empty? tree) 0]
    [(leaf? tree) 1]
    [else (get-depth-branch (rest tree))]))


              

(max '(1(2(3)(4))(5(6)(7))))
(max '(8(5(2)(7))(11(9))))
(max '())

(total-sum '(1(2(3)(4))(5(6)(7))))
(total-sum '(8(5(2)(7))(11(9))))
(total-sum '())
(total-sum '(1(2)(3)))

(count-leaves '(a(b(c)(d)(e(f)(g)))))

"Add Leaves"
(sum-leaves '(1(2(3)(4))(5(6)(7))));;20
(sum-leaves '(1(3)(4)));;7
(sum-leaves '(100));;100
(sum-leaves '(1(3(6(12(40(42)))))));;42