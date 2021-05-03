(defsystem gamma-dev
  :name "gamma-dev"
  :author "Thomas HOULLIER"
  :components
  ((:module "src"
    :components ((:file "package")
                 (:file "precomp-params" :depends-on ("package"))
                 (:file "gamma-dev" :depends-on ("package"
                                                 "precomp-params"))))))
