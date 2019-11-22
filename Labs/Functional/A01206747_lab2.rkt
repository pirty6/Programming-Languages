;; ITESM QRO
;; Mariana Perez Garcia A01206747
;; Lab 2

#lang racket

;; power-head: number number -> number
;; Function to calculate the power of a given number where b is the base and e is the exponent
;; using head recurssion
(define (power-head b e)
  (cond
    [(= 0 e) 1]
    [else ( * b (power-head b (- e 1)))]))
;; Example: (power-head 4 3) = 64


;; tal-head: number number -> number
;; Functio to calculate the power of a given number where b is the base and e is the exponent
;; using tail recurssion
(define (tail-head b e)
  (define (helper e t)
    (cond
      [(= 0 e) t]
      [else (helper (- e 1) (* t b))]))
  (helper e 1))
;; Example: (tail-head 4 3) = 64


;; third: list -> number
;; Function that returns the third element in a list
(define (third list)
  (first (rest (rest list))))
;; Example: (third (cons 1(cons 2(cons 3(cons 4(cons 5 empty)))))) = 3 


;; just-two?: list -> boolean
;; Function that return true if the given list has only two elements otherwise it returns false
(define (just-two? list)
  (define (helper list i)
    (cond
      [(empty? list)
       (cond
         [(= i 2) true]
         [else false])]
      [else (helper (rest list) (+ i 1))]))
  (helper list 0))
;; Example: (just-two? (cons 1 empty)) = true
;; Example: (just-two? (cons 1(cons 4 empty))) = false


;; how-many-x?: list number - > number
;; Function that returns the number of elements in a list that are equal to the given x
(define (how-many-x? list n)
  (define (helper list n t)
    (cond
      [(empty? list) t]
      [else (helper(rest list) n
         (cond
              [(= n (first list)) (+ t 1)]
              [else t]))]))
  (helper list n 0))
