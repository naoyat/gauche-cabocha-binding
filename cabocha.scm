;;;
;;; cabocha
;;;
;;;  2009.3.15 by naoya_t
;;;

(define-module cabocha
  (export <cabocha>
		  cabocha?
		  cabocha-new cabocha-new2
		  cabocha-destroy
		  cabocha-destroyed?

		  cabocha-sparse-tostr cabocha-sparse-tostr2
		  cabocha-strerror
          ))

(select-module cabocha)

;; Loads extension
(dynamic-load "cabocha")

;;
;; Put your Scheme definitions here
;;
(define-macro (cabocha? obj) `(is-a? ,obj <cabocha>))

(define-method write-object ((m <cabocha>) out)
  (format out "#<cabocha>"))

(define-reader-ctor '<cabocha>
  (lambda args (apply cabocha-new args)))


;; Epilogue
(provide "cabocha")


