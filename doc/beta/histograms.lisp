(asdf:load-systems "histogram" "gamma-dev")

(let ((vals (make-array 1000000))
      (generator)
      (hist)
      (hist-file-root
        (format nil "~A"
                (asdf:system-relative-pathname "gamma-dev" "doc/beta/beta-")))
      (hist-file))
  (loop for alpha in '(0.5 5 1 2 2)
        for beta in '(0.5 1 3 2 5) do
          (setf generator (beta-dev:make-beta-gen alpha beta))
          (loop for i from 0 below (length vals) do
            (setf (aref vals i) (beta-dev:draw generator)))
          (setf hist (histogram:make-hist '(0 1) 1000 :data vals)
                hist-file
                (concatenate 'string hist-file-root (write-to-string alpha)
                             "-" (write-to-string beta) ".txt"))
          (histogram:tofile hist hist-file)))
