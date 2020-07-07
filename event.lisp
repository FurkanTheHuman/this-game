
(in-package :this-game.event)


(defparameter *events* ())
(defparameter *actions* (list))
(defparameter *timeline* (list))



(defun add-event (event)
  (if (eql (type-of event) 'symbol)
      (pushnew event *events*)
      (format t "error - not an acceptable event (~a) ~%" event)))

(defun make-action (name func)
  (cons name func))

(defun get-action-name (action)
  (print action)
  (car action))

(defun verify-action-name (action &optional actions)
  (if (not actions)
      (if (eql (get-action-name (car actions))   (get-action-name action))
        nil
       (verify-action-name action (cdr actions)))
   t
   )
  
  )


(defun add-action (event action)
  (print action)
  (if (verify-action-name action *actions*)
      (setf *actions* (push (cons event action) *actions*) )
      *actions*))


(defun action-name (action)
  (car action)) 
(defun action-func (action)
  (cdr action))

(defun prdebug (value)
  (print value)
  value)

;; CLEAN
;;if something go between still works
(defun subscribe-compound-event (action &rest events)
  (let ((is-chain-valid nil))
    (dolist (i events)
      (subscribe-to-event i
           (make-action (action-name action)
                        (lambda ()
                          (cond ((eql i (car events)) (setf is-chain-valid 0))
                                ((and is-chain-valid
                                      (eql (position i events) (+ 1 is-chain-valid)) (incf is-chain-valid)))
                                ((and is-chain-valid (eql (list-length events) (+ is-chain-valid 1)))
                                 (funcall (action-func action)))
                                (t (setf is-chain-valid nil)))
                          (when (and is-chain-valid (eql (list-length events) (+ is-chain-valid 1)))
                            (funcall (action-func action)))
                          ))))))




(defun subscribe-to-event (event action)
  (if (member event *events* )
      (add-action event action)
      (format t "error - not an event ~a ~%" event)
      ))







;; TODO: why there is an event parameter here??
(defun unsubscribe-to-event (event name)
  (if (member event *events* )
      (setq  *actions* (remove-if (lambda (el)
                          (if (eql (action-name el) name)
                              t
                              nil))
                                  *actions*))
      (format t "error - not an event (~a) ~%" event)))


(defun add-timeline (event)
  (push event *timeline*))



(defun raise-event (event)
  (add-timeline event )
  (if (member event *events*)
      (mapcar (lambda (action)
                (when (eql event (car action))
                  (progn (funcall (cddr action))
                         (action-name action))))
              *actions*)
      (prin1 "error - not an acceptable event")))


