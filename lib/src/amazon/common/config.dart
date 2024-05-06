///Holds all configurations
class ConfigAmazon {
  static late final String _keyId;
  static late final String _accessKey;
  static late final String _region;

  ConfigAmazon._();

  static void init(
      {required String keyId,
      required String accessKey,
      required String region}) {
    _keyId = keyId;
    _accessKey = accessKey;
    _region = region;
  }

  static String get keyId {
    if (ConfigAmazon._keyId.isEmpty) {
      throw Exception("Amazon Key ID is not initialized");
    }
    return ConfigAmazon._keyId;
  }

  static String get accessKey {
    if (ConfigAmazon._accessKey.isEmpty) {
      throw Exception("Amazon Access Key is not initialized");
    }
    return ConfigAmazon._accessKey;
  }

  static String get region {
    if (ConfigAmazon._region.isEmpty) {
      throw Exception("Amazon Region is not initialized");
    }
    return ConfigAmazon._region;
  }
}
