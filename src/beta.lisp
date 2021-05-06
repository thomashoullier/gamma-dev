(defpackage beta-dev
  (:use :cl :gamma-dev)
  (:export #:alpha #:beta
           #:make-beta-gen
           #:draw))

(in-package :beta-dev)

(defclass beta-gen ()
  ((alpha-generator
    :documentation "Gamma generator with shape parameter alpha."
    :reader alpha-generator :initarg :alpha-generator)
   (beta-generator
    :documentation "Gamma generator with shape parameter beta."
    :reader beta-generator :initarg :beta-generator)
   (alpha :documentation "alpha shape parameter."
          :reader alpha :initarg :alpha)
   (beta :documentation "beta shape parameter."
         :reader beta :initarg :beta)))

(defun make-beta-gen (alpha beta)
  "Instantiate a beta-gen object with shape parameters alpha, beta."
  (let ((alpha-generator (make-gamma-gen alpha 1))
        (beta-generator (make-gamma-gen beta 1)))
    (make-instance 'beta-gen
                   :alpha alpha :beta beta
                   :alpha-generator alpha-generator
                   :beta-generator beta-generator)))

(defmethod draw ((beta-gen beta-gen))
  (with-slots ((alpha-generator alpha-generator)
               (beta-generator beta-generator)) beta-gen
    (let ((x (draw alpha-generator)) (y (draw beta-generator)))
      (/ x (+ x y)))))
