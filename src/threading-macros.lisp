(in-package :cl-user)
(defpackage threading-macros
  (:use :cl)
  (:export :->)
  (:export :->>)
  (:export :-<>))
(in-package :threading-macros)

(defun deep-search (thing list)
  (cond
    ((null list) nil)
    ((listp (car list)) (or (deep-search thing (car list))
			    (deep-search thing (cdr list))))
    ((equal (car list) thing) t)
    (t (deep-search thing (cdr list)))))

(defmacro -<> (value &body transformations)
  (let ((<> (intern "<>")))
    (if transformations
	`(let ((,<> ,value))
	   ,(if (deep-search <> (car transformations))
		`(-<> ,(car transformations) ,@(cdr transformations))
		`(-<> (,@(car transformations) ,<>) ,@(cdr transformations))))
	value)))

(defmacro -> (value &body transformations)
  (let ((<> (intern "<>")))
    `(-<> ,value
       ,@(mapcar #'(lambda (trans) `(,(car trans) ,<> ,@(cdr trans)))
		 transformations))))

(defmacro ->> (value &body transformations)
  (let ((<> (intern "<>")))
    `(-<> ,value
       ,@(mapcar #'(lambda (trans) (append trans (list <>)))
		 transformations))))
