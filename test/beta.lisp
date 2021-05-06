(defpackage beta-dev/test (:use :cl :rove))
(in-package :beta-dev/test)

(deftest beta
  (let ((generator) (alpha 1) (beta 2))
    (testing "Instantiation"
      (setf generator (beta-dev:make-beta-gen alpha beta)) (pass "ok"))
    (testing "Reading parameters back"
      (ok (and (= alpha (beta-dev:alpha generator))
               (= beta (beta-dev:beta generator))) "ok"))
    (testing "Drawing without error."
      (dotimes (it 10) (beta-dev:draw generator))
      (pass "ok"))))

(deftest performance
  (testing "Beta: Drawing 1M numbers."
    (let ((generator (beta-dev:make-beta-gen 1 2)))
      (time (dotimes (it 1000000 t) (beta-dev:draw generator))))))
