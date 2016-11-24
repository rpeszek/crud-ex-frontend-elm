module Thing.Edit.CreateMain exposing (..)

import Task

import Thing.Edit.Logic as Logic
import Thing.Edit.View as EditView
import Html.App as Html
import Reuse.CmdExtras as CmdE
import Reuse.Model.ModelPlus as ModelS
import Reuse.Edit.Message as MsgS

initCmd : Cmd Logic.Msg
initCmd = CmdE.pure <| MsgS.Init <| Nothing

main = Html.program
    { 
      init = (Logic.initModel, initCmd)
    , update = Logic.update  <| always Cmd.none
    , view = EditView.view
    , subscriptions = always Sub.none
    }
