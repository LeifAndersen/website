#!/usr/bin/env racket
#lang at-exp racket/base

(require syntax/parse/define
         scribble/html/html
         (prefix-in html: scribble/html/extra)
         racket/dict
         racket/runtime-path
         racket/path
         racket/splicing
         (except-in scribble/html/lang read read-syntax)
         web-server/servlet-env
         web-server/dispatchers/dispatch
         pkg
         pkg/lib
         (for-syntax racket/base
                     racket/string
                     racket/dict))

(provide (except-out (all-from-out scribble/html/lang)
                     #%module-begin)
         (rename-out [-module-begin #%module-begin])
         read read-syntax get-info
         page
         ->)

(define (header #:rest [rest '()] . v)
  @head{
    @meta[charset: "utf-8"]
    @meta[http-equiv: "X-UA-Compatible" content: "IE=edge"]
    @meta[name: "viewport" 'content: "width=device-width, initial-scale=1"]
    @link[rel: "stylesheet" type: "text/css" href: "/css/bootstrap.min.css"]
    @link[rel: "stylesheet" type: "text/css" href: "/css/custom.css"]
    @;@link[rel: "shortcut icon" href: "logo/tiny.png" type: "image/x-icon"]
    @title[v]{ - Leif Andersen}
    @rest})

(define (navbar . current-page)
  @html:header{
    @element["nav" class: "navbar navbar-expand-md navbar-dark fixed-top bg-dark"]{
      @div[class: "container"]{
        @a[class: "navbar-brand" href: (build-path "/" (dict-ref html-navbar-file-table "Home"))]{Home}
        @button[class: "navbar-toggler"
                type: "button"
                data-toggle: "collapse"
                data-target: "#navbarCollapse"
                aria-controls: "navbarCollapse"
                aria-expanded: "false"
                aria-label: "Toggle navigation"]{
          @span[class: "navbar-toggler-icon"]}}}})

(define (footer #:rest [rest '()] . v)
  (list*
   @html:footer[class: "container"]{
     @div[class: "copyright"]{
       @p[style: "float:left"]{Copyright © 2014-2018 Leif Andersen}}}
   @script[src: "https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"]
   @script[src: "/js/bootstrap.min.js"]
   rest))

(define (page #:title title
              #:header-rest [header-rest '()]
              #:footer-rest [footer-rest '()]
              . content)
  (list @doctype{html}
        @html[lang: "en"]{
          @header[#:rest header-rest]{@title}
          @body[id: "pn-top"]{
            @navbar[title]
            @html:main[role: "main"]{@content}
            @footer[#:rest footer-rest]}}))

(define (-> . path)
  (define cv:doc (dynamic-require "cv.sml" 'doc))
  (define-values (start path*)
    (if (and (pair? path) (dict? (car path)))
        (values (car path) (cdr path))
        (values cv:doc path)))
  (let loop ([table start]
             [path path*])
     (cond [(null? path) table]
           [(pair? (car path))
            (loop (dict-ref table (car (car path)) (cdr (car path)))
                  (cdr path))]
           [else
            (loop (dict-ref table (car path))
                  (cdr path))])))

;; ===================================================================================================

(module files-mod racket
  (provide file-table)
  (define file-table
    '(
      ("Home" . "index.scrbl")
      )))
(require 'files-mod
         (for-syntax 'files-mod))

(define-runtime-path-list files
  (list* (dict-values file-table)))

(define html-navbar-file-table
  (for/list ([f (in-list (dict-keys file-table))]
             [v (in-list (dict-values file-table))])
    (cons f (path-replace-suffix v ".html"))))

;; ===================================================================================================

;; Assumes Racket 7, with minimal backwards support for v6.10+
(define-syntax (-module-begin stx)
  (syntax-parse stx
    [(_ body ...)
     (if (string-prefix? (version) "6.1")
         ;; Old version of racket, make a best effort attempt.
         #'(#%module-begin
            (define orig-url-roots (url-roots))
            (url-roots '(("" "/" abs)))
            body ...
            (url-roots orig-url-roots))
         #'(#%module-begin
            (require racket/splicing)
            (splicing-parameterize ([url-roots '(("" "/" abs))])
              body ...)))]))

(module reader syntax/module-reader
  #:read scribble:read-inside
  #:read-syntax scribble:read-syntax-inside
  #:whole-body-readers? #t
  #:info        reader-info
  #:language (build-path this-dir "website.rkt")

  (require (prefix-in scribble: scribble/reader)
           (only-in scribble/base/reader scribble-base-reader-info)
           (only-in racket/runtime-path define-runtime-path)
           (for-syntax (only-in racket/base #%datum)))
  
  (define base-reader-info (scribble-base-reader-info))
  (define (reader-info key defvalue default)
    (case key
      [(drracket:default-filters) (cons '("Scribble HTML" "*.shtml")
                                        (or (base-reader-info key defvalue default) '()))]
      [(drracket:default-extension) "shtml"]
      [else (base-reader-info key defvalue default)]))
  
  (define-runtime-path this-dir "."))
(require 'reader)

;; ===================================================================================================

(define-runtime-path project-root-dir ".")

(define (preview)
  (serve/servlet (lambda (_) (next-dispatcher))
                 #:servlet-path "/index.html"
                 #:extra-files-paths (list project-root-dir)
                 #:port (integer-bytes->integer #"LA" #f)
                 #:listen-ip #f
                 #:launch-browser? #t))

(define (build)
  (for ([f (in-list files)])
    (unless (equal? (path-get-extension f) #".html")
      (with-output-to-file (path-replace-suffix f ".html")
        #:exists 'replace
        (lambda ()
          (dynamic-require f 0))))))

(define deps '("sml"))

(define (install-deps)
  (for ([i (in-list deps)])
    (cond [(and (hash-has-key? (installed-pkg-table) i))
           (pkg-update-command #:deps 'search-auto i #:no-setup #t)]
          [else
           (pkg-install-command #:deps 'search-auto i #:no-setup #t)])))

(module+ main
  (require racket/cmdline)
  (void
   (command-line
    #:program "Leif Andersen Website"
    #:once-each
    [("-d" "--deps") "Install the required deps to build the website"
     (install-deps)]
    [("-b" "--build") "Build Website"
     (build)]
    [("-p" "--preview") "Preview Website"
     (preview)]
    )))
