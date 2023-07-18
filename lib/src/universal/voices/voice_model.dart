import '../../../cloud_text_to_speech.dart';

class VoiceUniversal {
  String code;
  String voiceType;
  String name;
  String nativeName;
  String gender;
  VoiceLocale locale;
  String sampleRateHertz;

  VoiceUniversal({
    required this.code,
    required this.voiceType,
    required this.name,
    required this.nativeName,
    required this.gender,
    required this.locale,
    required this.sampleRateHertz,
  });
}
