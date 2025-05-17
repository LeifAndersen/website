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
    @;@h4{Lab: @(-> 'lab 'name)}
    @h4{Github: @a[href: (-> 'github 'url)]{@(-> 'github 'name)}}
    @h4{LinkedIn: @a[href: (-> 'linkedin 'url)]{@(-> 'linkedin 'name)}}
    @h4{Matrix: @a[href: (-> 'matrix 'url)]{@(-> 'matrix 'name)}}
    @;@h4{Twitter: @a[href: (-> 'twitter 'url)]{@(-> 'twitter 'name)}}
    @h4{Bluesky: @a[href: (-> 'bluesky 'url)]{@(-> 'bluesky 'name)}}
    @h4{Discord: @a[href: (-> 'discord 'url)]{@(-> 'discord 'name)}}
  }}
  @h2{Bio}
  @(-> 'bio)

  @h2{Dissertation}
  @ul[class: "list-group"]{
    @li[class: "list-group-item"]{
      @div[class: "container"]{
        @div[class: "row"]{
          @strong{Title:@nbsp}
          @(-> 'dissertation 'title)}
        @div[class: "row"]{
         @a[style: "padding-right:0.5em;" href: @(-> 'dissertation 'url)]{[PDF]}
         @a[style: "padding-right:0.5em;" href: @(-> 'dissertation 'summary-url)]{
          [Summary Video]}
         @a[href: @(-> 'dissertation 'talk-url)]{[Defence Talk]}}
        @div[class: "row"]{
         @div[class: "collapse-group"]{
          @strong{Abstract:@nbsp}
          @p[class: "collapse"
             id: "disviewabstract"]{@(-> 'dissertation 'abstract)}
          @a[class: "btn" data-toggle: "collapse"
             data-target: "#disviewabstract"]{
           View...}}}
      }
    }
  }

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
             id: (format "talkviewabstract-~a" id)]{@(hash-ref i 'abstract)}
          @a[class: "btn" data-toggle: "collapse"
              data-target: (format "#talkviewabstract-~a" id)]{
          View...}}}}})}

  @h2{Talks}
  @ul[class: "list-group"]{
    @(for/list ([i (in-list (-> 'talks))]
                [id (in-naturals)])
      @li[class: "list-group-item"]{
       @div[class: "container"]{
        @div[class: "row"]{@(hash-ref i 'title)}
        @div[class: "row"]{
         @a[href: @(hash-ref i 'url)]{[Watch on YouTube]}}
        }})}


  @h2{Software}
  @ul[class: "list-group"]{
    @(for/list ([i (in-list (-> 'software))]
                [id (in-naturals)])
      @li[class: "list-group-item"]{
       @div[class: "container"]{
        @div[class: "row"]{@(hash-ref i 'name)}
        @div[class: "row"]{
         @a[href: @(hash-ref i 'url)]{[Project Homepage]}}
        }})}

  }}
