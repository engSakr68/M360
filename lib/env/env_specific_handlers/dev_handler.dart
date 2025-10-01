import 'package:member360/env/app_env_type.dart';
import 'package:member360/env/config_handler.dart';

Future<void> main() async {
  await handleConfig(AppEnvType.dev);
}
