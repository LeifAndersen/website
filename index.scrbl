#lang reader "website.rkt"

@page[#:title "Main"]{
 @div[class: "jumbotron"]{
  @div[class: "container"]{@h1{@(-> 'name 'first) @(-> 'name 'last)}}}
 @div[class: "container"]{
  @div[class: "row"]{
   @div[class: "col-sm"]{
    @img[src: "/res/Leif.jpg" alt: "Leif Andersen" style: "width:500px"]}
   @div[class: "col-sm"]{
    @h4{Email: @(-> 'email)}
    @h4{Lab: @(-> 'lab 'name)}
    @h4{Mastodon: @a[href: (-> 'mastodon 'url)]{@(-> 'mastodon 'name)}}
    @h4{Twitter: @a[href: (-> 'twitter 'url)]{@(-> 'twitter 'name)}}
    @h4{Github: @a[href: (-> 'github 'url)]{@(-> 'github 'name)}}
  }}
  @h2{Bio}
  @(-> 'research-statement)
  @h2{Papers}
  @ul[class: "list-group"]{
    @(for/list ([i (in-list (-> 'papers))]
                [id (in-naturals)])
      @li[class: "list-group-item"]{
       @div[class: "container"]{
        @div[class: "row"]{@(hash-ref i 'title)}
        @div[class: "row"]{
         @strong{Authors:@nbsp}
         @(string-join (hash-ref i 'author)  ", ")}
        @div[class: "row"]{
         @a[href: @(hash-ref i 'url)]{[Publisher PDF]}}
        @div[class: "row"]{
         @div[class: "collapse-group"]{
          @strong{Abstract:@nbsp}
          @p[class: "collapse"
             id: (format "viewabstract-~a" id)]{@(hash-ref i 'abstract)}
          @a[class: "btn" data-toggle: "collapse"
              data-target: (format "#viewabstract-~a" id)]{
           View...}}}}})}}}
