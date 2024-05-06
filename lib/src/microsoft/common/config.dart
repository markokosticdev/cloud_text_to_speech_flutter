///Holds all configurations
class ConfigMicrosoft {
  static late final String _subscriptionKey;
  static late final String _region;

  ConfigMicrosoft._();

  static void init({required String subscriptionKey, required String region}) {
    _subscriptionKey = subscriptionKey;
    _region = region;
  }

  static String get subscriptionKey {
    if (ConfigMicrosoft._subscriptionKey.isEmpty) {
      throw Exception("Microsoft Subscription Key is not initialized");
    }
    return ConfigMicrosoft._subscriptionKey;
  }

  static String get region {
    if (ConfigMicrosoft._region.isEmpty) {
      throw Exception("Microsoft Region is not initialized");
    }
    return ConfigMicrosoft._region;
  }
}
