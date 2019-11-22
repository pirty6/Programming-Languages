#lang racket
;;helper function to check if a node is at the bottom of the tree
(define (leaf? tree)
  (cond
    [(empty? (cdr tree)) true]
    [else false]))

;;helper function to get children of a node (which are the rest of the anidated list)
(define (children tree)
  (cdr tree))


(define (count-levels tree);;sums all the nodes
  (if (leaf? tree)
      (first tree)
      (+(count-levels-in-forest (children tree))(first tree))));;calls in-forest to explore the width (mutual recursion)


(define (count-levels-in-forest forest)
  (if (null? forest)
      0
      (+ (count-levels (car forest));;calls the count-leaves to explore depth (mutual recursion)
         (count-levels-in-forest (cdr forest )))));;recursive call unto itself to explore the tree

