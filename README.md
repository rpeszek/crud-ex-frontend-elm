Example frontend CRUD project in Elm.  
See my CRUD umbrella project:  [typesafe-web-polyglot](https://github.com/rpeszek/typesafe-web-polyglot.git).

__Goals:__
* Type-checked Web!
   * Typed Web API for server interaction
   * Client-side typed dispatch API using hash URL fragments
* Following TEA architecture closely
* Independent CRUD components testable in isolation and agnostic of each other 
* CRUD code reuse across crud-ed entities
* Almost-SPA (large page scopes), SPA ready design

__Features:__ 
* Elm CRUD user interface for my 'Thing' example. 
* Server interaction API generated from Servant
(see [crud-ex-backend-servant](https://github.com/rpeszek/crud-ex-backend-servant.git) and [FromServant.ThingApi](FromServant/ThingApi.elm)).
* Customizable logging of elm runtime interactions

See also: [Naming Conventions/Code Review](README_CODE_REVIEW.md)

__TODO List:__  
* Implement security and entity ownership
* List pagination support
* Add has-many relationship to example CRUD
* Logging as UI component?
* Keep rethinking styling and views 
   * should I keep using purecss?
* Improve validation

__Git:__  
I am using submodules to get dependencies/elm-purecss,  elm-purecss project is not available
as elm 0.18 package dependency.  

__Backend companion projects:__  
[crud-ex-backend-yesod](https://github.com/rpeszek/crud-ex-backend-yesod.git).  
[crud-ex-backend-servant](https://github.com/rpeszek/crud-ex-backend-servant.git) 

__To Run in elm-reactor:__  
0. Install [Elm Platform](http://elm-lang.org/)  
1. Start backend server (see backend instructions). 
2. start elm-reactor
3. point browser to elm-reactor.html 

__How to Deploy to Yesod:__  
This primitive and ugly elm_deploy_to_yesod.sh script assumes folder structure in which 
this project and
[the yesod project](https://github.com/rpeszek/crud-ex-backend-yesod.git) 
share the same parent folder.


__How to Deploy to Servant:__  
Included primitive elm_deploy_to_servant.sh script assumes folder structure in which this project and [the servant project](https://github.com/rpeszek/crud-ex-backend-servant.git) 
share the same parent folder.

__Conclusions (so far):__

* I like Elm a lot :fireworks:. Combines FP and simplicity!
* Would like to see 
   * more stable language API
   * package manager working with ported (JS FFI) projects
   * language polymorphism (is it FP if I cannot define classic denotational abstractions? How about laws and proof obligation?) 
