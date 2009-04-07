(define (split-by-maru text)
  (reverse! (cdr (reverse! (string-split text #\。)))))

(define sentences (append-map split-by-maru (list
"ここに何か適当な文章を入れてください。"
"そうすると良いことがあなたにあるかもしれません。"
)))
