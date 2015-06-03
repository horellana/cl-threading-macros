(in-package :cl-user)
(defpackage threading-macros
  (:use :cl)
	(:export :->>)
	(:export :->))
(in-package :threading-macros)

(defmacro define-threading-macro (name action)
	(let ((transformations (gensym))
				(value (gensym)))
		`(defmacro ,name (,value &rest ,transformations)
			 (reduce #'(lambda (a b) ,action)
							 ,transformations
							 :initial-value ,value))))

(define-threading-macro ->>
		`(,@b ,a))

(define-threading-macro ->
		`(,(car b) ,a ,@(cdr b)))

;; blah blah blah.
