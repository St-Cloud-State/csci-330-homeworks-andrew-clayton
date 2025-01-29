; ---3.1---
(print "(NOT (EQUAL 3 (ABS -3)))")
(NOT (EQUAL 3 (ABS -3)))

; ---3.2---
(/ (+ 8 12) 2)


; ---3.3---
(+ (* 3 3) (* 4 4))

; ---3.7---
(defun miles-per-gallon (init-odometer-reading fin-odometer-reading gallons-consumed) (/ (- init-odometer-reading fin-odometer-reading) gallons-consumed))
(miles-per-gallon 2 1 1)

; ---3.10---
; 1
(third (the quick brown fox))
; Error: 'the' operator has too many parameters (the being interpreted as an operator)
; Argument must be quoted

; Fixed:
(third '(the quick brown fox))

; 2
(list 2 and 2 is 4)
; Error: variable AND is unbound
; Symbols as data must be quoted

; Fixed:
(list 2 'and 2 'is 4)

; 3
(+ 1 '(length (list t t t t)))
; Error: value "(LENGTH (LIST T T T T))" is not of type NUMBER
; This is trying to construct a list rather than evaluating the output of the length operation.
; If we remove the quote, then the number that length returns can be added properly.

; Fixed:
(+ 1 (length (list t t t t)))

; 4
(cons 'patrick (seymour marvin))
; Error: variable marvin is unbound
; The symbols semour and marvin do not have quotes ' before them.

; Fixed
(cons 'patrick (list `seymour `marvin))

; ---3.20.---
(defun mystery (x) (list (second x) (first x)))
; What result or error is produced by evaluating each of the following?

(mystery '(dancing bear)) ; Output: (BEAR DANCING)
(mystery 'dancing 'bear) ; Invalid number of arguments: 2
(mystery '(zowie)) ; Output: (NIL ZOWIE)
(mystery (list 'first 'second)) ; Output: (SECOND FIRST)


; ---3.21 in pdf---


; ---3.25 in PDF as well---
(list 'cons t nil) ; (CONS T NIL)

(eval (list 'cons t nil)) ; (T)

(eval (eval (list 'cons t nil))) ; error undefined function T

(apply #'cons '(t nil)) ; (T)

(eval nil) ; NIL

(list 'eval nil) ; (eval nil)

(eval (list 'eval nil)) ; NIL