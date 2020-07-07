;;;; this-game.lisp

(in-package #:this-game)

;;; THIS GAME


;; testing
(defparameter *agent-position* (cons 0 0))


(setf (fdefinition 'query) #'db:query)
(setf (fdefinition 'link) #'event:subscribe-to-event) 



(db:query :create 'deneme :with '(one two three))
(db:query :from 'deneme :insert '(1 2 3))
(event:add-event 'test)


