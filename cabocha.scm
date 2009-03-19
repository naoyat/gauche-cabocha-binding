;;;
;;; cabocha
;;;
;;;  2009.3.15 by naoya_t
;;;

(define-module cabocha
  (export <cabocha>
		  cabocha?
		  cabocha-do
		  cabocha-new cabocha-new2
		  cabocha-sparse-tostr cabocha-sparse-tostr2
		  cabocha-strerror
		  cabocha-destroy cabocha-destroyed?
		  cabocha-sparse-totree cabocha-sparse-totree2

		  cabocha-tree-new
		  cabocha-tree-destroy
		  cabocha-tree-empty
		  cabocha-tree-clear
		  cabocha-tree-clear-chunk
		  cabocha-tree-size
		  cabocha-tree-chunk-size
		  cabocha-tree-token-size
		  cabocha-tree-sentence
		  cabocha-tree-sentence-size
		  cabocha-tree-set-sentence
		  cabocha-tree-read
		  cabocha-tree-read-from-mecab-node
		  cabocha-tree-token
		  cabocha-tree-chunk
		  cabocha-tree-add-token
		  cabocha-tree-add-chunk
		  cabocha-tree-strdup
		  cabocha-tree-alloc
		  cabocha-tree-tostr
		  cabocha-tree-set-charset cabocha-tree-charset
		  cabocha-tree-set-posset cabocha-tree-posset
		  cabocha-tree-set-output-layer cabocha-tree-output-layer

		  cabocha-learn
		  cabocha-system-eval
		  cabocha-model-index

		  cabocha-chunk-link
		  cabocha-chunk-head-pos cabocha-chunk-func-pos
		  cabocha-chunk-token-size cabocha-chunk-token-pos
		  cabocha-chunk-score
		  cabocha-chunk-feature-list cabocha-chunk-feature-list-size

		  cabocha-token-surface
		  cabocha-token-normalized-surface
		  cabocha-token-feature
		  cabocha-token-feature-list
		  cabocha-token-feature-list-size
		  cabocha-token-ne
		  cabocha-token-chunk
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


