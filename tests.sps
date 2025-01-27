#!r6rs

;;; SPDX-FileCopyrightText: 2025 Marc Nieper-Wißkirchen
;;; SPDX-License-Identifier: MIT

(import
  (rnrs)
  (srfi :260 generate-symbol))

(assert (eqv? #t
          (let ([s (generate-symbol)])
                (symbol=? s s))))

(assert (eqv? #f
          (let ([s1 (generate-symbol)] [s2 (generate-symbol)])
            (symbol=? s1 s2))))

(assert (eqv? #f
          (let ([s1 (generate-symbol "g1")] [s2 (generate-symbol "g1")])
            (symbol=? s1 s2))))

(assert (eqv? #f
          (let ([s1 (generate-symbol "g1")] [s2 'g1])
            (symbol=? s1 s2))))

(assert (eqv? #f
          (let ([s (generate-symbol "g1")])
            (string=? (symbol->string s) "g1"))))

(assert (eqv? #t
          (let ([s (generate-symbol)])
            (symbol=? (string->symbol (symbol->string s)) s))))
