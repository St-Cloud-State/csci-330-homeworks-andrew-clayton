;;;; Bottom-Up Mergesort in Lisp 
;; Step 3a: Partition the list into sorted pairs
(defun partitionIntoPairs (listToPartition)
  (let ((pairs ()))
    (loop while listToPartition
          do (let ((firstItem (car listToPartition)))
               (setf listToPartition (cdr listToPartition))
               (if listToPartition
                   (let ((secondItem (car listToPartition)))
                     (setf listToPartition (cdr listToPartition))
                     (setf pairs (append pairs (list (sort (list firstItem secondItem) '<)))))
                   (setf pairs (append pairs (list (list firstItem)))))
             )
        )
    pairs
    )
)

;; Step 3c (Adapted from Question 2): Merge two sorted lists
(defun mergeLists (leftList rightList)
  (let ((mergedList ()))
    (loop while (and leftList rightList)
          do (if (<= (car leftList) (car rightList))
                 (progn
                   (setf mergedList (append mergedList (list (car leftList))))
                   (setf leftList (cdr leftList))
                 )
                 (progn
                   (setf mergedList (append mergedList (list (car rightList))))
                   (setf rightList (cdr rightList))
                 )
            )
    )
    (append mergedList leftList rightList))
)

;; Step 3b: In each pass, merge adjacent lists
(defun mergeAdjacentListsPass (listOfLists)
  (let ((mergedLists ()))
    (loop while listOfLists
          do (let ((firstList (car listOfLists)))
               (setf listOfLists (cdr listOfLists))
               (if listOfLists
                   (let ((secondList (car listOfLists)))
                     (setf listOfLists (cdr listOfLists))
                     (setf mergedLists (append mergedLists (list (mergeLists firstList secondList)))))
                   (setf mergedLists (append mergedLists (list firstList))))
            )
        )
    mergedLists
    )
)

;; Step 3d: Combine into bottomUpMergesort
(defun bottomUpMergesort (nums)
  (let ((current-listOfLists (partitionIntoPairs nums)))
    (loop while (> (length current-listOfLists) 1)
          do (setf current-listOfLists (mergeAdjacentListsPass current-listOfLists)))
    (car current-listOfLists)
    )
)

;; Test code
(let ((testArray (list 1 7 7 2 12 8 6 5 -3 9 4)))
  (format t "Original array: ~a~%" testArray)
  (let ((sortedArray (bottomUpMergesort testArray)))
    (format t "Sorted array: ~a~%" sortedArray)))

(quit)