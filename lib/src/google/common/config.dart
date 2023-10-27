///Holds all configurations
class ConfigGoogle {
  static late final String apiKey;
  static late final String? projectId;

  ConfigGoogle._();

  static void init({required String apiKey, String? projectId}) {
    ConfigGoogle.apiKey = apiKey;
    ConfigGoogle.projectId = projectId;
  }
}
