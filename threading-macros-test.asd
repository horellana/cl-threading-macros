#|
  This file is a part of threading-macros project.
  Copyright (c) 2014 Hector Orellana (hofm92@gmail.com)
|#

(in-package :cl-user)
(defpackage threading-macros-test-asd
  (:use :cl :asdf))
(in-package :threading-macros-test-asd)

(defsystem threading-macros-test
  :author "Hector Orellana"
  :license "GPL3"
  :depends-on (:threading-macros
               :prove)
  :components ((:module "t"
                :components
                ((:test-file "threading-macros"))))

  :defsystem-depends-on (:prove-asdf)
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run-test-system) :prove-asdf) c)
                    (asdf:clear-system c)))
