module Thing.Edit.EditMain exposing (..)

import Task

import Html.App as Html
import Reuse.CmdExtras as CmdE
import Thing.Read.View as ReadView
import Reuse.Model.ModelPlus as ModelS
import Reuse.Read.Message as MsgS
import Thing.Read.Logic as Logic


testId : Int
testId = 1

initCmd : Cmd Logic.Msg
initCmd = CmdE.pure <| MsgS.InitMsg <| testId

main = Html.program
    { 
      -- model in init is not important 
      -- it is replaced when InitMsg message is processed
      init = (Logic.initModel, initCmd)
    , update = Logic.update (always Cmd.none) (always Cmd.none)
    , view = ReadView.view
    , subscriptions = always Sub.none
    }
