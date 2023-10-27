import 'package:cloud_text_to_speech/src/universal/voices/voice_model.dart';

class TtsParamsUniversal {
  final VoiceUniversal voice;
  final String text;
  final String audioFormat;
  final String rate;
  final String pitch;

  TtsParamsUniversal({
    required this.voice,
    required this.text,
    required this.audioFormat,
    required this.rate,
    required this.pitch,
  });
}
