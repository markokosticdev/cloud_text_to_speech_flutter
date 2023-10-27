// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoiceAmazon _$VoiceAmazonFromJson(Map<String, dynamic> json) => VoiceAmazon(
      code: json['Id'] as String,
      voiceType: VoiceAmazon._toVoiceType(json['SupportedEngines'] as List),
      name: json['Id'] as String,
      nativeName: json['Name'] as String,
      gender: json['Gender'] as String,
      locale: VoiceAmazon._toLocale(json['LanguageCode'] as String),
    );
