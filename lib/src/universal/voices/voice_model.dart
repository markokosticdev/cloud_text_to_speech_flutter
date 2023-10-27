import 'package:cloud_text_to_speech/src/common/locale/locale_model.dart';

class VoiceUniversal {
  String code;
  String voiceType;
  String name;
  String nativeName;
  String gender;
  VoiceLocale locale;

  VoiceUniversal({
    required this.code,
    required this.voiceType,
    required this.name,
    required this.nativeName,
    required this.gender,
    required this.locale,
  });
}
