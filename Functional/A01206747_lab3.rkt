;; ITESM QRO
;; Mariana Perez Garcia A01206747
;; Lab 3

#lang racket

;; deep-all-x?: tree number -> boolean
;; Function that receives a list containing other lists and an x element. The function
;; returns true if all the elements in the list of list are x. Otherwise returns false
(define (deep-all-x? tree x)
  (cond
    [(empty? tree) #t]
    [(not (eq? (first tree) x)) #f]
    [else (deep-all-x-branch? (rest tree) x)]))

(define (deep-all-x-branch? branch x)
  (cond
    [(empty? branch) #t]
    [(and (deep-all-x? (first branch) x) (deep-all-x-branch? (rest branch) x)) #t]
    [else #f]))
;; Example: (deep-all-x? '(a(a(a)(a))(a(a)(a))) 'a) =  #t

;; deep-reverse: tree -> tree
;; Function that receives a deep list and returns a list of lists with its elements
;; in reverse
(define (deep-reverse tree)
  (define (helper original new)
    (cond
      [(empty? original) new]
      [(list? (first original)) (helper (rest original) (cons (invert(first original)) new))]
      [else (helper (rest original) (cons (first original) new))]))
  (helper tree '()))

(define (invert l)
    (cond
      [(empty? l) l]
      [else l (append (invert (rest l)) (list (first l)))]))
;; Example: (deep-reverse '(a (b (c) (d)) (e (f) (g)))) = '(((g) (f) e) ((d) (c) b) a)

                                                              
;; Flatten: tree -> list
;; Function that receives a deep list and returns a list containing all the elements
;; in a single 1 level list

(define (flatten tree)
  (cond
    [(empty? tree) '()]
    [else (cons (first tree) (flatten-branch (rest tree)))]))

(define (flatten-branch branch)
  (cond
    [(empty? branch) '()]
    [else (append (flatten (first branch)) (flatten-branch (rest branch)))]))
;; Example: (flatten '(a (b (c)(d))(e(f)(g)))) = '(a b c d e f g)

;; Count-levels: tree -> number
;; Function that receives a deep list and returns the max depth of the tree
(define (count-levels tree)
  (cond
    [(empty? tree) 0]
    [else (+ 1 (count-levels-branch (rest tree)))]))

(define (count-levels-branch branch)
  (cond
    [(empty? branch) 0]
    [else (max(count-levels (first branch))
              (count-levels-branch(rest branch)))]))

(define (max x y)
  (cond
    [(> x y) x]
    [else y]))
;; Example: (count-levels '(a(b(c)(d))(e(f)(g)))) = 3 

;; Count-max-arity: tree -> number
;; Function that counts the max number of children in a single node of the tree
(define (count-max-arity tree)
  (cond
    [(empty? tree) 0]
    [else (max (arity (first tree))(count-max-arity (rest tree)))]))

(define (arity node)
  (cond
    [(list? node) (max (- (length node) 1) (count-max-arity (rest node)))]
    [else 0]))
;; Example: (count-max-arity '(a(b(c)(d))(e(f)(g)(h)(i)))) = 4


;;Test Cases
"Deep all x? '(a(b(c)(d))(f(g)(h))) 'a"
(deep-all-x? '(a(b(c)(d))(f(g)(h))) 'a)
"Deep all x? '(a(a(a)(a))(a(a)(a))) 'a"
(deep-all-x? '(a(a(a)(a))(a(a)(a))) 'a)
"Deep all x? '(a(a(a)(b))(a(a)(a))) 'a"
(deep-all-x? '(a(a(a)(b))(a(a)(a))) 'a)

"Deep-reverse '(a (b (c) (d)) (e (f) (g)))"
(deep-reverse '(a (b (c) (d)) (e (f) (g))))

"Flatten '(a (b (c)(d))(e(f)(g)))"
(flatten '(a (b (c)(d))(e(f)(g))))

"Count levels '(a(b(c)(d))(e(f)(g)))"
(count-levels '(a(b(c)(d))(e(f)(g))))

"Count max arity '(a(b(c)(d))(e(f)(g)(h)(i)))"
(count-max-arity '(a(b(c)(d))(e(f)(g)(h)(i))))
"Count max arity '(a(b(c)(d))(e(f)(g)(h)(i)(j)))"
(count-max-arity '(a(b(c)(d))(e(f)(g)(h)(i)(j))))

(define (find tree x)
  (cond
    [(empty? tree) #f]
    [(eq? (first tree) x) #t]
    [else (find-branch (rest tree) x)]))

(define (find-branch branch x)
  (cond
    [(empty? branch) #f]
    [else (or (find (first branch) x) (find-branch (rest branch) x))]))

(define t '(8(5 (2) (7))(11 (9) (61))))
(find t 8)
(find t 61)
(find t 9)
(find t 100)
(find t (- 0 100))
(find t 7)
(find t 12)


(define (multiply tree x)
  (cond
    [(empty? tree) '()]
    [else (cons (* (first tree) x) (multiply-branch (rest tree) x))]))

(define (multiply-branch branch x)
  (cond
    [(empty? branch) '()]
    [else (cons (multiply (first branch) x) (multiply-branch (rest branch) x))]))

(multiply t 1)
(multiply t 2)