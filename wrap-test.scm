(require "./wrap")

;(use gauche.test)
;(test-start "cabocha")
;(test-module 'cabocha)

(define c (cabocha-new))
;(test* "cabocha?" #t (cabocha? c))

(define (pp-chunk chunk)
  (let1 tokens-in-chunk (fourth chunk)
;	(format #t "~d) => ~d ~a // head=~a func=~a score:~a\n"
;	(format #t "~a // head=~a func=~a score:~a\n"
	(format #t "~a // head=~a func=~a\n"
;			(second chunk)
;			(third chunk)
			(map token-surface (vector->list tokens-in-chunk))
			(token-surface (vector-ref tokens-in-chunk (fifth chunk)))
			(token-surface (vector-ref tokens-in-chunk (sixth chunk)))
;			(seventh chunk)
			)))

(define (cparse sentence)
  (let* ([s (string-append sentence "。")]
		 [tree (cabocha-sparse-totree c s)]
		 )
	(format #t "\n「~a」\n" s)
	(let* ([token-size (cabocha-tree-token-size tree)]
		   [chunk-size (cabocha-tree-chunk-size tree)]
		   [chunk-list (cabocha-tree-chunk-list tree)])
	  (format #t "token size: ~d, " token-size)
	  (format #t "chunk size: ~d\n" chunk-size)
;	  (for-each pp-chunk chunk-list)
;	  (print "-")
	  (let1 terminal-chunk (find (lambda (c) (= -1 (third c))) chunk-list)
		;(pp-chunk terminal-chunk)
		(let loop ((level 0) (chunk terminal-chunk))
		  (dotimes (i level) (display ": ")) (display "+- ")
		  (pp-chunk chunk)
		  (let1 link-from (filter (lambda (c) (= (second chunk) (third c))) chunk-list)
			;(map pp-chunk link-from)
			(map (cut loop (+ level 1) <>) link-from))
;		  (dotimes (i level) (display ": ")) (newline)
		  ))
	  )))

;(load "sentences.scm")
;(for-each cparse sentences)
(load "sentences.scm")
(for-each cparse sentences)

(cabocha-destroy c)
;(test-end)
