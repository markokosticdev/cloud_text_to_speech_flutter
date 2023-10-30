import 'dart:ui';

import 'package:cloud_text_to_speech/src/common/locale/locale_helpers.dart';
import 'package:cloud_text_to_speech/src/common/tts/tts_providers.dart';
import 'package:cloud_text_to_speech/src/common/locale/locale_model.dart';
import 'package:cloud_text_to_speech/src/universal/voices/voice_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'voice_model.g.dart';

@JsonSerializable(createToJson: false)
class VoiceMicrosoft extends VoiceUniversal {
  @JsonKey(includeToJson: false)
  String provider;
  @JsonKey(name: "VoiceType", fromJson: _toEngines, includeToJson: false)
  List<String> engines;
  @JsonKey(name: "ShortName", includeToJson: false)
  String code;
  @Deprecated("Use engines instead")
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
      {this.provider = TtsProviders.microsoft,
      required this.engines,
      required this.code,
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
            provider: provider,
            engines: engines,
            code: code,
            voiceType: voiceType,
            name: name,
            nativeName: nativeName,
            gender: gender,
            locale: locale);

  factory VoiceMicrosoft.fromJson(Map<String, dynamic> json) =>
      _$VoiceMicrosoftFromJson(json);

  static List<String> _toEngines(String voiceType) {
    return [voiceType.toLowerCase()];
  }

  static VoiceLocale _toLocale(String locale) {
    List<String> localeSegments = locale.split('-');

    Locale localeObj = VoiceLocaleHelpers.segmentsToLocale(localeSegments);

    return VoiceLocaleHelpers.localeToVoiceLocale(localeObj);
  }
}
