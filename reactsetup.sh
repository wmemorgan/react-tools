#!/bin/bash
# Define react-tools director
REACT_TOOLS_DIR="$HOME/devtools/react-tools"

# Determine project settings and features
echo "Project name (no spaces):"
read projectname
echo "Is this project a Single Page Application? (y/N):"
read spa
echo "Will you be accessing external APIs? (y/N):"
read apiaccess
echo "Will you be using Redux? (y/N):"
read redux
echo "Will you be using styled-components? (y/N):"
read styled

# Setup project directory and base React boilerplate files
echo "Setup project files"
create-react-app $projectname && cd $projectname && mkdir src/components &&
echo "Copying custom favicon"
cp $REACT_TOOLS_DIR/templates/public/favicon.ico $projectname/public/favicon.ico

if [ $spa = 'y' ]; then
  echo "Installing react-router-dom"
  yarn add react-router-dom &&
  mkdir src/routes && touch src/routes/index.js
  mkdir src/app && touch src/app/index.js
  echo "Created routes and app directories"
fi 

if [ $apiaccess = 'y' ]; then
  echo "Installing axios"
  yarn add axios
fi

if [ $redux = 'y' ]; then
  echo "Installing Redux components"
  yarn add redux redux-thunk react-redux redux-logger &&
  mkdir src/config && touch src/config/store.js &&
  mkdir src/actions src/reducers && touch src/reducers/index.js
  echo "Created store, actions, reducers directories"
fi

if [ $styled = 'y' ]; then
  echo "Installing styled-components"
  yarn add styled-components styled-reset &&
  echo "Copying custom design components"
  cp $REACT_TOOLS_DIR/templates/components/DesignComponents $projectname/src/components/
  echo "Copying custom shared components"
  cp $REACT_TOOLS_DIR/templates/components/SharedComponents $projectname/src/components/
fi
