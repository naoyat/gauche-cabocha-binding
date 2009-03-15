;;;
;;; Test cabocha
;;;
;;;  2009.3.15 by naoya_t
;;;

(use gauche.test)

(test-start "cabocha")
(use cabocha)
(test-module 'cabocha)

(test-section "cabocha-new")
(let1 c (cabocha-new)
  (test* "cabocha?" #t (cabocha? c))

  (test-section "cabocha-destroy")
  (test* "cabocha-destroyed?" #f (cabocha-destroyed? c))
  (cabocha-destroy c)
  (test* "cabocha?" #t (cabocha? c))
  (test* "cabocha-destroyed?" #t (cabocha-destroyed? c))
  )

(test-section "cabocha-new2")
(let1 c (cabocha-new2 "")
  (test* "cabocha?" #t (cabocha? c))
  (test* "cabocha-destroyed?" #f (cabocha-destroyed? c))
  (cabocha-destroy c)
  (test* "cabocha?" #t (cabocha? c))
  (test* "cabocha-destroyed?" #t (cabocha-destroyed? c))
  )

(let ([c (cabocha-new)]
	  [text "太郎は次郎が持っている本を花子に渡した。"])
  (test-section "cabocha-sparse-tostr")
  (test* "cabocha-sparse-tostr"
		 "<PERSON>太郎</PERSON>は---------D\n  <PERSON>次郎</PERSON>が-D     |\n                 持っている-D   |\n                         本を---D\n                         花子に-D\n                         渡した。\nEOS\n"
		 (cabocha-sparse-tostr c text))

  (test-section "cabocha-sparse-tostr2")
  (test* "cabocha-sparse-tostr2"
		 "<PERSON>太郎</PERSON>は\nEOS\n"
		 (cabocha-sparse-tostr2 c text 9))

  (test-section "cabocha-strerror")
  (test* "cabocha-strerror" "" (cabocha-strerror c))

  (cabocha-destroy c))

;; epilogue
(test-end)





