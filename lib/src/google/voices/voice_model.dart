import 'dart:ui';

import 'package:cloud_text_to_speech/src/common/locale/locale_helpers.dart';
import 'package:cloud_text_to_speech/src/common/locale/locale_model.dart';
import 'package:cloud_text_to_speech/src/common/tts/tts_providers.dart';
import 'package:cloud_text_to_speech/src/universal/voices/voice_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'voice_model.g.dart';

@JsonSerializable(createToJson: false)
class VoiceGoogle extends VoiceUniversal {
  @JsonKey(includeToJson: false)
  String provider;
  @JsonKey(name: "name", fromJson: _toEngines, includeToJson: false)
  List<String> engines;
  @JsonKey(name: "name", includeToJson: false)
  String code;
  @JsonKey(name: "name", includeToJson: false)
  String name;
  @JsonKey(name: "name", includeToJson: false)
  String nativeName;
  @JsonKey(name: "ssmlGender", fromJson: _toGender, includeToJson: false)
  String gender;
  @JsonKey(name: "languageCodes", fromJson: _toLocale, includeToJson: false)
  VoiceLocale locale;
  @JsonKey(
      name: "naturalSampleRateHertz",
      fromJson: _toSampleRateHertz,
      includeToJson: false)
  String? sampleRateHertz;

  VoiceGoogle({
    this.provider = TtsProviders.google,
    required this.engines,
    required this.code,
    required this.name,
    required this.nativeName,
    required this.gender,
    required this.locale,
    this.sampleRateHertz,
  }) : super(
            provider: provider,
            engines: engines,
            code: code,
            name: name,
            nativeName: nativeName,
            gender: gender,
            locale: locale);

  factory VoiceGoogle.fromJson(Map<String, dynamic> json) =>
      _$VoiceGoogleFromJson(json);

   static List<String> _toEngines(String name) {
    if (name.contains('-')) {
      List<String> nameSegments = name.split('-');
      return [nameSegments[2].toLowerCase()];
    } else {
      return [name.toLowerCase()];
    }
  }

  static String _toGender(String ssmlGender) {
    final lowercase = ssmlGender.toLowerCase();
    return lowercase[0].toUpperCase() + lowercase.substring(1);
  }

  static VoiceLocale _toLocale(List<dynamic> languageCodes) {
    if (languageCodes.isNotEmpty) {
      List<String> localeSegments = (languageCodes[0] as String).split('-');

      Locale localeObj = VoiceLocaleHelpers.segmentsToLocale(localeSegments);

      return VoiceLocaleHelpers.localeToVoiceLocale(localeObj);
    }
    return VoiceLocale.code(code: '');
  }

  static String _toSampleRateHertz(int naturalSampleRateHertz) {
    return naturalSampleRateHertz.toString();
  }
}
