import 'package:cloud_text_to_speech/src/common/locale/locale_model.dart';

class VoiceUniversal {
  String provider;
  List<String> engines;
  String code;
  String name;
  String nativeName;
  String gender;
  VoiceLocale locale;

  VoiceUniversal({
    required this.provider,
    required this.engines,
    required this.code,
    required this.name,
    required this.nativeName,
    required this.gender,
    required this.locale,
  });

    VoiceUniversal copyWith({
    String? provider,
    List<String>? engines,
    String? code,
    String? name,
    String? nativeName,
    String? gender,
    VoiceLocale? locale,
  }) {
    return VoiceUniversal(
      provider: provider ?? this.provider,
      engines: engines ?? List.from(this.engines),
      code: code ?? this.code,
      name: name ?? this.name,
      nativeName: nativeName ?? this.nativeName,
      gender: gender ?? this.gender,
      locale: locale ?? this.locale,
    );
  }
  
}
