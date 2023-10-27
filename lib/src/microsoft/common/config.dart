///Holds all configurations
class ConfigMicrosoft {
  static late final String subscriptionKey;
  static late final String region;

  ConfigMicrosoft._();

  static void init({required String subscriptionKey, required String region}) {
    ConfigMicrosoft.subscriptionKey = subscriptionKey;
    ConfigMicrosoft.region = region;
  }
}
