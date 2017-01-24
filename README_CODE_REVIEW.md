Naming conventions code review:
=========================================

__Root Module structure:__
* Util - contains code that could belong to/become separate libraries
* Routing - internal hash url-fragment routing as a visual component
* Reuse - component logic that makes coding each CRUD component easy
* Thing - CRUD component for 'Thing' entity (implemented on top or Reuse)
* App - bring everything together

__Leaf Module conventions:__
* Follows loosely the common View/Model/Message/Main separation, uses Logic.elm instead of more common Update.elm
* Logic module typically contains update function and often combines Model/Message if these are small
* Thing.<\*>.<\*>Main.elm modules have main methods for developing and testing sub-components (read, list, edit) in isolation.  The 'real' main is in App.Main module.

__.servant, .handcoded, .reactor, .deploy source files:__  
* There are 3 versions of Thing.Model and Thing.Http modules.  
You can switch parts of Elm code between Servant generated Elm code (sh use_servant.sh) or 'hand-coded' model, http and JSON parsing code (sh use_handcoded.sh).  The source code defaults to Servant generated. 

* There are 3 versions of StaticConfig: StaticConfig.elm, StaticConfig.reactor, and StaticConfig.deploy.  
StaticConfig.elm defaults to (is the same as) StaticConfig.reactor.  During deployment to server this code is temporarily replaced with  
StaticConfig.deploy. (see [elm_deploy_to_yesod](elm_deploy_to_yesod.sh) and [elm_deploy_to_servant](elm_deploy_to_servant.sh) files).

[back to Project](https://github.com/rpeszek/crud-ex-frontend-elm.git)
