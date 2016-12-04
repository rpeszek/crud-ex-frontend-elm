module Thing.Edit.EditMain exposing (..)

import Task

import Thing.Model as BaseModel
import Util.CmdExtras as CmdE
import Thing.List.View as ListView
import Reuse.Model.ModelEntity as ModelS
import Reuse.List.Message as MsgS
import Thing.List.Logic as Logic
import Util.Logger.HtmlProgram as Logger
import Util.Logger as Logger



initCmd : Cmd Logic.Msg
initCmd = CmdE.pure <| MsgS.InitMsg 

main = Logger.program
    { 
      loggerConf = Logger.testLoggerConf
    , init = (Logic.initModel, initCmd)
    , update = Logic.update (always Cmd.none) (always Cmd.none)
    , view = ListView.view
    , subscriptions = always Sub.none
    }
