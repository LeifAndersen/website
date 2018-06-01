#lang reader "website.rkt"

@(require "cv.sml")

@page[#:title "Main"]{
 @div[class: "jumbotron"]{
  @div[class: "container"]{@h1{Leif Andersen}}}
 @div[class: "container"]{
  @img[src: "/res/Leif.jpg" alt: "Leif Andersen" style: "width:500px"]
  @h2{Bio}
  @a[href: "https://www.ccis.northeastern.edu/people/leif-anderson/"]{On CCIS}
  @h2{Papers}
  @ul[class: "list-group"]{
   @(for/list ([i (in-list (hash-ref doc 'papers))])
      @li[class: "list-group-item"]{
       @div[class: "container"]{
        @div[class: "row"]{@(hash-ref i 'title)}
        @div[class: "row"]{
         @a[href: @(hash-ref i 'url)]{[Publisher PDF]}}}})}}}
