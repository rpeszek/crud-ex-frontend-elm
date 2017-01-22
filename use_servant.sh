##
# Replaces bunch of *.elm files with corresponding *.servant files.
# This flips source code to to be based on Servant generated code.
# Run this before compiling to make sure servant generated code is used.
# sh use_servant.sh
##

cp -f src/Thing/Http.servant src/Thing/Http.elm

cp -f src/Thing/Model.servant src/Thing/Model.elm
