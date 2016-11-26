
cp -f src/ServerConfig.deploy src/ServerConfig.elm
elm-make src/App/Main.elm --output=elm-app.js

cp -f src/ServerConfig.test src/ServerConfig.elm
