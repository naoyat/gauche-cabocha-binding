;;;
;;; cabocha wrapper
;;;
;;;  2009.3.22 by naoya_t
;;;

(use srfi-1)
(use cabocha)

;;; lib
(define (vector-range vec from size)
  (let1 vec* (make-vector size)
	(dotimes (i size)
	  (vector-set! vec* i (vector-ref vec (+ from i))))
	vec*))

;;; cabocha token/chunk -> sexp
(define (cabocha-token->sexp tok)
  `(cabocha-token ,(cabocha-token-normalized-surface tok)
				  ,(cabocha-token-feature-list tok)
				  ))

(define (token-surface token) (second token))
(define (token-feature token) (third token))

(define (cabocha-chunk->sexp i ch tokens)
  (let* ([token-pos (cabocha-chunk-token-pos ch)]
		 [token-size (cabocha-chunk-token-size ch)]
		 [tokens-in-chunk (vector-range tokens token-pos token-size)]
		 [token-head-pos (cabocha-chunk-head-pos ch)]
		 [token-func-pos (cabocha-chunk-func-pos ch)])
	`(cabocha-chunk ,i
					,(cabocha-chunk-link ch)
					,tokens-in-chunk
					,token-head-pos
					,token-func-pos
					,(cabocha-chunk-score ch)
					)))

#|
(define (cabocha-tree-chunk-list t)
  (let loop ([i (- (cabocha-tree-chunk-size t) 1)] [lis '()])
	(if (< i 0) lis
		(loop (- i 1)
			  (cons (cabocha-chunk->sexp i (cabocha-tree-chunk t i)) lis) ))))

(define (cabocha-tree-token-list t)
  (let loop ([i (- (cabocha-tree-token-size t) 1)] [lis '()])
	(if (< i 0) lis
		(loop (- i 1)
			  (cons (cabocha-token->sexp (cabocha-tree-token t i)) lis) ))))
|#

(define (cabocha-tree-chunks t) ;vec
  (let* ([tokens (cabocha-tree-tokens t)]
		 [chunk-size (cabocha-tree-chunk-size t)]
		 [vec (make-vector chunk-size)])
	(dotimes (i chunk-size)
	  (vector-set! vec i (cabocha-chunk->sexp i (cabocha-tree-chunk t i) tokens) ))
	vec))
(define (cabocha-tree-chunk-list t) ;list
  (let ([tokens (cabocha-tree-tokens t)]
		[chunk-size (cabocha-tree-chunk-size t)])
	(map (lambda (i) (cabocha-chunk->sexp i (cabocha-tree-chunk t i) tokens))
		 (iota chunk-size))))

(define (cabocha-tree-tokens t)
  (let* ([token-size (cabocha-tree-token-size t)]
		 [vec (make-vector token-size)])
	(dotimes (i token-size)
	  (vector-set! vec i (cabocha-token->sexp (cabocha-tree-token t i)) ))
	vec))
(define (cabocha-tree-token-list t)
  (let1 token-size (cabocha-tree-token-size t)
	(map (lambda (i) (cabocha-token->sexp (cabocha-tree-token t i)))
		 (iota token-size))))
