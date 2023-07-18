import 'dart:ui';

import 'package:cloud_text_to_speech/src/common/utils/helpers.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:locale_names/locale_names.dart';

import '../../../cloud_text_to_speech.dart';

part 'voice_model.g.dart';

@JsonSerializable(createToJson: false)
class VoiceMicrosoft extends VoiceUniversal {
  @JsonKey(name: "ShortName")
  String code;
  @JsonKey(name: "DisplayName")
  String name;
  @JsonKey(name: "LocalName")
  String nativeName;
  @JsonKey(name: "Gender")
  String gender;
  @JsonKey(name: "Locale", fromJson: _toLocale, includeToJson: false)
  VoiceLocale locale;
  @JsonKey(name: "StyleList")
  List<String>? styleList;
  @JsonKey(name: "SampleRateHertz")
  String sampleRateHertz;
  @JsonKey(name: "VoiceType")
  String voiceType;
  @JsonKey(name: "Status")
  String status;
  @JsonKey(name: "WordsPerMinute")
  String? wordsPerMinute;

  VoiceMicrosoft(
      {required this.code,
      required this.voiceType,
      required this.name,
      required this.nativeName,
      required this.gender,
      required this.locale,
      required this.styleList,
      required this.sampleRateHertz,
      required this.status,
      required this.wordsPerMinute})
      : super(
            code: code,
            voiceType: voiceType,
            name: name,
            nativeName: nativeName,
            gender: gender,
            locale: locale,
            sampleRateHertz: sampleRateHertz);

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
