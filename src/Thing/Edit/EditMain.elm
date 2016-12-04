module Thing.Edit.EditMain exposing (..)

import Task

import Thing.Edit.Logic as Logic
import Thing.Edit.View as EditView
import Util.CmdExtras as CmdE
import Reuse.Model.ModelPlus as ModelS
import Reuse.Edit.Message as MsgS
import Util.Logger.HtmlProgram as Logger
import Util.Logger as Logger


testId : Int
testId = 1

initCmd : Cmd Logic.Msg
initCmd = CmdE.pure <| MsgS.InitMsg <| Just testId

main = Logger.program
    { 
      loggerConf = Logger.testLoggerConf
    , init = (Logic.initModel, initCmd)
    , update = Logic.update <| always Cmd.none
    , view = EditView.view
    , subscriptions = always Sub.none
    }
