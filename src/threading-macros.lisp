(in-package :cl-user)
(defpackage threading-macros
  (:use :cl)
  (:import-from :alexandria
		:once-only)
  (:export :->)
  (:export :-<>))
(in-package :threading-macros)

(defun change-symbol (original new list)
  (cond
    ((null list) nil)
    ((listp (car list)) (cons (change-symbol original new (car list))
			      (change-symbol original new (cdr list))))
    (t (cons (if (eq (car list) original)
		 new
		 (car list))
	     (change-symbol original new (cdr list))))))

(defmacro -<> (value &body transformations)
  (once-only (value)
    (let ((s (intern "<>")))
      (if transformations
	  `(-<> ,(change-symbol s value (car transformations)) ,@(cdr transformations))
	  value))))

(defmacro -> (value &body transformations)
  (let ((s (intern "<>")))
    `(-<> ,value
       ,@(mapcar #'(lambda (trans) `(,(car trans) ,s ,@(cdr trans)))
		 transformations))))
