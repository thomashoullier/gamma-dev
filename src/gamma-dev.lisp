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

;;; General gamma generator.
(defclass gamma-gen ()
  ((precomp-params :documentation "Precomputed parameters."
                   :reader precomp-params :initarg :precomp-params)
   (a :documentation "Shape parameter."
      :reader a :initarg :a)
   (b :documentation "Scale parameter."
      :reader b :initarg :b)))

(defun make-gamma-gen (a b)
  "Instantiate a gamma-gen object with:
   * a: shape parameter
   * b: scale parameter"
  (let* ((n (precomp-n a))
         (b1 (precomp-b1 a n)) (b2 (precomp-b2 a n))
         (c1 (precomp-c1 a b1)) (c2 (precomp-c2 b2))
         (precomp-param (make-precomp :n n :b1 b1 :b2 b2 :c1 c1 :c2 c2)))
    (make-instance 'gamma-gen
                   :precomp-params precomp-params
                   :a a :b b)))

(defmethod draw ((gamma-gen gamma-gen))
  "Draw a pseudorandom number using the gamma generator."
  (with-slots ((precomp-params precomp-params)
               (a a) (b b)) gamma-gen
    (let ((w1 0d0) (w2 0d0) (y 0d0) (x 0d0))
      (loop do (multiple-value-setq (y w2 w1) (draw-step precomp-params))
            until (and (>= y 0d0)
                       (>= (log y)
                           (setf x (* (pcp-n precomp-params) (- w2 w1))))))
      (* b (exp x)))))

(defun draw-step (precomp-params)
  "Redraw uniform numbers for accept/reject step."
  (let ((mu1 (random 1d0)) (mu2 (random 1d0))
        (w1 0d0) (w2 0d0) (y 0d0) (x 0d0))
    (psetf w1 (+ (pcp-c1 precomp-params) (log mu1))
           w2 (+ (pcp-c2 precomp-params) (log mu2)))
    (setf y (* (pcp-n precomp-params)
               (- (* (pcp-b1 precomp-params) w2)
                  (* (pcp-b2 precomp-params) w1))))
    (values y w2 w1)))
