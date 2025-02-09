; 3.1. What does (NOT (EQUAL 3 (ABS -3))) evaluate to?
; NIL


; 3.2. Write an expression in EVAL notation to add 8 to 12 and divide the result by 2.
eval(/ (+ 8 12) 2)

; 3.3. You can square a number by multiplying it by itself. Write an expression in EVAL notation to add the square of 3 and the square of 4.
eval(+ (* 3 3) (* 4 4))

; 3.7. Define a function MILES-PER-GALLON that takes three inputs, called INITIAL-ODOMETER-READING, FINAL-ODOMETER-READING, and GALLONS-CONSUMED, 
; and computes the number of miles traveled per gallon of gas.



; 3.10. The following expressions all result in errors. Write down the type of error that occurs, explain how the error arose (for example, missing quote, quote in wrong place), 
; and correct the expression by changing only the quotes.

; Original code
(third (the quick brown fox))
(list 2 and 2 is 4)
(+ 1 ’(length (list t t t t)))
(cons ’patrick (seymour marvin))
(cons ’patrick (list seymour marvin))



; 3.20. Here is a mystery function:
(defun mystery (x)
(list (second x) (first x)))
; What result or error is produced by evaluating each of the following?
(mystery ’(dancing bear)) ; comment or print answers?
(mystery ’dancing ’bear)
(mystery ’(zowie))
(mystery (list ’first ’second))


; 3.21. What is wrong with each of the following function definitions?
(defun speak (x y) (list ’all ’x ’is ’y))
(defun speak (x) (y) (list ’all x ’is y))
(defun speak ((x) (y)) (list all ’x is ’y))



; 3.25. What do each of the following expressions evaluate to?
(list ’cons t nil)
(eval (list ’cons t nil))
(eval (eval (list ’cons t nil)))
(apply #’cons ’(t nil))
(eval nil)
(list ’eval nil)
(eval (list ’eval nil))