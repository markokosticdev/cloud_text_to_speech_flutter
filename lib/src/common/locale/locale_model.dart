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
  String? scriptName;
  String? nativeScriptName;

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
    required this.scriptName,
    required this.nativeScriptName,
  });

  VoiceLocale.code({required this.code});

  @override
  String toString() {
    return 'VoiceLocale{code: $code, name: $name, nativeName: $nativeName, languageCode: $languageCode, languageName: $languageName, nativeLanguageName: $nativeLanguageName, countryCode: $countryCode, countryName: $countryName, nativeCountryName: $nativeCountryName, scriptCode: $scriptCode, scriptName: $scriptName, nativeScriptName: $nativeScriptName}';
  }
}
