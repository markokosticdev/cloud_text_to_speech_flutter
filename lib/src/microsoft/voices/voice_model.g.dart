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
      locale: VoiceMicrosoft._toLocale(json['Locale'] as String),
      sampleRateHertz: json['SampleRateHertz'] as String?,
      styleList: (json['StyleList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      status: json['Status'] as String?,
      wordsPerMinute: json['WordsPerMinute'] as String?,
    );
