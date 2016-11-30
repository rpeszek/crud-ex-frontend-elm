module Thing.Edit.EditMain exposing (..)

import Task

import Thing.Edit.Logic as Logic
import Thing.Edit.View as EditView
import Html.App as Html
import Util.CmdExtras as CmdE
import Reuse.Model.ModelPlus as ModelS
import Reuse.Edit.Message as MsgS


testId : Int
testId = 1

initCmd : Cmd Logic.Msg
initCmd = CmdE.pure <| MsgS.InitMsg <| Just testId

main = Html.program
    { 
      -- model in init is not important 
      -- it is replaced when InitMsg message is processed
      init = (Logic.initModel, initCmd)
    , update = Logic.update <| always Cmd.none
    , view = EditView.view
    , subscriptions = always Sub.none
    }
