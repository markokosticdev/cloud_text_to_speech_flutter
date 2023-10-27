// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoiceGoogle _$VoiceGoogleFromJson(Map<String, dynamic> json) => VoiceGoogle(
      provider: json['provider'] as String? ?? TtsProviders.google,
      engines: VoiceGoogle._toEngines(json['name'] as String),
      code: json['name'] as String,
      voiceType: VoiceGoogle._toVoiceType(json['name'] as String),
      name: json['name'] as String,
      nativeName: json['name'] as String,
      gender: VoiceGoogle._toGender(json['ssmlGender'] as String),
      locale: VoiceGoogle._toLocale(json['languageCodes'] as List),
      sampleRateHertz:
          VoiceGoogle._toSampleRateHertz(json['naturalSampleRateHertz'] as int),
    );
