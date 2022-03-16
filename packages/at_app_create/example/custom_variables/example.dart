import 'package:mason/mason.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:universal_io/io.dart';
import 'package:at_app_create/at_app_create.dart';

import 'my_brick_bundle.dart';

// Custom Vars Object for the Template
class MyCustomVars extends AtTemplateVars {
  // Add additional vars
  final String? myExtraVar;
  final String myRequiredVar;

  MyCustomVars({
    // Super class variables
    String? projectName,
    String? description,
    List<String>? dependencies,
    List<String>? flutterConfig,
    List<String>? gitignore,
    String? orgTld,
    String? orgDomainName,
    String? minSdkVersion,
    String? targetSdkVersion,
    String? compileSdkVersion,
    bool? enableR8,
    Version? kotlinVersion,
    String? gradleVersion,

    // Additional Variables
    this.myExtraVar,
    required this.myRequiredVar,
  }) : super(
          projectName: projectName,
          description: description,
          dependencies: dependencies,
          flutterConfig: flutterConfig,
          gitignore: gitignore,
          orgTld: orgTld,
          orgDomainName: orgDomainName,
          minSdkVersion: minSdkVersion,
          targetSdkVersion: targetSdkVersion,
          compileSdkVersion: compileSdkVersion,
          enableR8: enableR8,
          kotlinVersion: kotlinVersion,
          gradleVersion: gradleVersion,
        );

  @override
  // Extend the super class' toJson method
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'myExtraVar': myExtraVar,
        'myRequiredVar': myRequiredVar,
      };
}

// An empty masonBundle to use for the example...
// In practice you'd want to use an actual mason brick bundled to the dart type
MasonBundle myMasonBundle = MasonBundle.fromJson({});

// Create a class with the custom var type, and associated mason bundle
class MyCustomBundle extends AtTemplateBundle<MyCustomVars> {
  MyCustomBundle() : super(myBrickBundle);
}

// Generating the template with custom
void main() {
  // Create an instance of your custom bundle
  MyCustomBundle b = MyCustomBundle();

  // Create an instance of your vars
  MyCustomVars vars = MyCustomVars(myRequiredVar: '');

  // ... Do some modifications to the vars based on user input ...
  vars.projectName = 'my_app';

  // Finally generate the template passing in your custom vars object
  b.generate(DirectoryGeneratorTarget(Directory.current), vars);
}
