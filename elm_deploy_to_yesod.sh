## 
#  This (primivite) script assumes folder structure as in [typesafe-web-polyglot](https://github.com/rpeszek/typesafe-web-polyglot.git) 
#
#  cd crud-ex-frontend-elm
#  sh elm_deploy_to_yesod.sh
#
##

##
# Apply deployment configuration (this should go away in the future)
##
cp -f src/StaticConfig.deploy src/StaticConfig.elm

elm-make src/App/Main.elm --output=../crud-ex-backend-yesod/static/js/elm-app.js

##
# Force yesod to recompile static files
##
touch ../crud-ex-backend-yesod/Settings/StaticFiles.hs

##
# Revert configuration to elm-reactor ready
##
cp -f src/StaticConfig.reactor src/StaticConfig.elm
