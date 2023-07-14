import 'dart:ui';

import 'package:cloud_text_to_speech/src/common/utils/helpers.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:locale_names/locale_names.dart';

import '../../universal/voices/voice_model.dart';

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
  @JsonKey(name: "Locale", includeToJson: false)
  String locale;
  @JsonKey(name: "Locale", fromJson: _toLocaleName, includeToJson: false)
  String localeName;
  @JsonKey(name: "Locale", fromJson: _toNativeLocaleName, includeToJson: false)
  String nativeLocaleName;
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
      required this.localeName,
      required this.nativeLocaleName,
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
            localeName: localeName,
            nativeLocaleName: nativeLocaleName,
            sampleRateHertz: sampleRateHertz);

  factory VoiceMicrosoft.fromJson(Map<String, dynamic> json) =>
      _$VoiceMicrosoftFromJson(json);

  static String _toLocaleName(String locale) {
    List<String> languageCountrySegments = locale.split('-');

    Locale localeObj = Locale.fromSubtags(
        languageCode: languageCountrySegments[0],
        countryCode: languageCountrySegments[1]);

    return Helpers.formatLanguageCountry(
        localeObj.defaultDisplayLanguage, localeObj.defaultDisplayCountry);
  }

  static String _toNativeLocaleName(String locale) {
    List<String> languageCountrySegments = locale.split('-');

    Locale localeObj = Locale.fromSubtags(
        languageCode: languageCountrySegments[0],
        countryCode: languageCountrySegments[1]);

    return Helpers.formatLanguageCountry(
        localeObj.nativeDisplayLanguage, localeObj.nativeDisplayCountry);
  }
}
