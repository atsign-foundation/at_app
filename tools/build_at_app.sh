#!/bin/bash

CURRENT_DIR=$(pwd)

cd "$MELOS_ROOT_PATH/packages/at_app" || exit 1
dart run build_runner build --delete-conflicting-outputs
cd "$CURRENT_DIR" || exit 1
