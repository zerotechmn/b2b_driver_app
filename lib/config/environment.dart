import 'package:envied/envied.dart';

part 'environment.g.dart';

const String envFile = String.fromEnvironment(
  'ENV_FILE',
  defaultValue: ".env.prod",
);

@Envied(path: envFile, useConstantCase: true)
abstract class Env {
  @EnviedField()
  static const String baseUrl = _Env.baseUrl;
  @EnviedField()
  static const String authBaseUrl = _Env.authBaseUrl;
  @EnviedField()
  static const String deeplinkUrl = _Env.deeplinkUrl;
}
