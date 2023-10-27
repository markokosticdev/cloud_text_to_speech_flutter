import 'package:cloud_text_to_speech/src/common/locale/locale_model.dart';

class VoiceUniversal {
  String provider;
  List<String> engines;
  String code;
  @Deprecated("Use engines instead")
  String voiceType;
  String name;
  String nativeName;
  String gender;
  VoiceLocale locale;

  VoiceUniversal({
    required this.provider,
    required this.engines,
    required this.code,
    required this.voiceType,
    required this.name,
    required this.nativeName,
    required this.gender,
    required this.locale,
  });
}
