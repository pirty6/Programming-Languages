#lang racket

(define (leaf? tree)
  (cond
    [(empty? (cdr tree)) #t]
    [else #f]))

;; Flatten
;;(define (flatten tree)
;;    (cond
;;       ((null? tree) '())
;;      ((atom? (car tree)) (cons (car tree) (flatten (cdr tree))))
;;       (else
;;          (append (flatten (car tree))
;;                  (flatten (cdr tree)))))
;;)


;; Function which receives a list containing other lists and an element x. The function
;; returns true if every single element in the list of lists is x. Otherwise it returns false
(define (deep-all-x? dl x)
  (cond
    [(empty? dl) #f]
    [else (list-all-x? dl x)]))

(define (list-all-x? l x)
  (cond
    [(empty? l) #f]
    [(not (eq? (first l) x)) #f]
    [(list? (first l)) (and (deep-all-x?(first l) x) (list-all-x? (rest l) x))]
    [else (list-all-x? (rest l) x)]))

"Deep all x?"
(deep-all-x? '(a(b(c)(d))(f(g)(h))) 'a)
(deep-all-x? '(a(a(a)(a))(a(a)(a))) 'a)

;; Find if element is in list
(define (find tree x)
  (cond
    [(empty? tree) #f]
    [else (find-elem tree x)]))

(define (find-elem l x)
  (cond
    [(empty? l) #f]
    [(eq? (first l) x) #t]
    [(list? (first l)) (or (find(first l) x) (find-elem (rest l) x))]
    [else (find-elem (rest l) x)]))

"FIND"
(find '(a(b(c)(d)(e(f)(g)))) 'a)
(find '(a(b(c)(d)(e(f)(g)))) 'h)


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
    [else (get-depth-branch (rest tree))]))

(define (get-depth-branch branch)
  (cond
    [(empty? branch) 0]
    [else (diff (+ 1 (get-depth (first branch)))
          (get-depth-branch (rest branch)))]))     

(define (diff x y)
  (cond
    [(> x y) x]
    [else y]))

;; Function to count the number of elements in a tree
(define (count tree)
  (cond
    [(empty? tree) 0]
    [(leaf? tree) 1]
    [else (count-branch (rest tree) 1)]))

(define (count-branch branch curr_sum)
  (cond
    [(empty? branch) curr_sum]
    [else (count-branch(rest branch)(+ curr_sum (count (first branch))))]))
              
"TOTAL SUM"
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

(+ 1 (get-depth '(a(b(c)(d)(e(f)(g))))))
(+ 1 (get-depth '(a(b(c)(d))(f(g)(h)))))

"Count"
(count '(1(2(3)(4))(5(6)(7))))
(count '(1(2)(3)))