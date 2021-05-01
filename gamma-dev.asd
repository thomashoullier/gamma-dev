(defsystem gamma-dev
  :name "gamma-dev"
  :author "Thomas HOULLIER"
  :components
  ((:module "src"
    :components ((:file "package")
                 (:file "gamma-dev" :depends-on ("package"))))))
