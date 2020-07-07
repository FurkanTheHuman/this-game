;;;; package.lisp



(defpackage #:this-game.db
  (:nicknames :db)
  (:use #:cl )
  (:export :query))


(defpackage #:this-game.event
  (:nicknames :event)
  (:use #:cl )
  (:export
   #:subscribe-to-event
   #:make-action
   #:raise-event
   #:add-event))



(defpackage #:this-game
  (:use #:cl #:this-game.db #:this-game.event))
