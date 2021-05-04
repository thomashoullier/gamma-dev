;;;; Rove test suite for gamma-dev

(defpackage gamma-dev/test (:use :cl :rove))

(in-package :gamma-dev/test)

(deftest general-gamma
  (let ((generator) (a 1) (b 2))
    (testing "Instantiation"
      (setf generator (gamma-dev:make-gamma-gen a b)) (pass "OK"))
    (testing "Reading parameters back"
      (ok (and (= a (gamma-dev:a generator))
               (= b (gamma-dev:b generator))) "ok"))
    (testing "Drawing without error."
      (dotimes (it 10) (gamma-dev:draw generator))
      (pass "ok"))))

(deftest performance
  (testing "General gamma: Drawing 1M numbers."
    (let ((generator (gamma-dev:make-gamma-gen 1 2)))
      (time (dotimes (it 1000000 t) (gamma-dev:draw generator))))))
