(in-package :cl-user)
(defpackage threading-macros-test
  (:use :cl
        :threading-macros
        :prove))
(in-package :threading-macros-test)

;; NOTE: To run this test file, execute `(asdf:test-system :threading-macros)' in your Lisp.

(plan 2)

(is-expand (->> 5 (+ 2) (+ 3) (+ 4)) 
					 (+ 4 (+ 3 (+ 2 5))))

(is-expand (-> 5 (+ 2) (+ 3) (+ 4))
					 (+ (+ (+ 5 2) 3) 4))

;; blah blah blah.

(finalize)
