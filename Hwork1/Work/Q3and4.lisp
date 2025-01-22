; Question 4 first: construct the following lists using only symbols and calls to cons
; 4A: (a b x d)
(print "List A")
(defvar listA)
(setq listA nil)
(setq listA(cons 'd listA))
(setq listA(cons 'x listA))
(setq listA(cons 'b listA))
(setq listA(cons 'a listA))

(print listA)
(terpri) ; Add a new line

; 4B: (a (b (x d)))
(print "List B")
(defvar listB)
(setq listB nil)
(setq listB(cons 'd listB))
(setq listB(cons 'x ListB))
(setq listB(cons listB nil))

(setq listB(cons 'b listB))
(setq listB(cons listB nil))

(setq listB(cons 'a listB))

(print listB)
(terpri)

; 4C: (((a (b (x) d))))
(print "List C")
(defvar listC)
(setq listC nil)

; xList will become the (b (x) d) part of things
(defvar xList)
(setq xList nil)
(setq xList(cons 'x xList))

; We need d in a cons cell
(defvar dEle)
(setq dEle nil)
(setQ dEle(cons 'd dEle))

; Add in d after our (x) element
(setq xList(cons xList dEle))
; Add b to the start of our xList
(setq xList(cons 'b xList))

; Set xList to B's CDR
(setq listC(cons xList listC))
(setq listC(cons 'a listC))

; We need two more pairs of parentheses wrapping everything
(setq listC(cons listC nil))
(setq listC(cons listC nil))

(print listC)
(terpri)


; Now question 3 to test our lists from question 4
; Find the sequence of CARs and CDRs that return x when applied to the following expressions:
; a: ( a b x d)
(print "Finding x in List A with CADDR")
(print(caddr listA))

(print "Finding x in List B with CAADADR")
;(print (caadadr listB)) - Since caadadr is not a valid symbol, I manually go through the cars and cdrs below. 
; This happens again to find X in List C.
(print(car(car (cdr (car (cdr listB))))))

(print "Finding x in List C with CAADADAAR")
;(print (caadadaar listC))
(print(car(car(cdr(car(cdr(car(car listC))))))))
(terpri)

(quit)