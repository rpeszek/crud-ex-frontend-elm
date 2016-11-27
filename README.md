Example/Template frontend CRUD project in Elm.  
See parent umbrella [typesafe-web-polyglot](https://github.com/rpeszek/typesafe-web-polyglot.git).

__Goals:__
* Type-checked Web!
   * Server-side typed Web API
   * Client-side typed dispatch/API using hash URL fragments
* Following TEA architecture closely
* CRUD code reuse across crud-ed entities
* Minimize styling decisions on Entity level (keep them reusable)
* Almost-SPA (large page scopes), SPA ready architecture.

__TODO List:__  
* Server configuration of elm programs
* Better logging
* Add has-many relationship to example CRUD
* Add owner/user (server defined, elm displayed)
* List pagination support
* Convert to Elm v.0.18
* Keep rethinking styling and views
* Improve validation

__Backend companion project:__  
Currently only Yesod implementation: [crud-ex-backend-yesod](https://github.com/rpeszek/crud-ex-backend-yesod.git).

__To Run in elm-reactor:__  
0. Install [Elm Platform](http://elm-lang.org/)  
1. Start backend server (see backend instructions) using DEV environment.
2. start elm-reactor
3. point browser to elm-reactor.html 

__How to Deploy to Yesod:__  
You can use or look at the primitive and ugly elm_deploy_to_yesod.sh file.
That file is assuming folder structure as in [typesafe-web-polyglot](https://github.com/rpeszek/typesafe-web-polyglot.git) 

__Conclusions (so far):__

* I like Elm a lot :fireworks:. Combines FP and simplicity!
* Would like to see 
   * more stable language API
   * package manager working with ported (JS FFI) projects
   * language polymorphism (is it FP if I cannot define classic denotational abstractions?) 
