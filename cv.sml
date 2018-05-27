#lang sml

name: {first: "Leif"
       last: "Andersen"}
address: {street: "440 Huntington Ave."
          room: "308"
          city: "Boston"
          state: "MA"
          zip: "02151"
          country: "USA"}
email: "leif@leif.pl"
phone: {type: "mobile"
        number: "617-XXX-XXXX"}
website: "leif.pl"
twitter: "LeifAndersen"
github: "LeifAndersen"

research-statement: {{
 Leif Andersen is a PhD student studying programming languages in Northeastern
 University’s College of Computer and Information Science, advised by Professor
 Matthias Felleisen. She is a part of the Programming Research Laboratory (PRL)
 and studies compilers, domain specific languages for writing compilers, and
 performance tools.}}

education: [{location: NEU
             year: "2014-Present"
             degree: {{PhD in @CS}}
             advisor: "Matthias Felleisen"}
            {location: Utah
             degree: {{MS in @CS}}
             year: "2012-2014"}
            {location: Utah
             degree: {{BS in @CS}}
             year: "2009-2014"}
            {location: Utah
             degree: "BS in Computer Engineering"
             year: "2009-2014"}]

papers: [{title: "Super 8 Languages for Making Movies"
          author: ["Leif Andersen"
                   "Stephen Chang"
                   "Matthias Felleisen"]
          location: {venue: ICFP
                     series: PACMPL}
          year: 2017
          url: "https://doi.org/10.1145/3110274"
          abstract: {{
 The Racket doctrine tells developers to create languages (as libraries) to
 narrow the gap between the terminology of a problem domain and general
 programming constructs. This pearl illustrates this doctrine with the creation
 of a relatively simple domain-specific language for editing videos. To produce
 the video proceedings of a conference, for example, video professionals
 traditionally use ``non-linear'' GUI editors to manually edit each talk,
 despite the repetitive nature of the process. As it turns out, the task of
 video editing naturally splits into a declarative phase and an imperative
 rendering phase at the end. Hence it is natural to create a
 functional-declarative language for the first phase, which reduces a lot of
 manual labor. The implementation of this user-facing DSL, dubbed Video,
 utilizes a second, internal DSL to implement the second phase, which is an
 interface to a general, low-level C library. Finally, we inject type checking
 into our Video language via another DSL that supports programming in the
 language of type formalisms. In short, the development of the video editing
 language cleanly demonstrates how the Racket doctrine naturally leads to the
 creation of language hierarchies, analogous to the hierarchies of modules found
 in conventional functional languages.}}}

         {title: "Feature-Specific Profiling"
          author: ["Vincent St-Amout"
                   "Leif Andersen"
                   "Matthias Felleisen"]
          location: {venue: CC
                     series: LNCS}
          year: 2015
          url: "https://doi.org/10.1007/978-3-662-46663-6_3"
          abstract: {{
 High-level languages come with significant readability and maintainability
 benefits. Their performance costs, however, are usually not predictable, at
 least not easily. Programmers may accidentally use high-level features in ways
 that compiler writers could not anticipate, and they may thus produce
 underperforming programs as a result.

 This paper introduces feature-specific profiling, a profiling technique that
 reports performance costs in terms of linguistic constructs. With a
 feature-specific profiler, a programmer can identify specific instances of
 language features that are responsible for performance problems. After
 explaining the architecture of our feature-specific profiler, the paper
 presents the evidence in support of adding feature-specific profiling to the
 programmer’s toolset.}}}
         {title: "Concrete and Abstract Interpretation: Better Together"
          author: ["Maria Jenkins"
                   "Leif Andersen"
                   "Thomas Gilray"
                   "Matthew Might"]
          location: {venue: SCHEME}
          year: 2014
          abstract: {{
 Recent work in abstracting abstract machines provides a methodology for
 deriving sound static analyzers from a concrete semantics by way of abstract
 interpretation. Consequently, the concrete and abstract semantics are closely
 related by design. We apply Galois-unions as a framework for combining both
 concrete and abstract semantics, and explore the benefits of being able to
 express both in a single semantics. We present a methodology for creating such
 a unified representation using operational semantics and implement our approach
 with and A-normal form (ANF) λ-calculus for a CESK style machine in PLT
 Redex.}}
          url: "http://homes.soic.indiana.edu/jhemann/scheme-14/papers/Jenkins2014.pdf"}
         {title: "Multi-core Parallelization of Abstract Abstract Machines "
          authors: ["Leif Andersen"
                    "Matthew Might"]
         year: "2013"
         location: {venue: SCHEME}
         abstract: {{
 It is straightforward to derive well-known higher-order flow analyses as
 abstract interpretations of well-known abstract machines. In this paper, we
 explore multi-core parallel evaluation of one such abstract abstract machine,
 the CES machine. The CES machine is a variant of CESK machines that runs
 Continuation Passing Style (CPS) λ-calculus. Using k-CFA, the concrete
 semantics for a CES machine can be turned into abstract semantics. Analyzing a
 program for this machine is a state graph walk, which can be run in parallel to
 increase performance.}}
         url: "http://www.schemeworkshop.org/2013/papers/Andersen2013.pdf"
                 }]

