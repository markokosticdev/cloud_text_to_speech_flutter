///Holds all configurations
class ConfigAmazon {
  static late final String keyId;
  static late final String accessKey;
  static late final String region;

  ConfigAmazon._();

  static void init(
      {required String keyId,
      required String accessKey,
      required String region}) {
    ConfigAmazon.keyId = keyId;
    ConfigAmazon.accessKey = accessKey;
    ConfigAmazon.region = region;
  }
}
