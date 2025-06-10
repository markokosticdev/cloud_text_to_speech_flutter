import 'package:cloud_text_to_speech/src/common/locale/locale_model.dart';

class VoiceUniversal {
  String provider;
  List<String> engines;
  String code;
  String name;
  String nativeName;
  String gender;
  VoiceLocale locale;

  String isSsml;

  VoiceUniversal copyWith({
    String? provider,
    List<String>? engines,
    String? code,
    String? name,
    String? nativeName,
    String? gender,
    VoiceLocale? locale,
    String? isSsml,
  }) {
    return VoiceUniversal(
      provider: provider ?? this.provider,
      engines: engines ?? List.from(this.engines),
      code: code ?? this.code,
      name: name ?? this.name,
      nativeName: nativeName ?? this.nativeName,
      gender: gender ?? this.gender,
      locale: locale ?? this.locale,
        isSsml: isSsml??this.isSsml,
    );
  }

  VoiceUniversal({
    required this.provider,
    required this.engines,
    required this.code,
    required this.name,
    required this.nativeName,
    required this.gender,
    required this.locale,
    this.isSsml='ssml',
  });
}
