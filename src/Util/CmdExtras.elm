module Util.CmdExtras exposing (..)

import Task

pure : a -> Cmd a 
pure x = Task.perform identity identity (Task.succeed x)
