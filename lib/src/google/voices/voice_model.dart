import 'dart:ui';

import 'package:cloud_text_to_speech/src/common/utils/helpers.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:locale_names/locale_names.dart';

import '../../../cloud_text_to_speech.dart';

part 'voice_model.g.dart';

@JsonSerializable(createToJson: false)
class VoiceGoogle extends VoiceUniversal {
  @JsonKey(name: "name", includeToJson: false)
  String name;
  @JsonKey(name: "name", includeToJson: false)
  String nativeName;
  @JsonKey(name: "name", includeToJson: false)
  String code;
  @JsonKey(name: "ssmlGender", fromJson: _toGender)
  String gender;
  @JsonKey(name: "languageCodes", fromJson: _toLocale, includeToJson: false)
  VoiceLocale locale;
  @JsonKey(
      name: "naturalSampleRateHertz",
      fromJson: _toSampleRateHertz,
      includeToJson: false)
  String sampleRateHertz;
  @JsonKey(name: "name", fromJson: _toVoiceType, includeToJson: false)
  String voiceType;

  VoiceGoogle({
    required this.code,
    required this.voiceType,
    required this.name,
    required this.nativeName,
    required this.gender,
    required this.locale,
    required this.sampleRateHertz,
  }) : super(
            code: code,
            voiceType: voiceType,
            name: name,
            nativeName: nativeName,
            gender: gender,
            locale: locale,
            sampleRateHertz: sampleRateHertz);

  factory VoiceGoogle.fromJson(Map<String, dynamic> json) =>
      _$VoiceGoogleFromJson(json);

  static String _toVoiceType(String name) {
    List<String> nameSegments = name.split('-');
    return nameSegments[2];
  }

  static String _toGender(String ssmlGender) {
    final lowercase = ssmlGender.toLowerCase();
    return lowercase[0].toUpperCase() + lowercase.substring(1);
  }

  static VoiceLocale _toLocale(List<dynamic> languageCodes) {
    if (languageCodes.isNotEmpty) {
      List<String> localeSegments = (languageCodes[0] as String).split('-');

      Locale localeObj = Helpers.segmentsToLocale(localeSegments);

      return VoiceLocale(
          code: localeSegments.join('-'),
          name: Helpers.formatLanguageCountry(localeObj.defaultDisplayLanguage,
              localeObj.defaultDisplayCountry),
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
    return VoiceLocale.code(code: '');
  }

  static String _toSampleRateHertz(int naturalSampleRateHertz) {
    return naturalSampleRateHertz.toString();
  }
}
