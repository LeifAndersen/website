#lang curly-fn scribble/text
@(require racket/dict
          racket/list
          racket/format
          racket/match
          scribble/core
          scribble/latex-properties
          racket/runtime-path
          racket/cmdline
          racket/hash
          gregor
          (prefix-in cv: "../cv.sml"))

@(define private-extras (make-parameter #f))
@(define cover-letter (make-parameter #f))
@(define cover-letter-first (make-parameter #f))
@(define signature (make-parameter #f))

@(define (cover-letter-text first?)
   (define c:doc (dynamic-require (cover-letter) 'doc))
   @list{
     @(if first? "" @list{\clearpage})
     \recipient{@(-> c:doc 'team)}@;
     {@(let ([x (-> c:doc '(organization . #f))])
         (if x @list{@|x|\\} ""))@;
      @(-> c:doc 'address 'street)\\@;
      @(-> c:doc 'address 'city), @;
      @(let ([x @(-> c:doc 'address '(state . #f))])
         (if x @list{@|x|, } ""))@;
      @(let ([x @(-> c:doc 'address '(zip . #f))])
         (if x @list{@|x|\\} ""))
      @(-> c:doc 'address 'country)}
    \date{@(~t (today) "d, MMMM y")}
    \opening{Hello,}
    \closing{Signed,@(when (signature)
      @~a{\\ \vspace{0.4cm}@;
        \includegraphics[width=4cm]{@(signature)}@;
        \vspace{-1cm}})}
    \enclosure[Attached]{curriculum vit\ae{}}
    \makelettertitle

    @(-> c:doc 'letter)

    \makeletterclosing
    @(if first? @list{\clearpage} "")
  })

@(command-line
  #:once-each
  [("-p" "--private") priv "Additional (optional) private data"
                      (private-extras priv)]
  [("-c" "--cover") cover "Optional cover letter" (cover-letter cover)]
  [("-f" "--cover-first") "Put cover letter at the start of document"
                          (cover-letter-first #t)]
  [("-s" "--signature") sig "Optional signature pdf" (signature sig)]
  #:args ()
  (void))

@(define main-doc (cv:doc (lambda (data) (dict-ref data 'name))))
@(define doc
   (if (private-extras)
       (let ([private-doc (dynamic-require (private-extras) 'doc)])
         (hash-union main-doc private-doc
                     #:combine (lambda (a b) (if (and (list? a) (list? b))
                                                 (append a b)
                                                 b))))
       main-doc))

@(define translations-table
   (hash #\& "\\&"
         #\# "\\#"
         #\$ "\\$"
         #\_ "\\_"
         #\% "\\%"))
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

@(define (final-year year)
   (match year
     [`(,start ,end) end]
     [_ year]))

@(define (sort-by-year items)
   (sort items > #:key #{final-year (dict-ref % 'year +inf.0)}))

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
\homepage{@(-> 'website 'name)}
\social[github]{@(-> 'github 'name)}
\social[twitter]{@(-> 'twitter 'name)}
\social[mastodon]{@(-> 'mastodon 'name)}
\social[linkedin][@(-> 'linkedin 'url)]{@(-> 'linkedin 'name)}

\begin{document}

@(when (and (cover-letter) (cover-letter-first))
   (cover-letter-text #t))

\makecvtitle
\section{Research Highlights}
@(-> 'research-statement)

@(if (-> '(additional-experience . #f))
     @list{\section{Previous Positions}
           @(add-newlines
             (for/list ([i (in-list (sort-by-year (-> 'previous-positions)))])
               @list{\cventry{@(disp-year (-> i 'year))}@;
                           {@(-> i 'location)}@;
                           {@(-> i 'role)}@;
                           {}@;
                           {}@;
                           {@(for/list ([i (in-list (-> i 'highlights))])
                               @list{\cvlistitem{@i}})}
                     \vspace{6pt}}))}
     "")

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

\section{Dissertation}
\cventry{@(-> 'dissertation 'year)}@;
        {@(-> 'dissertation 'location)}
        {@(-> 'dissertation 'title)}@;
        {}@;
        {Advisor: @(-> 'dissertation 'advisor)}@;
        {\url{@(-> 'dissertation 'url)}}
\vspace{6pt}

\section{Major Software Projects}
@(add-newlines
(for/list ([i (in-list (dict-ref doc 'software))])
@list{\cventry{}@;
  {@(when (-> i '(url . #f)) @~a{\url{@(-> i 'url)}})@;
    @(-> i '(note . ""))}@;
  {@(-> i 'name)}@;
  {}@;
  {}@;
  {@(-> i 'description)}
  \vspace{6pt}}))

\section{Publications}
@(add-newlines
  (for/list ([i (in-list (sort-by-year (-> 'papers)))])
    @~a{\cventry{@(-> i '(year . "Under Review"))}@;
                {@(-> i 'location 'venue)}@;
                {@(-> i 'title)}@;
                {}@;
                {}@;
                {\url{@(-> i '(url . "Under Review"))}}
        \vspace{6pt}}))

\section{Talks}
@(add-newlines
  (for/list ([i (in-list (dict-ref doc 'talks))])
    @~a{\cventry {@(-> i 'year)}@;
                 {@(-> i 'location)}@;
                 {@(-> i 'title)}@;
                 {}@;
                 {}@;
                 {\url{@(-> i 'url)}}
        \vspace{6pt}}))

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

\section{Service}
@(add-newlines
  (for/list ([i (in-list (dict-ref doc 'service))])
    @~a{\cventry {@(disp-year (-> i 'year))}@;
                 {@(-> i 'organization)}@;
                 {@(-> i 'title)}@;
                 {}@;
                 {}@;
                 {}
        \vspace{6pt}}))

\section{Awards}
@(add-newlines
  (for/list ([i (in-list (sort-by-year (-> 'awards)))])
    @~a{\cventry {@(disp-year (-> i 'year))}@;
                 {@(-> i 'organization)}@;
                 {@(-> i 'title)}@;
                 {}@;
                 {@(-> i '(position . ""))}@;
                 {}
                 \vspace{6pt}}))

\section{High Proficiency}
\subsection{Languages}
@(add-newlines
  (reverse
   (let loop ([acc '()]
              [items (sort (-> 'programming-languages) string<=?)])
     (match items
       [`() acc]
       [`(,a)
        (cons @~a{\cvitem{}{
           \begin{minipage}[t]{0.33\textwidth}
             \begin{itemize}
             \item @(latex-str a)
             \end{itemize}
           \end{minipage}}} acc)]
       [`(,a ,b)
        (cons @~a{\cvitem{}{
           \begin{minipage}[t]{0.33\textwidth}
             \begin{itemize}
             \item @(latex-str a)
             \end{itemize}
           \end{minipage}
           \begin{minipage}[t]{0.33\textwidth}
             \begin{itemize}
             \item @(latex-str b)
             \end{itemize}
           \end{minipage}}} acc)]
       [`(,a ,b ,c ,rst ...)
        (loop (cons @~a{\cvitem{}{
            \begin{minipage}[t]{0.33\textwidth}
              \begin{itemize}
              \item @(latex-str a)
              \end{itemize}
            \end{minipage}
            \begin{minipage}[t]{0.33\textwidth}
              \begin{itemize}
              \item @(latex-str b)
              \end{itemize}
            \end{minipage}
            \begin{minipage}[t]{0.33\textwidth}
              \begin{itemize}
              \item @(latex-str c)
              \end{itemize}
            \end{minipage}}} acc) rst)
        ]))))
Additional languages available on request.
\subsection{Tools and Environments}
@(add-newlines
  (reverse
   (let loop ([acc '()]
              [items (sort (-> 'tools) string<=?)])
     (match items
       [`() acc]
       [`(,a)
        (cons @~a{\cvitem{}{
           \begin{minipage}[t]{0.33\textwidth}
             \begin{itemize}
             \item @(latex-str a)
             \end{itemize}
           \end{minipage}}} acc)]
       [`(,a ,b)
        (cons @~a{\cvitem{}{
           \begin{minipage}[t]{0.33\textwidth}
             \begin{itemize}
             \item @(latex-str a)
             \end{itemize}
           \end{minipage}
           \begin{minipage}[t]{0.33\textwidth}
             \begin{itemize}
             \item @(latex-str b)
             \end{itemize}
           \end{minipage}}} acc)]
       [`(,a ,b ,c ,rst ...)
        (loop (cons @~a{\cvitem{}{
            \begin{minipage}[t]{0.33\textwidth}
              \begin{itemize}
              \item @(latex-str a)
              \end{itemize}
            \end{minipage}
            \begin{minipage}[t]{0.33\textwidth}
              \begin{itemize}
              \item @(latex-str b)
              \end{itemize}
            \end{minipage}
            \begin{minipage}[t]{0.33\textwidth}
              \begin{itemize}
              \item @(latex-str c)
              \end{itemize}
            \end{minipage}}} acc) rst)
        ]))))
Additional tools and environments available on request.

@(if (-> '(references . #f))
   @list{
     \section{References}
     @(add-newlines
       (for/list ([i (in-list (-> 'references))])
         @~a{\cventry {}@;
                      {@(-> i 'role)}@;
                      {@(-> i 'name)}@;
                      {}@;
                      {}@;
                      {\href{mailto:@(-> i 'email)}{@(-> i 'email)}}
                      \vspace{6pt}}))}
   "")

@(if (-> '(additional-experience . #f))
     @list{
       \section{Additional Experience}
       @(add-newlines
         (for/list ([i (in-list (-> 'additional-experience))])
           @list{\cvlistitem{@i}}))}
     "")

@(when (and (cover-letter) (not (cover-letter-first)))
  (cover-letter-text #f))

\end{document}
