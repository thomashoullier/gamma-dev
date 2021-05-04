(defsystem gamma-dev
  :name "gamma-dev"
  :author "Thomas HOULLIER"
  :components
  ((:module "src"
    :components ((:file "package")
                 (:file "precomp-params" :depends-on ("package"))
                 (:file "gamma-dev" :depends-on ("package"
                                                 "precomp-params")))))
  :in-order-to ((test-op (test-op "gamma-dev/test"))))

(defsystem gamma-dev/test
  :name "gamma-dev/test"
  :depends-on ("rove" "gamma-dev")
  :components
  ((:module "test"
    :components ((:file "rove-suite"))))
  :perform (test-op (o c) (symbol-call :rove '#:run c)))
