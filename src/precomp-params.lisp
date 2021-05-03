(in-package :gamma-dev)

;;; Precomputed parameters
(defstruct (precomp-params (:conc-name pcp-))
  (n 0) (b1 0) (b2 0) (c1 0) (c2 0))

(defun precomp-n (a)
  (cond
    ((< a 0.4) (/ 1 a))
    ((< a 4.0) (+ (/ 1 a) (/ (* (/ 1 a) (- a 0.4)) 3.6)))
    (T (/ 1 (sqrt a)))))

(defun precomp-b1 (a n) (- a (/ 1 n)))

(defun precomp-b2 (a n) (+ a (/ 1 n)))

(defun precomp-c1 (a b1)
  (if (< a 0.4)
      0
      (/ (* b1 (1- (log b1))) 2)))

(defun precomp-c2 (b2) (/ (* b2 (1- (log b2))) 2))
