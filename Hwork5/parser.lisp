(defvar *input-stream* nil)

(defun peek-next-char ()
  (peek-char nil *input-stream* nil nil))

(defun consume-char ()
  (read-char *input-stream* nil nil))

(defun match-terminal (char)
  (let ((next-char (peek-next-char)))
    (if (and next-char (char= next-char char))
        (consume-char)
        nil)))

;; Parser functions 

(defun parse-G ()
  (let ((current-char (peek-next-char)))
    (if current-char ; Check for NIL
        (cond
          ((char= current-char #\x) (consume-char) t)
          ((char= current-char #\y) (consume-char) t)
          ((char= current-char #\z) (consume-char) t)
          ((char= current-char #\w) (consume-char) t)
          (t nil))
        nil))) ; Handle NIL: return nil if no char

(defun parse-F () ; F -> G
  (parse-G))

(defun parse-E () ; E -> GoG
  (if (parse-G)
      (if (match-terminal #\o)
          (parse-G)
          nil)
      nil))

(defun parse-S () ; S -> s
  (if (match-terminal #\s)
      t
      nil))

(defun parse-I-prime () ; I' -> epsilon
  t)

(defun parse-I () ; I -> iES
  (if (match-terminal #\i)
      (if (parse-E)
          (if (parse-S)
              (parse-I-prime)
              nil)
          nil)
      nil))

;; String generation functions

(defun generate-valid-G-string ()
  (let ((choices '(#\x #\y #\z #\w)))
    (string (nth (random (length choices)) choices))))

(defun generate-valid-E-string () ; E -> GoG
  (concatenate 'string (generate-valid-G-string) "o" (generate-valid-G-string)))

(defun generate-valid-F-string () ; F -> G
  (generate-valid-G-string))

(defun generate-valid-string (non-terminal current-string length-so-far max-length)
  (declare (ignore current-string length-so-far max-length))
  (cond
    ((eq non-terminal 'I) ; I -> iES
     (concatenate 'string "i" (generate-valid-E-string) (generate-valid-string 'S "" 0 0) ""))
    ((eq non-terminal 'S) ; S -> s
     "s")
    (t "")))


(defun generate-test-strings ()
  (list
    (concatenate 'string "i" (generate-valid-G-string) "o" (generate-valid-G-string) "s")
    (concatenate 'string "i" (generate-valid-G-string) "o" (generate-valid-G-string) "s")
    (concatenate 'string "i" (generate-valid-G-string) "o" (generate-valid-G-string) "s")
    (concatenate 'string "i" (generate-valid-G-string) "o" (generate-valid-G-string) "s")
    (concatenate 'string "i" (generate-valid-G-string) "o" (generate-valid-G-string) "s")
    (concatenate 'string "i" (generate-valid-G-string) "o" (generate-valid-G-string) "s")
    (concatenate 'string "i" (generate-valid-G-string) "o" (generate-valid-G-string) "s") 
    ))


(defun perturb-string (valid-string)
  (if (string= valid-string "")
      "x"
      (let* ((len (length valid-string))
             (pos (random len))
             (perturbed-string (copy-seq valid-string))
             (operation (random 3)))
        (case operation
          (0
           (let ((insert-char (nth (random 9) '(#\i #\e #\o #\x #\y #\z #\w #\s #\d #\b))))
             (setf perturbed-string (concatenate 'string (subseq perturbed-string 0 pos) (string insert-char) (subseq perturbed-string pos)))))
          (1
           (if (> len 1)
               (setf perturbed-string (concatenate 'string (subseq perturbed-string 0 pos) (subseq perturbed-string (1+ pos))))
               (setf perturbed-string "x")))
          (2
           (let ((replace-char (nth (random 9) '(#\b #\e #\o #\a #\p #\q #\r #\t #\u))))
             (setf (char perturbed-string pos) replace-char))))
        perturbed-string)))


(defun generate-invalid-strings (valid-strings)
  (mapcar #'perturb-string valid-strings))


(defun test-parser (input-string)
  (let ((*input-stream* (make-string-input-stream input-string)))
    (if (parse-I)
        (if (peek-next-char) ; Check for remaining input
            nil             ; Fail if there's remaining input
            t)              ; Success if parsed and no remaining input
        nil)))             ; Fail if parse-I failed


(defun run-tests ()
  (let* ((valid-strings (generate-test-strings))
         (invalid-strings (generate-invalid-strings valid-strings)))
    (format t "~%Valid Strings:~%")
    (loop for str in valid-strings do
          (let ((parse-result (test-parser str)))  ; Get raw boolean result
            (format t "String: ~A, Expected: Valid, Result: ~A~%"
                    str
                    (if parse-result "Valid" "Invalid")))) ; Use IF for correct "Valid"/"Invalid" string

    (format t "~%Invalid Strings (Perturbed from Valid):~%")
    (loop for str in invalid-strings do
          (format t "String: ~A, Expected: Invalid, Result: ~A~%" str (if (test-parser str) "Valid" "Invalid")))))

; (trace parse-I parse-E parse-F parse-G parse-S match-terminal consume-char peek-next-char)
(run-tests)
(untrace)
(quit)