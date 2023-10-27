import 'dart:ui';

import 'package:cloud_text_to_speech/src/common/utils/helpers.dart';
import 'package:cloud_text_to_speech/src/common/locale/locale_model.dart';
import 'package:cloud_text_to_speech/src/universal/voices/voice_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:locale_names/locale_names.dart';

part 'voice_model.g.dart';

@JsonSerializable(createToJson: false)
class VoiceMicrosoft extends VoiceUniversal {
  @JsonKey(name: "ShortName", includeToJson: false)
  String code;
  @JsonKey(name: "VoiceType", includeToJson: false)
  String voiceType;
  @JsonKey(name: "DisplayName", includeToJson: false)
  String name;
  @JsonKey(name: "LocalName", includeToJson: false)
  String nativeName;
  @JsonKey(name: "Gender", includeToJson: false)
  String gender;
  @JsonKey(name: "Locale", fromJson: _toLocale, includeToJson: false)
  VoiceLocale locale;
  @JsonKey(name: "SampleRateHertz", includeToJson: false)
  String? sampleRateHertz;
  @JsonKey(name: "StyleList", includeToJson: false)
  List<String>? styleList;
  @JsonKey(name: "Status", includeToJson: false)
  String? status;
  @JsonKey(name: "WordsPerMinute", includeToJson: false)
  String? wordsPerMinute;

  VoiceMicrosoft(
      {required this.code,
      required this.voiceType,
      required this.name,
      required this.nativeName,
      required this.gender,
      required this.locale,
      this.sampleRateHertz,
      this.styleList,
      this.status,
      this.wordsPerMinute})
      : super(
            code: code,
            voiceType: voiceType,
            name: name,
            nativeName: nativeName,
            gender: gender,
            locale: locale);

  factory VoiceMicrosoft.fromJson(Map<String, dynamic> json) =>
      _$VoiceMicrosoftFromJson(json);

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
