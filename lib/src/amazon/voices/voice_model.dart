import 'dart:ui';

import 'package:cloud_text_to_speech/src/common/utils/helpers.dart';
import 'package:cloud_text_to_speech/src/common/locale/locale_model.dart';
import 'package:cloud_text_to_speech/src/universal/voices/voice_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:locale_names/locale_names.dart';

part 'voice_model.g.dart';

@JsonSerializable(createToJson: false)
class VoiceAmazon extends VoiceUniversal {
  @JsonKey(name: "Id", includeToJson: false)
  String code;
  @JsonKey(
      name: "SupportedEngines", fromJson: _toVoiceType, includeToJson: false)
  String voiceType;
  @JsonKey(name: "Id", includeToJson: false)
  String name;
  @JsonKey(name: "Name", includeToJson: false)
  String nativeName;
  @JsonKey(name: "Gender", includeToJson: false)
  String gender;
  @JsonKey(name: "LanguageCode", fromJson: _toLocale, includeToJson: false)
  VoiceLocale locale;

  VoiceAmazon(
      {required this.code,
      required this.voiceType,
      required this.name,
      required this.nativeName,
      required this.gender,
      required this.locale})
      : super(
            code: code,
            voiceType: voiceType,
            name: name,
            nativeName: nativeName,
            gender: gender,
            locale: locale);

  factory VoiceAmazon.fromJson(Map<String, dynamic> json) =>
      _$VoiceAmazonFromJson(json);

  static String _toVoiceType(List<dynamic> supportedEngines) {
    if (supportedEngines.isNotEmpty) {
      return supportedEngines[0];
    }
    return '';
  }

  static VoiceLocale _toLocale(String locale) {
    List<String> localeSegments = locale.split('-');

    Locale localeObj = Helpers.segmentsToLocale(localeSegments);

    return VoiceLocale(
        code: localeSegments.join('-'),
        name: Helpers.formatLanguageCountry(
            localeObj.defaultDisplayLanguage, localeObj.defaultDisplayCountry),
        nativeName: Helpers.formatLanguageCountry(
            localeObj.nativeDisplayLanguage, localeObj.nativeDisplayCountry),
        languageCode: localeObj.languageCode,
        languageName: localeObj.defaultDisplayLanguage,
        nativeLanguageName: localeObj.nativeDisplayLanguage,
        countryCode: localeObj.countryCode,
        countryName: localeObj.defaultDisplayCountry,
        nativeCountryName: localeObj.nativeDisplayCountry,
        scriptCode: localeObj.scriptCode);
  }
}
