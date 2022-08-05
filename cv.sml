#lang sml

name: {first: "Leif"
       last: "Andersen"}
address: {street: "440 Huntington Ave."
          city: "Boston"
          state: "MA"
          zip: "02115"
          country: "USA"}
email: "leif@leif.pl"
phone: {type: "mobile"
        number: "617-373-7920"}
website: "leif.pl"
twitter: {name: "@LeifAndersen"
          url: "https://twitter.com/LeifAndersen"}
github: {name: "LeifAndersen"
         url: "https://github.com/LeifAndersen"}
lab: {name: "PRL"
      url: "http://prl.ccs.neu.edu"}

research-statement: {{Leif Andersen is a PhD student studying programming
    languages in Northeastern University’s College of Computer and Information
    Science, advised by Professor Matthias Felleisen. She is a part of the
    Programming Research Laboratory (PRL) and studies topics in Programming
    Languages and Human Computer Interaction. Specifically, she works on
    domain-specific languages for creating hybrid textual-visual programs.}}

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

papers: [{title: "Adding Interactive Visual Syntax to Textual Code"
          author: ["Leif Andersen"
                   "Michael Ballantyne"
                   "Matthias Felleisen"]
          location: {venue: OOPSLA
                     series: PACMPL}
          year: 2020
          url: "https://doi.org/10.1145/3428290"
          abstract: {{
Many programming problems call for turning geometrical thoughts into code: tables, hierarchical structures, nests of objects, trees, forests, graphs, and so on. Linear text does not do justice to such thoughts. But, it has been the dominant programming medium for the past and will remain so for the foreseeable future.

This paper proposes a novel mechanism for conveniently extending textual programming languages with problem-specific visual syntax. It argues the necessity of this language feature, demonstrates the feasibility with a robust prototype, and sketches a design plan for adapting the idea to other languages.}}}

         {title: "Super 8 Languages for Making Movies"
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
          author: ["Leif Andersen"
                   "Vincent St-Amour"
                   "Jan Vitek"
                   "Matthias Felleisen"]
          year: 2019
          location: {venue: TOPLAS}
          url: "https://doi.org/10.1145/3275519"}
         {title: "Feature-Specific Profiling"
          author: ["Vincent St-Amour"
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
          author: ["Leif Andersen"
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

teaching: [{year: "2020"
            semester: "Spring"
            position: TA
            location: NEU
            number: "CS 4400"
            name: {{Principles of Programming Languages}}
            description: {{The course plays two roles. It is primarily an
introduction to the area of programming languages, the basic concepts that
govern a software developer’s primary tool. For this role, the course provides
an idea of what it takes to parse programs, check properties before running
them, and compile and interpret them to a final answer. For variety, the course
includes many (though by no means all) linguistic constructs in modern
languages.

                           The course will, in a secondary role, also reinforce
the lessons of Fundamentals I and II plus OOD. The study of programming
languages is the oldest area in computer science, dating back to around 1930. As
such, the researchers in this area have developed the deepest understanding of
the development of programs, which is what our current introductory
curriculum (F I, II, OOD, Sw Dev) teaches. To deepen your understanding of this
connection, the course will explicitly point back to the introductory
curriculum.}}}
           {year: "2016"
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

software: [{name: "Visual and Interactive Syntax realized for ClojureScript"
            description: {{Visual and Interactive Syntax realized (VISr) for
                ClojureScript is a mechanism for extending textual programming
                languages with visual and interactive language constructs.
                Programmers are able to edit programs in their preferred IDE,
                but VISr also ships with elIDE, an IDE designed with VISr in
                mind.}}
            url: "https://visr.pl"}
           {name: "Video"
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

talks: [{title: "A Language for Making Movies"
         year: 2018
         location: BOB
         url: "https://bobkonf.de/2018/andersen.html"
         description: {{Video is a language for making movies. It combines the
             power of a traditional video editor with the capabilities of a full
             programming language. Video integrates with the Racket ecosystem
             and extensions for DrRacket to transform it into a non-linear video
             editor.

             Racket enables developers to create languages (as libraries) to
             narrow the gap between the terminology of a problem domain and
             general programming constructs. The development of the video
             editing language cleanly demonstrates how the Racket doctrine
             naturally leads to the creation of language hierarchies, analogous
             to the hierarchies of modules found in conventional functional
             languages.}}}

        {title: "Movies as Programs: The Story of a Racket"
         year: 2017
         location: RacketCon
         url: "https://con.racket-lang.org/2017/"
         description: {{Racket is more than a programming language. It is a
              programming language for making new languages. In fact, it is a
              programming language for making languages for making movies. Video
              is a language made from the sweat and parenthesis provided by the
              Racket ecosystem. It integrates into Racket from concept to final
              rendering. Come for the video demos, stay for the language tower.}}}]

service: [{title: "Video Co-Chair"
           organization: SIGPLAN
           year: "2017-2021"}]

(define PL "Programming Languages")
(define IC "International Conference")
(define FP "Functional Programming")
(define CS "Computer Science")

(define Utah "University of Utah")
(define NEU "Northeastern University")

(define SCHEME {{Scheme and Functional Programming Workshop}})
(define PACMPL {{Proceedings of the ACM @PL}})
(define ICFP {{@IC on @FP}})
(define OOPSLA {{Object-Oriented Programming, Systems, Languages & Applications}})
(define TOPLAS {{Transactions on @PL and Systems}})
(define CC {{@IC on Compiler Construction}})
(define LNCS {{Lecture Notes in @CS}})

(define BOB "BOB Konf")
(define RacketCon "RacketCon")

(define TA "Teaching Assistant")

(define SIGPLAN "ACM SIGPLAN")
