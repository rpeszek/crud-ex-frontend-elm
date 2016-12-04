module Thing.Edit.EditMain exposing (..)

import Task

import Util.CmdExtras as CmdE
import Thing.Read.View as ReadView
import Reuse.Model.ModelPlus as ModelS
import Reuse.Read.Message as MsgS
import Thing.Read.Logic as Logic
import Util.Logger.HtmlProgram as Logger
import Util.Logger as Logger


testId : Int
testId = 1

initCmd : Cmd Logic.Msg
initCmd = CmdE.pure <| MsgS.InitMsg <| testId

main = Logger.program
    { 
      loggerConf = Logger.testLoggerConf
    , init = (Logic.initModel, initCmd)
    , update = Logic.update (always Cmd.none) (always Cmd.none)
    , view = ReadView.view
    , subscriptions = always Sub.none
    }
