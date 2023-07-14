///Holds all configurations
class ConfigGoogle {
  static late final String apiKey;

  ConfigGoogle._();

  static void init({required String apiKey}) {
    ConfigGoogle.apiKey = apiKey;
  }
}
