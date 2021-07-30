# at_app_cli

A command line utility for app developers.

## Run The CLI Locally

```
flutter pub global activate -s path .
flutter pub global run at_app create [...options] [path-to-project]
```

## Run the CLI from pub.dev

```
flutter pub global activate at_app
flutter pub global run at_app create [...options] [path-to-project]
```

## Developer Notes

Before releasing to production:

Make sure isDev is set to false in `bin/src/commands/create.dart` > \_addDependencies() > pub.add
When true pub will try to use the local version of at_app instead of from the pub-cacge.