teaching: [{year: "2016"
            semester: "Fall"
            position: TA
            location: NEU
            number: "CS 2500"
            name: {{Fundamentals of @CS 1}}
            description: ""}
           {year: "2014"
            semester: "Spring"
            position: TA
            location: Utah
            number: "CS 5961"
            name: "Scripting Language Design and Implementation"
            description: ""}
           {year: "2013"
            semester: "Fall"
            position: TA
            location: Utah
            number: "CS 3100"
            name: "Models of Computation"
            description: ""}
           {year: "2012-2013"
            semester: "Summer"
            position: "Instructor"
            location: Utah
            short-name: "GREAT"
            name: "Graphics & Robotics Exploration with Amazing Technology Summer Camp"
            description: ""}
           {year: "2012"
            semester: "Spring"
            position: TA
            location: Utah
            number: "CS 3700"
            name: "Digital System Design"
            description: {{
 The purpose of CS/ECE 3700 is to introduce you to the fundamental concepts of
 digital system theory and design. This includes techniques for defining and
 minimizing logic functions, design of combinational and sequential logic
 circuits, finite state machine models, design with discrete integrated circuits
 (ICs), design with Field Programmable Gate Arrays (FPGAs), and system
 controller design. By the end of the course you should be able to understand
 digital problem descriptions, design and optimize a solution, and build, test,
 and debug the resulting circuit.

 Behind any engineering system is an efficient model that allows analysis (and
 optimization) of its characteristics. Digital circuits can be easily modeled
 using concepts such as Boolean algebra. Hence Boolean algebra is a fundamental
 part of this course. This algebra allows logical decisions, analyses and
 optimizations to be made on a digital design so as to make it function
 correctly and robustly.

 This course is primarily about designing systems. "Design" is really both a
 science and an art. The science is, of course, written in the books. But how to
 interpret that science and transform it into a functioning product is an art -
 something that you learn only by experience. Hence, this course will have a
 significant portion of design-work, both via HWs and Laboratory experiments.}}}
           {year: "2011"
            semester: "Fall"
            location: Utah
            number: "CS 3810"
            name: "Computer Organization"
            description: {{
 An in-depth study of computer architecture and design, including topics such as
 RISC and CISC instruction set architectures, CPU organizations, pipelining,
 memory systems, input/output, and parallel machines. Emphasis is placed on
 performance measures and compilation issues.}}}]

software: [{name: "Video"
            description: {{
 Video is a language for making movies. It combines the power of a traditional
 video editor with the capabilities of a full programming language. Video
 integrates with the Racket ecosystem and extensions for DrRacket to transform
 it into a non-linear video editor.}}
            url: "https://lang.video/"}
           {name: "Racket"
            description: {{
 Racket is a general-purpose programming language as well as the world’s first
 ecosystem for developing and deploying new languages. Make your dream language,
 or use one of the dozens already available.}}
            url: "https://racket-lang.org/"}]

(define PL "Programming Languages")
(define IC "International Conference")
(define FP "Functional Programming")
(define CS "Computer Science")

(define Utah "University of Utah")
(define NEU "Northeastern University")

(define SCHEME {{Scheme and Functional Programming Workshop}})
(define PACMPL {{Proceedings of the ACM @PL}})
(define ICFP {{@IC on @FP}})
(define TOPLAS {{Transactions on @PL and Systems}})
(define CC {{@IC on Compiler Construction}})
(define LNCS {{Lecture Notes in @CS}})

(define TA "Teaching Assistant")
