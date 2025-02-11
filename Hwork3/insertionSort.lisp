; Insertion sort

(defun insertSorted (elementToInsert sortedList)
    (if (null sortedList)
        ; Base case: sortedList is empty, so we can just add our element in
        (list elementToInsert) ; Just return a list with that element

        ; Bsae case 2: element is smaller than the first in the sorted list
        (if (< elementToInsert (car sortedList))
            ; Then we can add our element to the start of the sorted list
            (cons elementToInsert sortedList) 
            ; Otherwise, we need to compare it to the rest of the list
            ; We know for sure that the first element of sortedList should remain in its place
            (cons (car sortedList) (insertSorted elementToInsert (cdr sortedList))) ; we have to use (car sortedList) to ensure that our first element remains at the front of the result we get
        )
    )
)

(defun insertionSort (unsortedList sortedList)
    ; Base case: unsortedList is empty
    (if (null unsortedList)
        sortedList

        ; Otherwise, we recurse
        (let 
            (
                (firstUnsortedElement (car unsortedList))
                (restUnsortedList (cdr unsortedList))
            )
            (
                ; Recursively call insertion sort with the rest of our unsorted list, and our newly sorted list (which we insert our unsorted element into)
                insertionSort restUnsortedList (insertSorted firstUnsortedElement sortedList)
            )
        )       
    )
)

(defun sortList (nums)
    (insertionSort nums ())
)


; let's try our sorting out
(let ((testList (list 5 2 8 1 9 4 7 6 3)))
  (format t "Original list: ~a~%" testList)
  (let ((sortedList (sortList testList)))
    (format t "Sorted list: ~a~%" sortedList)))

(quit)
