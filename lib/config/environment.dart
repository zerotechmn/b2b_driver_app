import 'package:envied/envied.dart';

part 'environment.g.dart';

const String envFile = String.fromEnvironment(
  'ENV_FILE',
  defaultValue: ".env.staging",
);

@Envied(path: envFile, useConstantCase: true, obfuscate: true)
abstract class Env {
  @EnviedField()
  static String baseUrl = _Env.baseUrl;
  @EnviedField()
  static String deeplinkUrl = _Env.deeplinkUrl;
}
