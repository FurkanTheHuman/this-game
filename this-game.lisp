;;;; this-game.lisp

(in-package #:this-game)


(db:query :create 'deneme :with '(one two three))
(db:query :from 'deneme :insert '(1 2 3))
(event:add-event 'test)


(event:subscribe-to-event 'test
                          (event:make-action 'anan
                                             (lambda ()
                                               (print (db:query :select 'three :from 'deneme)) )))


