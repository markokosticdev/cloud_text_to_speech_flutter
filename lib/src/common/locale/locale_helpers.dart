import 'dart:ui';

import 'package:cloud_text_to_speech/cloud_text_to_speech.dart';
import 'package:cloud_text_to_speech/src/common/locale/locale_extension.dart';

class VoiceLocaleHelpers {
  VoiceLocaleHelpers._();

  static VoiceLocale localeToVoiceLocale(Locale locale) {
    return VoiceLocale(
      code: locale.toLanguageTag(),
      name: formatName(locale.defaultDisplayLanguage,
          locale.defaultDisplayScript, locale.defaultDisplayCountry),
      nativeName: formatName(locale.nativeDisplayLanguage,
          locale.nativeDisplayScript, locale.nativeDisplayCountry),
      languageCode: locale.languageCode,
      languageName: locale.defaultDisplayLanguage,
      nativeLanguageName: locale.nativeDisplayLanguage,
      countryCode: locale.countryCode,
      countryName: locale.defaultDisplayCountry,
      nativeCountryName: locale.nativeDisplayCountry,
      scriptCode: locale.scriptCode,
      scriptName: locale.defaultDisplayLanguageScript,
      nativeScriptName: locale.nativeDisplayLanguageScript,
    );
  }

  static Locale segmentsToLocale(List<String> localeSegments) {
    Map<String, String> languageCodeMap = {
      'cmn': 'zh',
      'arb': 'ar',
    };

    Map<String, String?> countryCodeMap = {
      'XA': null,
    };

    String? languageCode = localeSegments[0];
    String? scriptCode;
    String? countryCode;

    switch (localeSegments.length) {
      case 2:
        if (localeSegments[1].toUpperCase() == localeSegments[1]) {
          countryCode = localeSegments[1];
        } else {
          scriptCode = localeSegments[1];
        }
        break;
      case 3:
        if (localeSegments[1].toUpperCase() == localeSegments[1]) {
          countryCode = localeSegments[1];
        } else {
          scriptCode = localeSegments[1];
        }

        if (localeSegments[2].toUpperCase() == localeSegments[2]) {
          countryCode = localeSegments[2];
        }
        break;
      case 4:
        scriptCode = localeSegments[1];
        countryCode = localeSegments[2];
      default:
        break;
    }

    if (languageCodeMap.containsKey(languageCode)) {
      languageCode = languageCodeMap[languageCode];
    }

    if (countryCodeMap.containsKey(countryCode)) {
      countryCode = countryCodeMap[countryCode];
    }

    return Locale.fromSubtags(
      languageCode: languageCode ?? 'en',
      scriptCode: scriptCode,
      countryCode: countryCode,
    );
  }

  static String? formatName(String? language, String? script, String? country) {
    var [hasLanguage, hasScript, hasCountry] = [
      language != null && language.isNotEmpty,
      script != null && script.isNotEmpty,
      country != null && country.isNotEmpty
    ];

    if (hasLanguage && hasScript && hasCountry && script != country) {
      return '$language ($script, $country)';
    } else if (hasLanguage && hasCountry) {
      return '$language ($country)';
    } else if (hasLanguage) {
      return language;
    } else {
      return null;
    }
  }
}
