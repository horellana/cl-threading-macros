(in-package :cl-user)
(defpackage threading-macros
  (:use :cl)
  (:import-from :alexandria
		:once-only)
  (:export :->)
  (:export :->>)
  (:export :-<>))
(in-package :threading-macros)

(defmacro -<> (value &body transformations)
  (once-only (value)
    (let ((s (intern "<>")))
      (if transformations
	  `(let ((,s ,value))
	     (-<> ,(car transformations) ,@(cdr transformations)))
	  value))))

(defmacro -> (value &body transformations)
  (let ((s (intern "<>")))
    `(-<> ,value
       ,@(mapcar #'(lambda (trans) `(,(car trans) ,s ,@(cdr trans)))
		 transformations))))

(defmacro ->> (value &body transformations)
  (let ((s (intern "<>")))
    `(-<> ,value
       ,@(mapcar #'(lambda (trans) (append trans (list s)))
		 transformations))))
