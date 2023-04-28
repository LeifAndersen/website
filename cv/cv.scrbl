#lang scribble/text

@(require racket/dict
          racket/list
          racket/format
          racket/match
          scribble/core
          scribble/latex-properties
          racket/runtime-path
          racket/cmdline
          racket/hash
          (prefix-in cv: "../cv.sml"))

@(define private-extras (make-parameter #f))

@(command-line
  #:once-each
  [("-p") priv "Additional private data" (private-extras priv)]
  #:args ()
  (void))

@(define main-doc (cv:doc (lambda (data) (dict-ref data 'name))))
@(define doc
   (if (private-extras)
       (let ([private-doc (dynamic-require (private-extras) 'doc)])
         (hash-union main-doc private-doc
                     #:combine (lambda (a b) b)))
       main-doc))

@(define translations-table
   (hash #\& "\\&"))
@(define no-newline-table
   (hash-set translations-table #\newline "%\n"))

@(define (latex-str #:table [table translations-table]
                    str)
   (apply string-append
          (for/list ([i (in-string str)])
            (dict-ref table i (λ () (string i))))))

@(define (-> #:table [trans-table translations-table] . path)
   (define-values (start path*)
     (if (and (pair? path) (dict? (car path)))
         (values (car path) (cdr path))
         (values doc path)))
   (let loop ([table start]
              [path path*])
     (cond [(and (null? path) (string? table)) (latex-str #:table trans-table table)]
           [(null? path) table]
           [(pair? (car path))
            (loop (dict-ref table (car (car path)) (cdr (car path)))
                  (cdr path))]
           [else
            (loop (dict-ref table (car path))
                  (cdr path))])))

@(define (disp-year year)
   (match year
     [`(,start ,end)
      @~a{@|start|-@|end|}]
     [_ year]))

\documentclass[10pt]{moderncv}
\moderncvstyle{banking}
\moderncvcolor{red}
\usepackage[scale=0.75]{geometry}

\name{@(-> 'name 'first)}{@(-> 'name 'last)}
\address{@(-> 'address 'street)}%
        {@(format "~a, ~a, ~a"
                  (-> 'address 'city) (-> 'address 'state) (-> 'address 'zip))}%
        {@(-> 'address 'country)}
\phone[@(-> 'phone 'type)]{@(-> 'phone 'number)}
\email{@(-> 'email)}
\homepage{@(-> 'website)}
\social[github]{@(-> 'github 'url)}
\social[twitter]{@(-> 'twitter 'url)}

\begin{document}
\makecvtitle
\section{Research Highlights}
@(-> 'research-statement)

\section{Education}
@(add-newlines
  (for/list ([i (in-list (dict-ref doc 'education))])
    @~a{\cventry{@(disp-year (-> i 'year))}@;
                {@(-> i 'location)}@;
                {@(-> i 'degree)}{}@;
                {@(if (-> i '(advisor . #f))
                      (format "Advisor: ~a" (-> i 'advisor))
                      "")}@;
                {}}))

\section{Publications}
@(add-newlines
  (for/list ([i (in-list (dict-ref doc 'papers))])
    @~a{\cventry{@(-> i 'year)}@;
                {@(-> i 'location 'venue)}@;
                {@(-> i 'title)}@;
                {}@;
                {}@;
                {\url{@(-> i 'url)}}
        \vspace{6pt}}))

\newpage

\section{Talks}
@(add-newlines
  (for/list ([i (in-list (dict-ref doc 'talks))])
    @~a{\cventry {@(-> i 'year)}@;
                 {@(-> i 'location)}@;
                 {@(-> i 'title)}@;
                 {}@;
                 {}@;
                 {\url{@(-> i 'url)}}}))

\section{Teaching}
@(add-newlines
  (for/list ([i (in-list (dict-ref doc 'teaching))])
    @~a{\cventry{@(if (-> i '(semester . #f))
                      @~a{@(-> i 'semester) @(-> i 'year)}
                      (-> i 'year))}@;
                {@(-> i 'location)}@;
                {@(-> i 'name)}@;
                {}@;
                {}@;
                {}}))
\section{Software}
@(add-newlines
  (for/list ([i (in-list (dict-ref doc 'software))])
    @~a{\cventry{}@;
                {\url{@(-> i 'url)}}@;
                {@(-> i 'name)}@;
                {}@;
                {}@;
                {@(-> i 'description)}
        \vspace{6pt}}))
\section{Service}
@(add-newlines
  (for/list ([i (in-list (dict-ref doc 'service))])
    @~a{\cventry {@(disp-year (-> i 'year))}@;
                 {@(-> i 'organization)}@;
                 {@(-> i 'title)}@;
                 {}@;
                 {}@;
                 {}}))
\end{document}
