;;;; this-game.asd

(asdf:defsystem #:this-game
  :description "Describe this-game here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :components ((:file "package")
               (:file "db")
               (:file "event")
               (:file "this-game" :depends-on ("db" "event"))))
