import 'dart:ui';

import 'package:cloud_text_to_speech/src/common/locale/locale_helpers.dart';
import 'package:cloud_text_to_speech/src/common/locale/locale_model.dart';
import 'package:cloud_text_to_speech/src/common/tts/tts_providers.dart';
import 'package:cloud_text_to_speech/src/universal/voices/voice_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'voice_model.g.dart';

@JsonSerializable(createToJson: false)
class VoiceAmazon extends VoiceUniversal {
  @JsonKey(includeToJson: false)
  String provider;
  @JsonKey(name: "SupportedEngines", fromJson: _toEngines, includeToJson: false)
  List<String> engines;
  @JsonKey(name: "Id", includeToJson: false)
  String code;
  @JsonKey(name: "Id", includeToJson: false)
  String name;
  @JsonKey(name: "Name", includeToJson: false)
  String nativeName;
  @JsonKey(name: "Gender", includeToJson: false)
  String gender;
  @JsonKey(name: "LanguageCode", fromJson: _toLocale, includeToJson: false)
  VoiceLocale locale;

  VoiceAmazon(
      {this.provider = TtsProviders.amazon,
      required this.engines,
      required this.code,
      required this.name,
      required this.nativeName,
      required this.gender,
      required this.locale})
      : super(
            provider: provider,
            engines: engines,
            code: code,
            name: name,
            nativeName: nativeName,
            gender: gender,
            locale: locale);

  factory VoiceAmazon.fromJson(Map<String, dynamic> json) =>
      _$VoiceAmazonFromJson(json);

  static List<String> _toEngines(List<dynamic> supportedEngines) {
    if (supportedEngines.isNotEmpty) {
      return supportedEngines.map((e) => (e as String).toLowerCase()).toList();
    }
    return [];
  }

  static VoiceLocale _toLocale(String languageCode) {
    List<String> localeSegments = languageCode.split('-');

    Locale localeObj = VoiceLocaleHelpers.segmentsToLocale(localeSegments);

    return VoiceLocaleHelpers.localeToVoiceLocale(localeObj);
  }
}
