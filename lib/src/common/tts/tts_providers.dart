class TtsProviders {
  TtsProviders._();

  static const String google = 'google';
  static const String microsoft = 'microsoft';
  static const String amazon = 'amazon';
  static const String combine = 'combine';

  static List<String> all() => [google, microsoft, amazon, combine];

  static List<String> allSingle() => [google, microsoft, amazon];
}
