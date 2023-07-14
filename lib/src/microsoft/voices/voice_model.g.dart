// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoiceMicrosoft _$VoiceMicrosoftFromJson(Map<String, dynamic> json) =>
    VoiceMicrosoft(
      code: json['ShortName'] as String,
      voiceType: json['VoiceType'] as String,
      name: json['DisplayName'] as String,
      nativeName: json['LocalName'] as String,
      gender: json['Gender'] as String,
      locale: json['Locale'] as String,
      localeName: VoiceMicrosoft._toLocaleName(json['Locale'] as String),
      nativeLocaleName:
          VoiceMicrosoft._toNativeLocaleName(json['Locale'] as String),
      styleList: (json['StyleList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      sampleRateHertz: json['SampleRateHertz'] as String,
      status: json['Status'] as String,
      wordsPerMinute: json['WordsPerMinute'] as String?,
    );
