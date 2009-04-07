;;;
;;; Test cabocha
;;;
;;;  2009.3.15 by naoya_t
;;;

(use gauche.test)
(use srfi-1)

(test-start "cabocha")
(use cabocha)
(test-module 'cabocha)

(define c (cabocha-new))
(test* "cabocha?" #t (cabocha? c))
;(test* "cabocha-destroyed?" #f (cabocha-destroyed? c))
;;

(define (cabocha-chunk-desc ch)
  (format "link:~d head:~d func:~d token-size:~d token-pos:~d score:~d feature:~a"
		  (cabocha-chunk-link ch)
		  (cabocha-chunk-head-pos ch)
		  (cabocha-chunk-func-pos ch)
		  (cabocha-chunk-token-size ch)
		  (cabocha-chunk-token-pos ch)
		  (cabocha-chunk-score ch)
		  (cabocha-chunk-feature-list ch)
;		  (cabocha-chunk-feature-list-size ch)
		  ))

(define (cabocha-token-desc tok)
  (format "surface:~a (~a) feature:~a feature-list:~a ne:~a chunk:~a"
		  (cabocha-token-surface tok)
		  (cabocha-token-normalized-surface tok)
		  (cabocha-token-feature tok)
		  (cabocha-token-feature-list tok)
;		  (cabocha-token-feature-list-size tok)
		  (cabocha-token-ne tok)
;		  (cabocha-chunk-desc (cabocha-token-chunk tok))
		  (cabocha-token-chunk tok)
		  ))
(define (cabocha-token->lisp tok)
  `(token ;(format "surface:~a (~a) feature:~a feature-list:~a ne:~a chunk:~a"
;	( ,(cabocha-token-surface tok) . ,(cabocha-token-normalized-surface tok) )
	,(cabocha-token-normalized-surface tok)
	;(cabocha-token-feature tok)
	,(cabocha-token-feature-list tok)
;		  (cabocha-token-feature-list-size tok)
	;(cabocha-token-ne tok)
;		  (cabocha-chunk-desc (cabocha-token-chunk tok))
	;(cabocha-token-chunk tok)
	))

(define (vector-range vec from size)
  (let1 vec* (make-vector size)
	(dotimes (i size)
	  (vector-set! vec* i (vector-ref vec (+ from i))))
	vec*))

(define (cabocha-chunk->lisp i ch tokens)
  (let* ([token-pos (cabocha-chunk-token-pos ch)]
		 [token-size (cabocha-chunk-token-size ch)]
		 [tokens-in-chunk (vector-range tokens token-pos token-size)]
		 [token-head-pos (cabocha-chunk-head-pos ch)]
		 [token-func-pos (cabocha-chunk-func-pos ch)]
		)
	`(chunk ;(format "link:~d head:~d func:~d token-size:~d token-pos:~d score:~d feature:~a"
	  ,i
	  ,(cabocha-chunk-link ch)
;	  ,(map token-surface (vector->list tokens-in-chunk))
;	  (head ,(token-surface (vector-ref tokens-in-chunk token-head-pos)))
;	  (func ,(token-surface (vector-ref tokens-in-chunk token-func-pos)))
	  ,tokens-in-chunk
	  ,token-head-pos
	  ,token-func-pos
;	  ,token-size
;	  ,token-pos
	  ,(cabocha-chunk-score ch)
;	  ,(cabocha-chunk-feature-list ch)
;		  (cabocha-chunk-feature-list-size ch)
	  )))
(define (pp-chunk chunk)
;  (print " % " chunk)
  (let1 tokens-in-chunk (fourth chunk)
	(format #t "~d) => ~d ~a // head=~a func=~a score:~a\n"
			(second chunk)
			(third chunk)
			(map token-surface (vector->list tokens-in-chunk))
			(token-surface (vector-ref tokens-in-chunk (fifth chunk)))
			(token-surface (vector-ref tokens-in-chunk (sixth chunk)))
			(seventh chunk) )))

(define (token-surface token) (cadr token))

#|
(define (cabocha-tree-chunk-list t)
  (let loop ([i (- (cabocha-tree-chunk-size t) 1)] [lis '()])
	(if (< i 0) lis
		(loop (- i 1)
			  (cons (cabocha-chunk->lisp i (cabocha-tree-chunk t i)) lis) ))))

(define (cabocha-tree-token-list t)
  (let loop ([i (- (cabocha-tree-token-size t) 1)] [lis '()])
	(if (< i 0) lis
		(loop (- i 1)
			  (cons (cabocha-token->lisp (cabocha-tree-token t i)) lis) ))))
|#

(define (cabocha-tree-chunks t)
  (let* ([tokens (cabocha-tree-tokens t)]
		 [chunk-size (cabocha-tree-chunk-size t)]
		 [vec (make-vector chunk-size)])
	(dotimes (i chunk-size)
	  (vector-set! vec i (cabocha-chunk->lisp i (cabocha-tree-chunk t i) tokens) ))
	vec))

(define (cabocha-tree-tokens t)
  (let* ([token-size (cabocha-tree-token-size t)]
		 [vec (make-vector token-size)])
	(dotimes (i token-size)
	  (vector-set! vec i (cabocha-token->lisp (cabocha-tree-token t i)) ))
	vec))

(define (cparse sentence)
  (let* ([s (string-append sentence "。")]
		 [tree (cabocha-sparse-totree c s)]
		 )
	(format #t "\n「~a」\n" s)

;	(cabocha-tree-dump tree)
	(let* ([token-size (cabocha-tree-token-size tree)]
		   [chunk-size (cabocha-tree-chunk-size tree)]
		   [chunks (cabocha-tree-chunks tree)]
		   )
	  (format #t "token size: ~d, " token-size)
	  (format #t "chunk size: ~d\n" chunk-size)
	  (dotimes (i chunk-size)
		(pp-chunk (vector-ref chunks i)))
	  )))
										;				(format #t " - ~s\n" (cabocha-tree-sentence tree))
										;			  (display (cabocha-sparse-tostr c s)))

(load "sentences.scm")
(for-each cparse sentences)

;;
(cabocha-destroy c)
;(test* "cabocha-destroyed?" #t (cabocha-destroyed? c))
(test-end)
