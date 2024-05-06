// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoiceAmazon _$VoiceAmazonFromJson(Map<String, dynamic> json) => VoiceAmazon(
      provider: json['provider'] as String? ?? TtsProviders.amazon,
      engines: VoiceAmazon._toEngines(json['SupportedEngines'] as List),
      code: json['Id'] as String,
      name: json['Id'] as String,
      nativeName: json['Name'] as String,
      gender: json['Gender'] as String,
      locale: VoiceAmazon._toLocale(json['LanguageCode'] as String),
    );
