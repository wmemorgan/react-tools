#!/bin/bash
# Define react-tools director
REACT_TOOLS_DIR="$HOME/devtools/react-tools"
echo "React Tools directory:"
echo $REACT_TOOLS_DIR

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
create-react-app $projectname &&
cd $projectname
mkdir src/components
PROJECT_DIR=$(pwd)
echo "Project directory:"
echo $PROJECT_DIR
echo "Copying custom favicon"
cp $REACT_TOOLS_DIR/templates/public/favicon.ico $PROJECT_DIR/public/

if [ $spa = 'y' ]; then
  echo "Installing react-router-dom"
  yarn add react-router-dom
  mkdir $PROJECT_DIR/src/routes
  touch $PROJECT_DIR/src/routes/index.js
  mkdir $PROJECT_DIR/src/app
  touch $PROJECT_DIR/src/app/index.js
  echo "Created routes and app directories"
fi 

if [ $apiaccess = 'y' ]; then
  echo "Installing axios"
  yarn add axios
fi

if [ $redux = 'y' ]; then
  echo "Installing Redux components"
  yarn add redux redux-thunk react-redux redux-logger &&
  mkdir $PROJECT_DIR/src/config && touch $PROJECT_DIR/src/config/store.js &&
  mkdir $PROJECT_DIR/src/actions $PROJECT_DIR/src/reducers && touch $PROJECT_DIR/src/reducers/index.js
  echo "Created store, actions, reducers directories"
fi

if [ $styled = 'y' ]; then
  echo "Installing styled-components"
  yarn add styled-components styled-normalize
  echo "Copying custom design components"
  cp -a $REACT_TOOLS_DIR/templates/components/DesignComponents $PROJECT_DIR/src/components/
  echo "Copying custom shared components"
  cp -a $REACT_TOOLS_DIR/templates/components/SharedComponents $PROJECT_DIR/src/components/
fi

echo "List project directory contents"
ls $PROJECT_DIR
echo "Setup complete"
