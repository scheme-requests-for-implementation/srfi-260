#!r6rs
(library (srfi :XXX generate-symbol)
  (export generate-symbol)
  (import
    (rnrs)
    (rnrs mutable-strings))

  (define rp (open-file-input-port "/dev/random"))

  (define generate-symbol
    (case-lambda
      [()
       (do ([octets (get-bytevector-n rp 16)]
            [str (make-string 32)]
            [i 0 (fx+ i 1)]
            [j 0 (fx+ j 2)])
           ((fx=? i 16)
            (string->symbol (string-append "g:" str)))
         (let ([octet (bytevector-u8-ref octets i)])
           (let-values ([(high low) (fxdiv-and-mod octet 16)])
             (string-set! str j (nibble->digit high))
             (string-set! str (fx+ j 1) (nibble->digit low)))))]
      [(pretty-name)
       (assert (string? pretty-name))
       (generate-symbol)]))

  (define nibble->digit
    (lambda (x)
      (if (fx<? x 10)
          (integer->char (fx+ x (char->integer #\0)))
          (integer->char (fx+ x (fx- (char->integer #\a) 10)))))))
