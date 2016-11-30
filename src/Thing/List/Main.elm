module Thing.Edit.EditMain exposing (..)

import Task

import Thing.Model as BaseModel
import Html.App as Html
import Util.CmdExtras as CmdE
import Thing.List.View as ListView
import Reuse.Model.ModelEntity as ModelS
import Reuse.List.Message as MsgS
import Thing.List.Logic as Logic



initCmd : Cmd Logic.Msg
initCmd = CmdE.pure <| MsgS.InitMsg 

main = Html.program
    { 
      init = (Logic.initModel, initCmd)
    , update = Logic.update (always Cmd.none) Cmd.none
    , view = ListView.view
    , subscriptions = always Sub.none
    }
