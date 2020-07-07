;;;; this-game.lisp

(in-package #:this-game)

;;; THIS GAME

;; Game loop needs to be designed. 
;; a loop that jumps between states and when in jump raises event
;; Of course there should be pre defined knowledge, Maybe in another file
;; Monsters especialy. But their design requires prior knowledge of
;; db and event system. Or not they can be loosly dependent
;; loop might handle it. 
;; Maybe first of all I should design the loop for sommething else
;; 

;; testing
(defparameter *agent-position* (cons 0 0))


(setf (fdefinition 'query) #'db:query)
(setf (fdefinition 'link) #'event:subscribe-to-event) 



(db:query :create 'deneme :with '(one two three))
(db:query :from 'deneme :insert '(1 2 3))
(event:add-event 'test)


