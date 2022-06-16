#!/bin/bash

if [ ! -z "$GITHUB_ACTION" ];
then
  exit 0; # noop in actions environment
fi

cd $MELOS_ROOT_PATH/templates || exit 1;
dart pub global run melos bootstrap;