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

[back to Project](https://github.com/rpeszek/crud-ex-frontend-elm.git)
