##
# Replaces bunch of *.elm files with corresponding *.handcoded files.
# This flips source code so is NOT based on Servant generated code.
# Run this before compiling to make sure servant generated code is NOT used.
#  sh use_handcoded.sh
##

cp -f src/Thing/Http.handcoded src/Thing/Http.elm

cp -f src/Thing/Model.handcoded src/Thing/Model.elm
