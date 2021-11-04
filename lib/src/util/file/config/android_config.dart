/// The default android configuration for an at_app application
const int targetSdkVersion = 30;
const int minSdkVersion = 24;
const int compileSdkVersion = 31;

const String flutterConfigGradle =
    'apply from: project(\':flutter_config\').projectDir.getPath() + "/dotenv.gradle"';

const String androidR8 = 'android.enableR8';
const String androidR8Value = 'true';
