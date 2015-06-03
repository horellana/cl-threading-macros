#|
  This file is a part of threading-macros project.
  Copyright (c) 2014 Hector Orellana (hofm92@gmail.com)
|#

#|
  Author: Hector Orellana (hofm92@gmail.com)
|#

(in-package :cl-user)
(defpackage threading-macros-asd
  (:use :cl :asdf))
(in-package :threading-macros-asd)

(defsystem threading-macros
  :version "0.1"
  :author "Hector Orellana"
  :license "GPL3"
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "threading-macros"))))
  :description ""
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.markdown"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (test-op threading-macros-test))))
