(in-package :cl-user)
(defpackage threading-macros-test
  (:use :cl
        :threading-macros
	:prove))
(in-package :threading-macros-test)

;; NOTE: To run this test file, execute `(asdf:test-system :threading-macros)' in your Lisp.

(plan 2)

(is (-> 5 (+ 2) (+ 3) (+ 4))
    14)

(is (-<> 1 1+)
    (-<> 1 (1+ <>)))

(is (-<> 1 (+ 2) (+ 3))
    (-> 1 (+ 2) (+ 3)))

(is (-<> 5 (+ <> 1) (* 2 <>))
    12)

;; blah blah blah.

(finalize)
