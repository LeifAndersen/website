#lang at-exp racket/base

(require syntax/parse/define
         scribble/html/html
         racket/dict
         racket/runtime-path
         (except-in scribble/html/lang read read-syntax)
         (for-syntax racket/base
                     racket/dict))

(provide (except-out (all-from-out scribble/html/lang)
                     #%module-begin)
         (rename-out [~module-begin #%module-begin])
         read read-syntax get-info
         page)

@(define (header #:rest [rest '()] . v)
   @head{
     @meta[charset: "utf-8"]
     @meta[http-equiv: "X-UA-Compatible" content: "IE=edge"]
     @meta[name: "viewport" 'content: "width=device-width, initial-scale=1"]
     @link[rel: "stylesheet" type: "text/css" href: "/css/bootstrap.min.css"]
     @link[rel: "stylesheet" type: "text/css" href: "/css/pygments.css"]
     @link[rel: "stylesheet" type: "text/css" href: "/css/scribble.css"]
     @link[rel: "stylesheet" type: "text/css" href: "/css/custom.css"]
     @link[rel: "shortcut icon" href: "logo/tiny.png" type: "image/x-icon"]
     @title[v]{ - Leif Andersen}
     @rest})

@(define (navbar . current-page)
   @element/not-empty["nav" class: "navbar navbar-inverse navbar-fixed-top"]{
     @div[class: "navbar-inner"]{
       @div[class: "container"]{
         @div[id: "navbar" class: "navbar-collapse collapse"]{
           @ul[class: "nav navbar-nav pull-right"]{
             @(for/list ([title-pair (in-list html-navbar-file-table)])
               (cond
                 [(equal? (car title-pair) (car current-page))
                  @li[role: "presentation" class: "active"]{@a[href: "#" (car title-pair)]}]
                 [else @li[role: "presentation"]{@a[href: (build-path "/" (cdr title-pair)) (car title-pair)]}]))}}}}})

@(define (footer #:rest [rest '()] . v)
   (list*
    @div[class: "footer-color"]{
    @div[class: "container"]{
      @element/not-empty["footer" class: "footer float:right"]{
        @div[class: "copyright"]{
          @p[style: "float:left"]{Copyright © 2014-2018 Leif Andersen}}
        @div[class: "pull-right"]{
          @img[src: "/logo/tiny.png" alt: "Video Logo" height: "25" width: "25"]}}}}
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
            @content
            @footer[#:rest footer-rest]}}))

;; ===================================================================================================

(module files-mod racket
  (provide file-table)
  (define file-table
    '(
      ("Home"              . "index.scrbl")
      )))
(require 'files-mod
         (for-syntax 'files-mod))

(define-runtime-path-list files
  (list* "blog/_src/page-template.scrb2"
         "pub/icfp2017/errata.scrbl"
         (dict-values file-table)))

(define html-navbar-file-table
  (for/list ([f (in-list (dict-keys file-table))]
             [v (in-list (dict-values file-table))])
    (cons f (path-replace-suffix v ".html"))))

;; ===================================================================================================

(define-simple-macro (~module-begin body ...)
   (#%module-begin
    (require racket/splicing)
    (splicing-parameterize ([url-roots '(("" "/" abs))])
      body ...)))

(module reader syntax/module-reader
  #:read scribble:read-inside
  #:read-syntax scribble:read-syntax-inside
  #:whole-body-readers? #t
  #:info        (scribble-base-reader-info)
  #:language (build-path this-dir "website.rkt")

  (require (prefix-in scribble: scribble/reader)
           (only-in scribble/base/reader scribble-base-reader-info)
           (only-in racket/runtime-path define-runtime-path)
           (for-syntax (only-in racket/base #%datum)))
  (define-runtime-path this-dir "."))
(require 'reader)
