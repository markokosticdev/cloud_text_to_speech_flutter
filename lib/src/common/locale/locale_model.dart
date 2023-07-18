class VoiceLocale {
  String code;
  String? name;
  String? nativeName;
  String? languageCode;
  String? languageName;
  String? nativeLanguageName;
  String? countryCode;
  String? countryName;
  String? nativeCountryName;
  String? scriptCode;

  VoiceLocale({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.languageCode,
    required this.languageName,
    required this.nativeLanguageName,
    required this.countryCode,
    required this.countryName,
    required this.nativeCountryName,
    required this.scriptCode,
  });

  VoiceLocale.code({required this.code});
}