;; (how-many-x? '(1 2 3 4 3) 3) = 2


;; all-x: list -> boolean
;; Function that returns true if all the elements in a list are the same otherwise it returns false
(define (all-x list)
  (define (helper list n t)
    (cond
      [(empty? list) t]
      [else (helper (rest list) (first list)
                    (cond
                      [(= (first list) n) true]
                      [else false]))]))
  (helper (rest list)(first list) true))
;; Example: (all-x '(1 2 3 4 3)) = false
;; Example: (all-x '(1 1 1)) = true


;, get: list -> number
;; Function that returns the first position of a given number in a list, if the number is not in the list it returns -1
(define (get list x)
  (define (helper list i)
    (cond
      [(empty? list) -1]
      [(= x (first list)) (+ i 1)]
      [else (helper (rest list) (+ i 1))]))
  (helper list 0))
;; Example: (get '(1 2 3 4 3) 2) = 2
;; Example: (get '(1 2 3 4 3) 5) = -1


;; difference: list list -> list
;; Function that returns a list of elements that are not present in listB
(define (difference lA lB)
  (define (helper lA lB l)
    (cond
      [(empty? lB) lA]
      [(empty? lA) '()]
      [else
       (cond
         [(eq?(diff-helper (first lA) lB) false) l (append (helper (rest lA) lB l) (list (first lA)))]
         [else (helper (rest lA) lB l)])]))
  (helper lA lB '()))

(define (diff-helper item lB)
  (cond
    [(empty? lB) false]
    [(= item (first lB)) true]
    [else (diff-helper item (rest lB))]))
;; Example: (difference '(12 44 55 77 66 1 2 3 4) '(1 2 3)) = '(4 66 77 55 44 12)


;; append: list list -> list
;; Function that returns a list that appends first all the elements in the listA and then all the elements in listB
(define (append lA lB)
  (cond
    [(empty? lA) lB]
    [else (cons (first lA) (append(rest lA) lB))]))
;; Example: (append '(a b c d) '(e f g)) = '(a b c d e f g)


;; invert list -> list
;; Function that returns the inverse of the given array, uses the function append
(define (invert l)
    (cond
      [(empty? l) l]
      [else l (append (invert (rest l)) (list (first l)))]))
;; Example: (invert '(a b c d)) = '(d c b a)


;; sign: list - > list
;; Function that returns a list of numbers and returns a 1 or -1 depending on wether each number is bigger or smaller than 0
(define (sign l)
  (cond
    [(empty? l) '()]
    [(> (first l) 0) (cons 1(sign (rest l)))]
    [(< (first l) 0) (cons -1(sign (rest l)))]))
;; Example: (sign '(2 -4 -6)) = '(1 -1 -1)


;; negatives: list -> list
;; Function that returns a list of numbers that return the negative value of each of the elements in the given list
(define (negatives l)
  (cond
    [(empty? l) '()]
    [else (cons (* -1 (first l))(negatives (rest l)))]))
;; Example: (negatives '(2 4 6)) = '(-2 -4 -6)


;;Test Cases
"Power-Head of 4^3:"
(power-head 4 3)

"Tail-Head of 4^3:"
(tail-head 4 3)

"Third of (1 2 3 4 5):"
(third (cons 1(cons 2(cons 3(cons 4(cons 5 empty))))))

"Just-Two? of (1):"
(just-two? (cons 1 empty))
"Just-Two? of (1 4):"
(just-two? (cons 1(cons 4 empty)))
"Just-Two? of (1 4 5)"
(just-two? (cons 1(cons 4 (cons 5 empty))))

"How-Many-X? of (1 2 3 4 3) 3:"
(how-many-x? '(1 2 3 4 3) 3)

"All-X of 1 2 3 4 3:"
(all-x '(1 2 3 4 3))
"All-X of (1 1 1):"
(all-x '(1 1 1))

"Get of (1 2 3 4 3) 2:"
(get '(1 2 3 4 3) 2)
"Get of (1 2 3 4 3) 5:"
(get '(1 2 3 4 3) 5)
"Get of (1 2 3 4 3) 3:"
(get '(1 2 3 4 3) 3)

"Difference of (12 44 55 77 66 1 2 3 4) (1 2 3):"
(difference '(12 44 55 77 66 1 2 3 4) '(1 2 3))

"Append of (a b c d) (e f g):"
(append '(a b c d) '(e f g))
"Append of '() (a b c):"
(append '() '(a b c))

"Invert of a b c d:"
(invert '(a b c d))
"Invert of empty:"
(invert '())

"Sign of (2 -4 -6):"
(sign '(2 -4 -6))

"Negatives of (2 4 6):"
(negatives '(2 4 6))

;; Total sum of two lists
(define (sumTotal lA lB)
  (define (helper lA lB total)
    (cond
      [(and (empty? lA)(empty? lB)) total]
      [(empty? lA) (+ total (first lB))]
      [(empty? lB) (+ total (first lA))]
      [else (helper (rest lA) (rest lB) (+ total (first lA) (first lB)))]))
  (helper lA lB 0))

(sumTotal '(1 2 3 4) '(5 6 7))

;; sum of the elements per index
(define (sum lA lB)
  (cond
    [(and (empty? lA)(empty? lB)) '()]
    [(empty? lA) (cons (first lA) (sum (rest lA) lB))]
    [(empty? lB) (cons (first lB) (sum lA (rest lB)))]
    [else (cons (+ (first lA) (first lB)) (sum (rest lA) (rest lB)))]))
(sum '(1 2 3) '(1 2 3))

;; find the element in the middle
(define (mid l)
  (define (helper l length)
    (cond
      [(empty? l) length]
      [else (helper (rest l) (+ 1 length))]))
   (define (find l length i)
     (cond
       [(= (floor(/ length 2)) i) (first l)]
       [else (find (rest l) length (+ i 1))]))
  (find l (helper l 0) 0))

(mid '(1 2 3 6))

;;  map using a lambda
(define (map op l)
  (cond
    [(empty? l) '()]
    [else (cons (op (first l)) (map op (rest l)))]))
(map (lambda (x)(* x x)) '(1 2 3))

;; Car = first cdr = rest
