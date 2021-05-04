;;;; Generate histograms for documentation's purposes
(asdf:load-systems "histogram" "gamma-dev")

(let ((vals (make-array 1000000))
      (generator)
      (hist)
      (hist-file-root
        (format nil "~A"
                (asdf:system-relative-pathname "gamma-dev" "doc/gamma-")))
      (hist-file))
  (loop for alpha in '(1 2 3 5 9 7.5 0.5)
        for beta in '(2 2 2 1 0.5 1 1) do
          (setf generator (gamma-dev:make-gamma-gen alpha beta))
          (loop for i from 0 below (length vals) do
            (setf (aref vals i) (gamma-dev:draw generator)))
          (setf hist (histogram:make-hist '(0 20) 1000 :data vals)
                hist-file
                (concatenate 'string hist-file-root (write-to-string alpha)
                             "-" (write-to-string beta) ".txt"))
          (histogram:tofile hist hist-file)))
