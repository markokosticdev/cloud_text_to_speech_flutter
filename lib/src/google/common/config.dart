///Holds all configurations
class ConfigGoogle {
  static late final String _apiKey;
  static late final String? _projectId;

  ConfigGoogle._();

  static void init({required String apiKey, String? projectId}) {
    _apiKey = apiKey;
    _projectId = projectId;
  }

  static String get apiKey {
    if (ConfigGoogle._apiKey.isEmpty) {
      throw Exception("Google API Key is not initialized");
    }
    return ConfigGoogle._apiKey;
  }

  static String? get projectId {
    return ConfigGoogle._projectId;
  }
}
