; 1. Define a recursive function to do the partitioning.
(defun partition (unprocessed-list list1 list2)
    ; Base case: if unprocessed-list is empty
    (if (null unprocessed-list)
        ; Return the two lists
        (list list1 list2)
        ; Recursive step: process the next two items
        (let
            (
                (first-item (car unprocessed-list)) ; Get the first item
                (rest-list (cdr unprocessed-list))  ; Get the rest of the list
            )
            (if (null rest-list) ; Check if there is only one item left
                ; If only one item left, add it to list1 and return
                (partition nil (append list1 (list first-item)) list2)
                ; If there are two or more items, take two
                (let
                    (
                        (second-item (car rest-list)) ; Get the second item
                        (rest-of-rest (cdr rest-list)) ; Get the rest of the rest
                    )
                    ; Recursively call partition with the rest of the list
                    (partition rest-of-rest (append list1 (list first-item)) (append list2 (list second-item)))
                )
            )
        )
    )
)

; 3. Define a merge function that merges two sorted lists.
(defun mergeHalves (leftHalf rightHalf)
    ; We need to merge our two halves of the lists
    (let*
        (
            ; We will merge the two by comparing values in the left half to the right half, and inserting the lower value into our main list (nums)
            ; To do this, we need indices for all of them.
            (mergedList ()) ; mergedList will be our merged list
        )
        (progn ; I am using progn so that I can put all of the expressions below into one block for this let*
            ; Now that all of our variables are defined, we must compare indices and set the our nums index to the lower one
            (loop while ( and (not (null leftHalf)) (not (null rightHalf)) )
                do
                (if (<= (car leftHalf) (car rightHalf))
                    ; if leftHalf[0] <= rightHalf[0] - then we need to use our left value
                    (progn
                        (setf mergedList (append mergedList (list (car leftHalf))))
                        (setf leftHalf (cdr leftHalf))
                    )

                    ; else rightHalf[0] < leftHalf[0] - then we use our right value
                    (progn
                        (setf mergedList (append mergedList (list (car rightHalf))))
                        (setf rightHalf (cdr rightHalf))
                    )
                )

            )

            ; Our loop broke, but it is possible that one of our halves still has elements left
            (loop while (not (null leftHalf))
                do
                (setf mergedList (append mergedList (list (car leftHalf))))
                (setf leftHalf (cdr leftHalf))
            )

            (loop while (not (null rightHalf))
                do
                (setf mergedList (append mergedList (list (car rightHalf))))
                (setf rightHalf (cdr rightHalf))
            )
             mergedList ; return merged list
        )
    )
)


; 4. Define the mergesort function using the partition function and the merge function.
; Merge sort function which takes in the list of numbers (nums), and the indices upon which to sort (left, right)
(defun mergeSort (nums)
    ; Base case: If nums is empty or has one element, it's already sorted
    (if (or (null nums) (null (cdr nums))) ; if list is nil or cdr of list is nil (1 element list)
        ; No sorting needed
        nums
        ; If there is sorting to do, we must split our range of numbers into two and sort both halves, then merge them

        ; This means we need some variables, given that we need our two halves from partition
        (let
            ; Get our two lists from partition
            ((partitioned-lists (partition nums () ()))) ; Call partition to split nums

            (let
                (
                 (list1 (car partitioned-lists)) ; extract list 1
                 (list2 (car (cdr partitioned-lists))) ; extract list 2
                 )
                 (progn
                    (setf list1 (mergeSort list1)) ; Recursively sort list1
                    (setf list2 (mergeSort list2)) ; Recursively sort list2
                    ; After both halves of our array have been sorted, we can merge the two of them
                    (mergeHalves list1 list2) ; Merge the sorted lists
                 )
            )
        )
    )
)

(defun sortArray (nums)
    (mergeSort nums) ; We will call mergeSort on the list of nums
)

; let's try our sorting out
(let ((test-array (list 5 2 8 1 9 4 7 6 3)))
  (format t "Original array: ~a~%" test-array)
  (let ((sorted-array (sortArray test-array)))
    (format t "Sorted array: ~a~%" sorted-array)))

(quit)