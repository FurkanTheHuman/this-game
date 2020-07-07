
(in-package :this-game.db)

(defparameter *default-db* (list))

;; MAJOR PROBLEM
;; TO USE SETF ON DATA OBJECTS YOU CAN ONLY USE CAR VARIANTS
;; SO GET-* FUNCTIONS CAN'T WORK
;; THEY NEED TO BE MACROS



;; desired syntax


;; (query :select name :from monsters
;;        :where (lambda (name) (eql name 'dragon) ))

;; (get-last-3 (query :db *new* :select * :from timeline))

;; (query :create monsters :with '(name type effect))

;; (query :from mosters :insert '(name type effect) )
;; (query :delete mosters)
;; (query :delete mosters :where (lambda (name) (eql name 'dragon) ))
;; CRITICAL KEYWORDS
;; :select :from :where :create :insert :delete

;; ALL complete!!!
;; next steps
;; FIX: where should return lines. and there should be ready
;; functions where I can specify cols like (col 'name)
;; A printer can be nice
;; fix delete 


(defun get-structure (table)
  (caar (cdr table)))

(defun get-name (table)
  (car table))

(defun get-contents (table)
  (cddr table))

;; NOTE: turns out setf and setq are macros and have problems with
;; furnction args
(defun get-table (table-name)
  (find-if (lambda (this)
             (if (eql (get-name this) table-name) t nil)) *default-db* ) )

(defun get-table1 (table-name)
  (let ((counter 0))
    (find-if (lambda (this)
               (progn (incf counter) (if (eql (get-name this) table-name) t nil))) *default-db* )
    (- counter 1)) )
;; (setf (cddr (nth 2 *default-db*)) (append (cddr (nth 2 *default-db*)) '((a b c))))


(defun select (table request)
  (if (eql request '*) (get-contents table)
   (let ((position* (position request (get-structure table))))
     (mapcar (lambda (el) (nth position* el)) (get-contents table)))))

(defun apply-filter (data rule)
  (if rule 
      (remove-if-not rule data)
      data))



(defun verify-name (name)
  (let ((verify t))
    (progn (dolist (i *default-db*)
             (when (eql (get-name i) name) (setf verify nil )))
           verify))
  )

(defun verify-structure (table data)
  (print (get-structure table))
  (print  data)
  (if (eql (list-length (get-structure table)) (list-length data))
      t nil))


(defun create-table (name structure )
  (if (verify-name name)
      (cons (cons name (cons  (list structure) (list) )) *default-db*)
      (progn (print "error table already exists")
             *default-db*))
  
  )

(defun add-to (table data)
  (if (verify-structure table data)
      (let ((pos (get-table1 (get-name table))))
        (setf (cddr (nth pos *default-db*)) (append (cddr (nth pos *default-db*)) `(,data))))
      (print "err: STRUCTURE IS NOT VALID")))

(defun delete-entry (table filter)
  (if (verify-name (get-name table))
      (print "NO TABLE FOUND")
      (let ((pos (get-table1 (get-name table))))
        (setf (cddr (nth pos *default-db*)) (remove-if-not filter (get-contents table)))))
  )

(defun delete-table (del)
  (setf *default-db*  (remove-if (lambda (el) (eql (get-name el) del)) *default-db*)))


(defun query (&key 
                ((:select request) nil)
                   ((:from table) nil)
                   ((:where filter) nil)
                   ((:insert column) nil)
                   ((:delete del) nil)
                   ((:create table-name) nil)
                   ((:with structure) nil))
  (cond ((and request table)
         (let ((table* (get-table table))) ;; SELECT
           (apply-filter (select table* request) filter)))
        ((and table-name structure) ;; CREATE
         (setq *default-db* (create-table table-name structure)))
        ((and column table) ;; INSERT
         (add-to (get-table table) column))
        ((and del filter) ;; DELETE
          (delete-entry (get-table del ) filter))
        (del ;; DELETE
         (delete-table del))))
  


;; test setup


;;(query :create 'test :with '(name type effect))
;;(query :from 'test :insert '(drago hello world ))
;;(query :from 'test :insert '(mrago hello world ))

;;(query :create 'test1 :with '(name type effect))


