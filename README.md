# at_app_cli

A command line utility for app developers.

## Run The CLI Locally

When developing we want to activate our local version of at_app.  
There is a hidden flag (--local) which will also install the template using the local version of at_app.

```
flutter pub global deactivate at_app
flutter pub global activate -s path .
flutter pub global run at_app create --local [...options] [path-to-project]
```

## Run the CLI from pub.dev

```
flutter pub global activate at_app
flutter pub global run at_app create [...options] [path-to-project]
```
